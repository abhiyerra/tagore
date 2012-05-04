class SharedService < Service

  # Just create a basic service
  def self.provision!(service)
    Service.transaction do
      @service = SharedService.new(service)

      @mysql_resource = MysqlResource.create(:service_id => @service.id)
      @mysql_resource.provision!

      @web_resource = WebResource.create(:service_id => @service.id)
      @web_resource.provision!
    end
  end

  def move_database_to_unshared
    mysql = self.resources.where(:type => MysqlResource)
    mysql.move
  end

end
