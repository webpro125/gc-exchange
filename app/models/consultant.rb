class Consultant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, length: { in: 3..24 }, presence: true,
            format: { with: /\A[a-zA-Z]+\z/,
                      message: 'only allows letters' }
  validates :last_name, length: { in: 3..24 }, presence: true,
            format: { with: /\A[a-zA-Z]+\z/,
                      message: 'only allows letters' }

end
