class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :device_mac
      t.text :score_sheet
      t.string :status, default: "ready"
      t.timestamps
    end
  end
end
