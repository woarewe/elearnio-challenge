# frozen_string_literal: true

module Types
  Email = String.constrained(format: URI::MailTo::EMAIL_REGEXP)
end
