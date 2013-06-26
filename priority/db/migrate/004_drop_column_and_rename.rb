class DropColumnAndRename < ActiveRecord::Migration

  rename_column :priorities, :low_min, :urgent_min
  rename_column :priorities, :low_max, :urgent_max

  remove_column :issues, :field4, :field5
  remove_column :priorities, :field4, :field5, :weight4, :weight5

end