class Service < ActiveRecord::Base
  attr_accessible :description, :name, :subdomain

  validates_uniqueness_of :name

  has_many :resources

  after_create :provision

  def provision!
    Resque.enqueue(ProvisionService, self.id)
  end

end
