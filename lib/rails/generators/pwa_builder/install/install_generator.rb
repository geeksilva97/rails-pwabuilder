require "rails/generators"

module PwaBuilder
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_workbox_files
        say "Installing Workbox JavaScript files...", :green
        # moving to public to bypass digest assets
        directory "workbox", "public/workbox"
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

      def import_workbox_into_service_worker
        service_worker_file = find_service_worker_file

        if service_worker_file
          say "Importing Workbox into service worker...", :green
          content = File.read(service_worker_file)
          unless content.include?("importScripts('workbox/workbox-sw.js');")
            prepend_to_file service_worker_file, <<~JS

            const { precacheAndRoute } = workbox.precaching;
            const { registerRoute } = workbox.routing;
            const { StaleWhileRevalidate } = workbox.strategies;

            const matchCb = ({url, request, event}) => {
              return request.method === 'GET';
            };

            registerRoute(matchCb, new StaleWhileRevalidate({
              matchOptions: {
                ignoreVary: true
              }
            }));

            precacheAndRoute([
              {url: '/', revision: null},
            ]);
            JS
            prepend_to_file service_worker_file, "importScripts('workbox/workbox-sw.js');\n"
            say_status "updated", service_worker_file, :green
          else
            say_status "skip", "#{service_worker_file} already imports Workbox", :yellow
          end
        else
          say_status "error", "Service worker file not found. Please create one at app/views/pwa/service-worker.js", :red
        end
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

      private

      def find_service_worker_file
        service_worker_paths.find { |path| File.exist?(path) }
      end

      def service_worker_paths
        [
          service_worker_path(".js"),
          service_worker_path(".js.erb")
        ]
      end

      def service_worker_path(extension)
        File.join("app", "views", "pwa", "service-worker#{extension}")
      end
    end
  end
end
