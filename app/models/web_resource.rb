class WebResource < Resource
  def self.provision!(params)
    web = self.new
    web.machine_id = Machine.first.id
    web.save!

    $REDIS.publish("nginx_provision", "update")
  end
end
