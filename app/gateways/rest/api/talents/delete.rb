# frozen_string_literal: true

module REST
  class API
    class Talents
      class Delete < Base
        class Contract < Dry::Validation::Contract
          json do
            required(:new_author_id).filled(::Types::ID::Public)
          end
        end

        helpers do
          def find_new_author!
            validate!(params, with: Contract) => { new_author_id: id }
            ::Talent.find_by_public_id(id).tap { |talent| not_found!(:new_author_id) if talent.nil? }
          end

          def transfer_courses!(courses, new_author)
            courses.each { |course| ::Course.save!(course.change_author!(new_author)) }
          rescue ::Types::Course::SameAuthorError
            invalid!(:new_author_id, I18n.t!("rest.talents.errors.same_author"))
          end
        end

        desc "Delete a talent"
        delete do
          status 204
          talent = find_requested_talent!
          courses = ::Course.filter_by_author(talent).map(&:entity)
          transaction do
            transfer_courses!(courses, find_new_author!) if courses.any?
            ::Talent.delete(talent.private_id)
          end
        end
      end
    end
  end
end
