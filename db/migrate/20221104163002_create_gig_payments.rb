class CreateGigPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :gig_payments do |t|
      t.integer :state, default: 0
      t.integer :amount_in_cents
      t.references :gig, null: false, foreign_key: true

      t.timestamps
    end
  end
end
