class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :commenter, class_name: 'User', inverse_of: :owned_comments, dependent: :delete
  belongs_to :admin_commenter, class_name: 'Admin', inverse_of: :admin_owned_comments, dependent: :delete
  validates :body, presence: true, length: { in: 2..500 }

  def author
    commenter.present? ? commenter : admin_commenter
  end
end
