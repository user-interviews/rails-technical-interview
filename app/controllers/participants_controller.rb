# frozen_string_literal: true

class ParticipantsController < ApplicationController
  def new
    @participant = Participant.new
  end

  def create
    @partition = Participant.new(params[:participant].to_h)

    if @participant.save!
      redirect_to participant_path(@participant)
    else
      render :new
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])

    @participant.update_attributes(update_params)
    @participant.update_attribute(password: params[:participant][:password]) unless @participant.errors.size > 0 || @participant.password != params[:previous_password]
  end

  private

  def update_params
    params.require(:participant).permit(
      :first_name,
      :last_name,
      :email,
    )
  end
end
