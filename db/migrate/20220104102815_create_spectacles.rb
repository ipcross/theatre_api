class CreateSpectacles < ActiveRecord::Migration[6.0]
  def change
    create_table :spectacles do |t|
      t.string :name
      t.daterange :period
      t.timestamps
    end
  end
end
