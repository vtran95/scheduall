class RemoveHostFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :host, :string
  end
end
