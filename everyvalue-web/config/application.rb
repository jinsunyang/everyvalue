require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EveryvalueWeb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.time_zone = 'Seoul'

    #active record로 db에 저장될 때의 timezone - 이거 하고 바로 해결 됨
    config.active_record.default_timezone = :local

    # devise 등에서 사용하는 i18n message를 변경하기 위해 default_locale 설정
    config.i18n.default_locale = :ko

    # 배포 stage 별 환경변수 적용
    Dotenv.load("#{Rails.env}.env")
  end
end
