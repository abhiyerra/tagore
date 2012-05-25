class Port < ActiveRecord::Base
  # attr_accessible :title, :body

  def clear
    # Check when the port was last updated and if it hasn't updated in
    # more than 5 mins ago then kill it.
    self.destroy
  end

end
