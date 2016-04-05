class Article < ActiveRecord::Base
  enum status: [:open, :closed]
  validates :title,
            presence:   true,
            length:     { in: 2..36 },
            uniqueness: { case_sensitive: true }
  validates :text, presence: true, length: { in: 2..500 }

  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :admin

  def author
    user.present? ? user : admin
  end
end
