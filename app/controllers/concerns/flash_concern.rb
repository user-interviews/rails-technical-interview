# frozen_string_literal: true

module FlashConcern
  extend ActiveSupport::Concern

  def flash_error(message)
    flash_message(message, :danger)
  end

  def flash_error_now(message)
    flash_message_now(message, :danger)
  end

  def flash_success(message)
    flash_message(message, :success)
  end

  def flash_success_now(message)
    flash_message_now(message, :success)
  end

  private

  def flash_message(message, level)
    flash[level] = message
  end

  def flash_message_now(message, level)
    flash.now[level] = message
  end
end
