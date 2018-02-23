class CreateDogBreeds < ActiveRecord::Migration[5.1]
  def change
    create_table :dog_breeds do |t|
      t.integer :dog_id
      t.integer :breed_id
    end
  end
end
