class Dog < ActiveRecord::Base
  belongs_to :user
  has_many :dog_breeds
  has_many :breeds, :through => :dog_breeds

  validates_presence_of :name, :age

  def user_username
    self.user.username
  end

  def user_email
    self.user.email
  end
end
