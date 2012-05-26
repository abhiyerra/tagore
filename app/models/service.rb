class Service < ActiveRecord::Base
  attr_accessible :description, :name, :repo

  validates :name, :uniqueness => { :case_sensitive => false }
  validates :name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed" }

  has_many :resources
  has_many :deploys
  has_many :ports

  DEPLOY_COMMAND = "deploy"
  PROVISION_ROUTER_COMMAND = "nginx_provision"

  before_save do
    self.name.downcase!
  end

  def listeners
    ports.where(:service_id => self.id).map do |port|
      (1..4).map do |i|
        "#{port.machine.ip_address}:#{port.port + i}"
      end
    end.flatten
  end


  def deploy!
    $REDIS.publish(DEPLOY_COMMAND, "#{self.id.to_s} HEAD")
  end

  def started!(machine_id, port)
    Port.create(:machine_id => machine_id, :service_id => self.id)
    $REDIS.publish(PROVISION_ROUTER_COMMAND, "update")
  end

  def stopped!(machine_id)
    Port.where(:machine_id => machine_id, :service_id => self.id).each(&:destroy)
  end

end
