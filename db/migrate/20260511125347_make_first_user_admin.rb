class MakeFirstUserAdmin < ActiveRecord::Migration[8.1]
  def up
    first_user = User.first
    first_user.update(is_admin: true) if first_user
  end

  def down
    first_user = User.first
    first_user.update(is_admin: false) if first_user
  end
end
