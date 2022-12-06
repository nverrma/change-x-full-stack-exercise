class AddStatusChangeFromAndStatusChangeToToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :status_changed_from, :string, null: false, default: ''
    add_column :comments, :status_changed_to, :string, null: false, default: ''
  end
end
