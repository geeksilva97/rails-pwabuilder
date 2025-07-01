module PwaBuilder
  module Services
    class FindServiceWorker
      def self.call
        new.call
      end

      def call
        service_worker_paths.find { |path| File.exist?(path) }
      end

      private

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
