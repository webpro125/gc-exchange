class AddUserIdToConsultant < ActiveRecord::Migration
  require 'byebug'
  def change
    add_reference :consultants, :user, index: true, unique: true

    Consultant.find_each do |consultant|
      if User.exists?(email: consultant.email)
        user = User.where(email: consultant.email).first
      else
        # user = User.create(
        #   :email => consultant.email,
        #   :encrypted_password => consultant.encrypted_password,
        #   :reset_password_token => consultant.reset_password_token,
        #   :reset_password_sent_at => consultant.reset_password_sent_at,
        #   :remember_created_at => consultant.remember_created_at,
        #   :sign_in_count => consultant.sign_in_count,
        #   :current_sign_in_at => consultant.current_sign_in_at,
        #   :last_sign_in_at => consultant.last_sign_in_at,
        #   :current_sign_in_ip => consultant.current_sign_in_ip,
        #   :last_sign_in_ip => consultant.last_sign_in_ip,
        #   :confirmation_token => consultant.confirmation_token,
        #   :first_name => consultant.first_name,
        #   :last_name => consultant.last_name
        # )
        execute "INSERT INTO users(
            email, encrypted_password, first_name, last_name,
            sign_in_count, last_sign_in_at, current_sign_in_ip,
            last_sign_in_ip)
            VALUES ('#{consultant.email}', '#{consultant.encrypted_password}',
                    '#{consultant.first_name}', '#{consultant.last_name}',
                    '#{consultant.sign_in_count}',
                    '#{consultant.last_sign_in_at}', '#{consultant.current_sign_in_ip}',
                    '#{consultant.last_sign_in_ip}')"
        user = User.where(email: consultant.email).first
        user.skip_confirmation!
        user.save
      end

      consultant.user_id = user.id
      consultant.save
    end


    remove_column :consultants, :email
    remove_column :consultants, :encrypted_password
    remove_column :consultants, :reset_password_token
    remove_column :consultants, :reset_password_sent_at
    remove_column :consultants, :remember_created_at
    remove_column :consultants, :sign_in_count
    remove_column :consultants, :current_sign_in_at
    remove_column :consultants, :last_sign_in_at
    remove_column :consultants, :current_sign_in_ip
    remove_column :consultants, :last_sign_in_ip

  end
end
