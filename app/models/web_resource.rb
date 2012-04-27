class WebResource < Resource
  def provision!
    service_name = "#{self.service.name}_#{self.id}"

    self.data = {
      :machine => "",
      :ip_address => ""
    }

    self.save!
  end
end
