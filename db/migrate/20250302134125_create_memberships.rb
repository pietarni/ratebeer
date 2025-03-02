class CreateMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :beer_club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
