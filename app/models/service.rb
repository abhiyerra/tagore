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
    $REDIS.publish("deploy", "#{self.id.to_s} HEAD")
  end

end
