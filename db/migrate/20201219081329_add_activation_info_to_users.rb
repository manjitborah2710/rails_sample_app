class AddActivationInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users,:activated,:boolean,default: false
    add_column :users,:activation_digest,:string
    add_column :users,:activated_at,:timestamp
  end
end