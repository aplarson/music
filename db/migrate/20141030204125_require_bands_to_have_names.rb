class RequireBandsToHaveNames < ActiveRecord::Migration
  def change
    change_column :bands, :name, :string, null: false
  end
end
