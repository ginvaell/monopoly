class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :string
      t.string :money
      t.string :integer

      t.timestamps
    end
  end
end
