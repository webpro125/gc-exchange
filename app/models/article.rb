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

  has_many :article_attachments, dependent: :destroy, inverse_of: :article
  accepts_nested_attributes_for :article_attachments, :allow_destroy => true

  def author
    user.present? ? user : admin
  end
end
