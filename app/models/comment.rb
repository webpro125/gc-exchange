class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :commenter, class_name: 'User', inverse_of: :owned_comments
  belongs_to :admin_commenter, class_name: 'Admin', inverse_of: :admin_owned_comments
  validates :body, presence: true, length: { in: 2..500 }

  has_many :comment_attachments, dependent: :destroy
  accepts_nested_attributes_for :comment_attachments, :allow_destroy => true

  def author
    commenter.present? ? commenter : admin_commenter
  end
end
