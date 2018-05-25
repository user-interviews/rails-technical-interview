# frozen_string_literal: true

class UserSessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      sign_in(user)
      redirect_to user_path(user)
    else
      flash_error_now('Invalid email / password combination')
      render :new
    end
  end

  def delete
    sign_out

    redirect_to sign_in_path
  end
end
