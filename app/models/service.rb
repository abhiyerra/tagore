class Service < ActiveRecord::Base
  attr_accessible :description, :name, :repo

  validates :name, :uniqueness => { :case_sensitive => false }
  validates :name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed" }

  has_many :resources

  after_create :provision!

  def provision!
    Resque.enqueue(ProvisionService, self.id)
  end

end
