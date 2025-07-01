require "rails/generators"

module PwaBuilder
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_workbox_files
        say "Installing Workbox JavaScript files...", :green
        directory "workbox", "vendor/javascript/workbox"
      end

      def create_service_worker_initializer
        empty_directory "app/javascript/initializers"
        copy_file "initializer.js", "app/javascript/initializers/service_worker_initializer.js"
      end

      def add_initializer_to_import_map
        append_to_file "config/importmap.rb", <<~RUBY
          pin "initializers/service_worker_initializer", to: "initializers/service_worker_initializer.js"
        RUBY
      end

      def print_guidance
        say <<~GUIDANCE, :green

          Add the following line to your application.js file

          import { registerServiceWorker } from 'initializers/service_worker_initializer';

          window.addEventListener('load', () => {
            registerServiceWorker();
          });
        GUIDANCE
      end
    end
  end
end
