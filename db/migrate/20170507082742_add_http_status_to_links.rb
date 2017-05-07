class AddHttpStatusToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :http_status, :integer
  end
end
