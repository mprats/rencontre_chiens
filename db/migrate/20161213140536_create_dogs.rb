class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.text :name
      t.text :breed
      t.date :birthdate
      t.text :gender

      t.timestamps null: false
    end
  end
end
