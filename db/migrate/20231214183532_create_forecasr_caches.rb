class CreateForecasrCaches < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasr_caches do |t|
      t.string :term
      t.string :datetime
      t.float :tempmax
      t.float :tempmin
      t.float :temp
      t.float :humidity
      t.timestamps
    end
  end
end
