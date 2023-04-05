# frozen_string_literal: true

ActiveSupport::Dependencies.autoload_paths.delete(Rails.root.join("app/types").to_s)

Rails.autoloaders.main.push_dir(Rails.root.join("app/types"), namespace: Types)

Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    "db" => "DB",
    "public_id" => "PublicID",
    "id" => "ID"
  )
end
