class RenameTableForecastCache < ActiveRecord::Migration[5.2]
  def change
    rename_table :forecasr_caches, :forecast_caches
  end
end
