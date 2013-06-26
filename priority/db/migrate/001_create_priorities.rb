class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.boolean :enabled
      t.string :field1
      t.string :field2
      t.string :field3
      t.integer :weight1
      t.integer :weight2
      t.integer :weight3
      t.integer :low_min
      t.integer :low_max
      t.integer :normal_min
      t.integer :normal_max
      t.integer :high_min
      t.integer :high_max
      t.integer :project_id
    end
    add_index :priorities, :project_id
  end
end
