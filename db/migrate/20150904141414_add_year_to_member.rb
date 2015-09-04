class AddYearToMember < ActiveRecord::Migration
  def change
    add_column :members, :year, :integer
  end
end
