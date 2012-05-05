class Service < ActiveRecord::Base
  attr_accessible :description, :name, :repo

  validates :name, :uniqueness => { :case_sensitive => false }
  validates :name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed" }

  has_many :resources
  has_many :deploys

  def deploy!
    # 1) Create a deploy
    # 2) Clone repo locally and figure out the commit.
    # 3) Trigger a state change.
    # 4) ssh into the correct machine and find the processes if there are any.
    # 5)

    Net::SSH.start('host', 'user', :password => "password") do |ssh|
      output = ssh.exec!("hostname")

    end
  end

end
