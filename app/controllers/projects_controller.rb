# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :redirect_unless_signed_in, only: [:create, :new]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params.merge(user: current_user))

    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
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
end
