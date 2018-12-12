class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :login_identifier
      t.string  :name
      t.string  :email
      t.string  :status
      t.string  :roles
      t.string  :crypted_password
      t.string	:password_salt
      t.string	:persistence_token
      t.string	:perishable_token
      t.timestamps
    end
  end
end
