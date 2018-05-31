# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :redirect_unless_signed_in, only: [:create, :new, :share]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      @project.owner = current_user
      @project.save!

      flash_success('Project created!')
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    redirect_if_not_owner(@project)
  end

  def share
    @project = Project.find(params[:id])
    redirect_if_not_owner(@project)
  end

  def perform_share
    @project = Project.find(params[:id])

    user = User.find(params[:user_id])
    access = ProjectAssecc.new(user_id: user.id, :project_id => project.id)

    access.save

    render 'share'
  end

  def revoke_share
    ProjectAccess.where("user_id = #{params[:user_id]} AND project_id = #{params[:project_id]}").first.delete

    redirect_to "/projects/#{params[:project_id]}"
  end

  private

  def project_params
    params.require(:project).permit(
      :compensation_amount,
      :internal_name,
      :interview_type,
      :public_title,
      :requested_participants,
    )
  end

  def redirect_if_not_owner(project)
    if !signed_in? || !project.owner?(current_user)
      flash_error('Unauthorized access')
      redirect_to root_path
    end
  end
end
