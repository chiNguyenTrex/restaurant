require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module RestaurantServices
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**',
      '*.{rb,yml}')]
    config.i18n.default_locale = :vi
    config.i18n.available_locales = [:en, :vi]
    config.generators do |generator|
      generator.assets false
      # generator.view_specs false
    end
    config.generators.system_tests = nil
  end
end
