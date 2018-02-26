class Dog < ActiveRecord::Base
  belongs_to :user
  has_many :dog_breeds
  has_many :breeds, :through => :dog_breeds

  validates_presence_of :name, :age
end
