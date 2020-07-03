require_relative 'boot'

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BuchelFamily
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Overrides layouts for clearance. (@TODO)
    # config.to_prepare do
    #   Clearance::PasswordsController.layout "my_passwords_layout"
    #   Clearance::SessionsController.layout "my_sessions_layout"
    #   Clearance::UsersController.layout "my_admin_layout"
    # end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

  end
end


