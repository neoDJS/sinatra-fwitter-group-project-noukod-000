class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  has_many :tweets

  def slug
    self.username.gsub(/\W/, '-')
  end

  def self.find_by_slug(slugified)
    self.find{|u| u.slug == slugified}
  end
end
