class Port < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.health_check
    self.all.each do |port|
      port.ping
    end
  end

  def ping
    (1..4).each do |i|
      HTTParty.get("http://#{machine.ip_address}#{self.port + i}/ping")
    end
  end
end
