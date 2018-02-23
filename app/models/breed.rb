class Breed < ActiveRecord::Base
  has_many :dog_breeds
  has_many :dogs, through: :dog_breeds
  has_many :users, through: :dog_breeds

end
