require 'fog'

class Ec2Machine < Machine
  def self.provision
    connection = self.connect
    server = connection.servers.create

    machine = self.create({
        :data => {
          :id => server.id
          :dns_name => server.dns_name,
          :private_ip_address => server.private_ip_address,
          :public_ip_address => server.public_ip_address,
        }
      })

  end

  def self.connect
    # create a connection
    @connection ||= Fog::Compute.new({
        :provider                 => 'AWS',
        :aws_secret_access_key    => ENV['AWS_SECRET_KEY']
        :aws_access_key_id        => ENV['AWS_ACCESS_KEY']
      })

  end

  def self.make

  end

  def self.list
    connection = self.connect
    connection.servers
  end

  def access
    connection = self.connect
    server = connection.servers.reload.last
    server
  end

end
