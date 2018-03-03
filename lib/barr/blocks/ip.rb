require 'barr/block'

module Barr
  module Blocks
    class IP < Block
      attr_reader :device

      def initialize(opts = {})
        super
        @device = opts[:device] || 'lo'
        @version = opts[:ipv6] ? 'inet6' : 'inet'
      end

      def update!
        ip = sys_cmd.split('/').first

        @output = "#{@device} > #{ip}"
      end

      private

      def sys_cmd
        `ip addr show #{@device} | grep '#{@version}\s' | awk '{print $2}'`.chomp
      end
    end
    Ip = IP
  end
end
