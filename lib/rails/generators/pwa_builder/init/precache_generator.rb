require "rails/generators"

module PwaBuilder
  module Generators
    class PrecacheGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def do_something
        puts 'gotta do something in another generator'
      end

      def another_thing
        puts 'gotta do another thing in another generator'
      end
    end
  end
end
