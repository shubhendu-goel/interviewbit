class AddStartToInterview < ActiveRecord::Migration[6.0]
  def change
    add_column :interviews, :start, :datetime
  end
end
