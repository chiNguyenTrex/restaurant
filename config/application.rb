require_relative 'boot'

require "rails/all"
# Pick the frameworks you want:

# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RestaurantServices
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    #config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.

    config.generators do |generator|
      generator.assets false
      # generator.view_specs false
    end
    config.generators.system_tests = nil
  end
end
