class ProvisionService
  @queue = :provision

  def self.perform(service_id)
    @service = Service.find(service_id)

    @service.resources.each do |resource|
      resource.provision!
    end
  end
end
