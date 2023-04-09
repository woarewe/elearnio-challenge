# frozen_string_literal: true

ActiveSupport::Dependencies.autoload_paths.delete(Rails.root.join("app/types").to_s)
ActiveSupport::Dependencies.autoload_paths.delete(Rails.root.join("app/entities").to_s)
ActiveSupport::Dependencies.autoload_paths.delete(Rails.root.join("app/services").to_s)
ActiveSupport::Dependencies.autoload_paths.delete(Rails.root.join("app/repositories").to_s)

Rails.autoloaders.main.push_dir(Rails.root.join("app/types"), namespace: Types)
Rails.autoloaders.main.push_dir(Rails.root.join("app/entities"), namespace: Types)
Rails.autoloaders.main.push_dir(Rails.root.join("app/services"), namespace: Services)
Rails.autoloaders.main.push_dir(Rails.root.join("app/repositories"), namespace: Repositories)

Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    "db" => "DB",
    "public_id" => "PublicID",
    "id" => "ID",
    "with_public_id" => "WithPublicID",
    "rest" => "REST",
    "api" => "API"
  )
end
