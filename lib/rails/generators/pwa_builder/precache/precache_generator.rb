require "rails/generators"

module PwaBuilder
  module Generators
    class PrecacheGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def do_something
        puts 'gotta do something in precache'
      end

      def another_thing
        puts 'gotta do another thing in precache'
      end
    end
  end
end
