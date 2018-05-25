# frozen_string_literal: true

module SessionsConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :signed_in?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    return @current_user if @current_user

    token = UserRememberToken.find_valid_token(cookies[:user_id], cookies[:remember_token])
    token&.trigger_used!

    # Cache and return the current user
    @current_user = token&.user
  end

  def redirect_if_signed_in
    redirect_to user_path(current_user) if signed_in?
  end

  def redirect_unless_signed_in
    redirect_to sign_in_path unless signed_in?
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = UserRememberToken.create_token_for_user!(user)
    cookies.permanent[:user_id] = user.id
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    if signed_in?
      token = UserRememberToken.find_valid_token(cookies[:user_id], cookies[:remember_token])
      token&.destroy
    end

    cookies.delete(:remember_token)
    cookies.delete(:user_id)
    self.current_user = nil
  end
end
