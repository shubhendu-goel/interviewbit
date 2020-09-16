class AddFinishToInterview < ActiveRecord::Migration[6.0]
  def change
    add_column :interviews, :finish, :datetime
  end
end
