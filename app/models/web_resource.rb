class WebResource < Resource
  def self.provision!(params)

    self.data = {
      :machine => "",
      :ip_address => "",
      :port => ""
    }

    self.save!
  end
end
