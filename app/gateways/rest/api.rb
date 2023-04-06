# frozen_string_literal: true

module REST
  class API < Grape::API
    format "json"
    prefix "api"

    helpers(
      Helpers::Validation,
      Helpers::Pagination,
      Helpers::DB
    )

    PER_PAGE_LIMIT = 100
    PER_PAGE_DEFAULT = 50

    namespace(:talents) { mount Talents }
    namespace(:courses) { mount Courses }
    namespace(:learning_paths) { mount LearningPaths }

    add_swagger_documentation mount_path: "/swagger"
  end
end
