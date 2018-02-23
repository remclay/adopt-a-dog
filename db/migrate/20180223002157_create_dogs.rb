class CreateDogs < ActiveRecord::Migration[5.1]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :age
      t.string :breed
      t.integer :user_id
    end
  end
end
