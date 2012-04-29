class DeployService
  @queue = :deploy

  def self.perform(service_id)
    service = Service.find(serice_id)

    machine = service.data['machine']
    system "ssh #{machine} ~/bin/deploy.sh #{service.id}"
  end

end
