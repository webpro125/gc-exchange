class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :commenter, class_name: 'User', inverse_of: :owned_comments, dependent: :delete
  validates :body, presence: true, length: { in: 2..500 }
end
