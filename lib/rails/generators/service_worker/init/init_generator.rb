require "rails/generators"

module PwaBuilder
  module Generators
    class InitGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def do_something
        puts 'gotta do something'
      end

      def another_thing
        puts 'gotta do another thing'
      end

      # def create_config_files
      #   empty_directory "config/service_worker"
      #   copy_file "init.js", "config/service_worker/init.js"
      #   copy_file "precache.js", "config/service_worker/precache.js"
      #   copy_file "routes.js", "config/service_worker/routes.js"
      # end

      # def inject_registration_into_application_js
      #   js_file = "app/javascript/application.js"
      #   registration_code = <<-JS

# // Service Worker registration added by generator
# if ('serviceWorker' in navigator) {
  # window.addEventListener('load', () => {
    # navigator.serviceWorker.register('/service-worker.js')
      # .then(reg => {
      #   console.log("✅ Service Worker registered:", reg);
      # })
      # .catch(err => {
      #   console.error("❌ Service Worker registration failed:", err);
      # });
  # });
# }
      #   JS

      #   if File.exist?(js_file)
      #     unless File.read(js_file).include?("navigator.serviceWorker.register")
      #       append_to_file js_file, registration_code
      #     else
      #       say_status("skip", "Service Worker registration already present in #{js_file}", :yellow)
      #     end
      #   else
      #     say_status("error", "Could not find #{js_file} to inject Service Worker registration.", :red)
      #   end
      # end
    end
  end
end
