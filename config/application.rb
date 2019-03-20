require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Surfable
  class Application < Rails::Application
    config.load_defaults 5.2
    config.paths.add File.join('app', 'services', 'lib'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'services', 'lib', '*')]
    config.eager_load_paths << "#{Rails.root}/lib"
  end
end
