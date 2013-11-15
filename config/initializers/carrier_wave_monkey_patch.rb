module CarrierWave
  module Uploader
    module Cache
      private

      STDERR.puts "Re-defining..."

      def cache_path
        require 'debugger'; debugger
        File.expand_path(File.join(cache_dir, cache_name), root)
      end
    end
  end
end
