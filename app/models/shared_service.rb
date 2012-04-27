class SharedService < Service

  def self.provision!(service)
    Service.transaction do
      @service = SharedService.new(service)

      @mysql_resource = MysqlResource.create(:service_id => @service.id)
      @web_resource = WebResource.create(:service_id => @service.id)
    end
  end
end
