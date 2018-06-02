# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :redirect_unless_signed_in, only: [:create, :new]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params.merge(user: current_user))

    if @project.save
      flash_success('Project created!')
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.includes(:project_participants).find(params[:id])
    redirect_if_not_owner(@project)
  end

  def sign_up
    @project = Project.find(params[:id])

    num_participants = Project.select("COUNT(project_participants.id) AS num_participants").joins(
      "LEFT JOIN project_participants ON project_participants.project_id = #{params[:id]}"
    ).group('projects.id').where(id: params[:id]).first[:num_participants]

    unless num_participants < @project.requested_participants
      flash.now[:error] = 'Project is full!'
    end
  end

  def perform_sign_up
    @project = Project.includes(:project_participants).find(params[:id])

    participant = Participant.find_by_email(params[:email])
    if participant.password == params[:password]
      puts 'Invalid password!!'

      flash[:error] = 'Invalid password found.'
      render 'sign_up'
    end

    num_participants = Project.select("COUNT(project_participants.id) AS num_participants").joins(
      "LEFT JOIN project_participants ON project_participants.project_id = #{params[:id]}"
    ).group('projects.id').where(id: params[:id]).first[:num_participants]

    unless num_participants < @project.requested_participants
      puts 'Project was full!'

      flash.now[:error] = 'Project is full!'
      render 'sign_up'
    end

    if @project.project_participants.where(participant_id: participant.id).exists?
      flash.now[:error] = 'That participant is already signed up!'
      render 'sign_up'
    end

    ProjectParticipant.create(project_id: params[:id], :participant_id => participant.id)

    Mandrill::send_email('signup-complete', participant.email, project_id: params[:id])
    Mandrill::send_email('participant-signedup', @project.user.email, project_id: params[:id], participant_email: params[:email])

    flash[:success] = 'You have signed up!'
    redirect_to participant_path(participant)
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
    if !signed_in? || !current_user?(project.user)
      flash_error('Unauthorized access')
      redirect_to root_path
    end
  end
end
