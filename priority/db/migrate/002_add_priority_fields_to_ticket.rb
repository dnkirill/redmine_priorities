class AddPriorityFieldsToTicket < ActiveRecord::Migration
  def change
    add_column :issues, :field1, :integer
    add_column :issues, :field2, :integer
    add_column :issues, :field3, :integer
  end
end
