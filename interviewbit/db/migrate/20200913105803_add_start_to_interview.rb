class AddStartToInterview < ActiveRecord::Migration[6.0]
  def change
    add_column :interviews, :start, :date
  end
end
