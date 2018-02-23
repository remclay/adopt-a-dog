class User < ActiveRecord::Base
  has_many :dogs
  has_secure_password
  #validates_presence_of :username, :email, :password

  def slug
    self.username.gsub(/[!?,'." "]/, '-').downcase
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end
end
