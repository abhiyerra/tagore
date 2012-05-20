class Service < ActiveRecord::Base
  attr_accessible :description, :name, :repo

  validates :name, :uniqueness => { :case_sensitive => false }
  validates :name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed" }

  has_many :resources
  has_many :deploys
  has_many :machine_ports

  before_save do
    self.name.downcase!
  end

  def deploy!
    # 1) Create a deploy
    # 2) Clone repo locally and figure out the commit.
    # 3) Trigger a state change.
    # 4) Go through the service.resources.where(:type => WebResource)
    # 5) ssh into each machine and check out a new top level clone via git
    #   a) Modify the database.yml to the new production database config.
    #   b)

    Net::SSH.start('host', 'user', :password => "password") do |ssh|
      output = ssh.exec!("hostname")

    end
  end

end
