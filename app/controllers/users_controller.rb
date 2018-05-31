# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :redirect_if_signed_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @my_projects = Project.joins(:project_accesses).where(project_accesses: { owner: true, user_id: @user.id })
    @shared_projects = Project.joins(:project_accesses).where(project_accesses: { owner: false, user_id: @user.id })

    puts "Found #{@my_projects.count} projects for me!"
    puts "Found #{@shared_projects.count} projects shared with me."
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
    )
  end
end
