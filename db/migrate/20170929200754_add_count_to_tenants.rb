class AddCountToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :api_count, :integer, null: false, default: 0
  end
end
