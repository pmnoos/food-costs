class AddUserToStores < ActiveRecord::Migration[8.0]
  def change
    add_reference :stores, :user, null: true, foreign_key: true
    
    # Set a default user for existing stores
    reversible do |dir|
      dir.up do
        # Find or create a default user
        default_user = User.first_or_create!(email: 'default@example.com') do |u|
          u.password = 'password123'
          u.password_confirmation = 'password123'
        end
        
        # Update existing stores to use the default user
        execute "UPDATE stores SET user_id = #{default_user.id} WHERE user_id IS NULL"
        
        # Now make the column not null
        change_column_null :stores, :user_id, false
      end
    end
  end
end
