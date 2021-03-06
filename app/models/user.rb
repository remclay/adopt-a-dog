class User < ActiveRecord::Base
  has_many :dogs
  has_many :breeds, :through => :dogs

  has_secure_password
  validates_presence_of :username, :email, :password
  validates :username, uniqueness: true

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end
end
