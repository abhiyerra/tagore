class WebResource < Resource
  def self.provision!(params)
    web = self.create(params)
    web.machine = Machine.where(:tag => "web").first
    web.save!

    $REDIS.publish("nginx_provision", "update")
  end
end
