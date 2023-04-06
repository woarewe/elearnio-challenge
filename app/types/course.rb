# frozen_string_literal: true

module Types
  class Course < Struct
    include Entity

    Error = Class.new(StandardError)
    AlreadyPublishedError = Class.new(Error)
    SameAuthorError = Class.new(Error)

    def published?
      properties.status == Status::PUBLISHED
    end

    def draft?
      properties.status == Status::DRAFT
    end

    def publish!
      published_guard! { update_status(Status::PUBLISHED) }
    end

    def change_author!(author)
      raise SameAuthorError if author == properties.author

      update_author(author)
    end

    def update_content!(content)
      published_guard! { update_content(content) }
    end

    def update_name!(name)
      published_guard! { update_name(name) }
    end

    private :update_properties

    private

    def published_guard!
      raise AlreadyPublishedError if published?

      yield
    end

    def update_status(status)
      updated_properties = Properties.new(properties.to_h.merge(status:))
      update_properties(updated_properties)
    end

    def update_content(content)
      updated_properties = Properties.new(properties.to_h.merge(content:))
      update_properties(updated_properties)
    end

    def update_name(name)
      updated_properties = Properties.new(properties.to_h.merge(name:))
      update_properties(updated_properties)
    end

    def update_author(author)
      updated_properties = Properties.new(properties.to_h.merge(author:))
      update_properties(updated_properties)
    end
  end
end
