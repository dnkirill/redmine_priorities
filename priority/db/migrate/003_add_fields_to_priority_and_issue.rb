class AddFieldsToPriorityAndIssue < ActiveRecord::Migration
  def change
    add_column :issues, :field4, :integer
    add_column :issues, :field5, :integer

    add_column :priorities, :field4, :string
    add_column :priorities, :field5, :string

    add_column :priorities, :weight4, :integer
    add_column :priorities, :weight5, :integer

    Priority.reset_column_information
    Issue.reset_column_information

    Issue.update_all(field4: 0, field5: 0)
    Priority.update_all(weight4: 0, weight5: 0)
  end
end