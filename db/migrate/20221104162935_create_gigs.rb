class CreateGigs < ActiveRecord::Migration[6.1]
  def change
    create_table :gigs do |t|
      t.string :brand_name
      t.integer :state, default: 0
      t.references :creator, foreign_key: true

      t.timestamps
    end
  end
end
