class AddIndexToCache < ActiveRecord::Migration[5.2]
  def change
    add_index :forecasr_caches, :term
  end
end
