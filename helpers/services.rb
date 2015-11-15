require_relative '../lib/config'

module BeaverApp
  module Services
    extend self
    def port_open?(ip, port, seconds=1)
    Timeout::timeout(seconds) do
      begin
        TCPSocket.new(ip, port).close
        true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        false
      end
    end
    rescue Timeout::Error
    false
    end

    def services
    %W(tftp postgres)
    end

    services.each do |s|
      define_method("#{s}_running?") do
       port_open?(Config.send(s)['host'], Config.send(s)['port'])
      end
    end
  end
end
