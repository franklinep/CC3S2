class FechaVencimiento < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :fecha, :date, default: nil
  end
end
