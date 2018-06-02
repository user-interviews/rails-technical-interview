# frozen_string_literal: true

module Emails
  EMAIL_FORMAT_REGEX = /[^@]*@[^\.]*\..*/

  def self_email(to_email, template, vars = {})
    Mandrill.send_email(
      template,
      to: to_email,
      vars: vars,
    )
  end
end
