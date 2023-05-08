module Sidekiq
  module Cron
    module Tasks
      class Configuration
        attr_accessor :file, :prefix

        def initialize
          @file = ::Rails.root.join("config", "sidekiq_cron.yml")
          @prefix = "sidekiq_cron"
        end

        def file
          @file || @default_file.call
        end

        def schedule
          @schedule ||= load_yaml.fetch(::Rails.env, {})
        end

        def load_yaml
          return {} unless File.exist?(file)

          YAML.respond_to?(:unsafe_load) ? YAML.unsafe_load_file(file) : YAML.load_file(file)
        end
      end
    end
  end
end
