class AddIndexToPolls < ActiveRecord::Migration
  def change
    add_index :polls, :title, unique: true
  end
end
