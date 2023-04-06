# frozen_string_literal: true

module Types
  Email = Dry::Types["string"].constrained(format: URI::MailTo::EMAIL_REGEXP)
end
