class Article < ActiveRecord::Base
  validates :title,
            presence:   true,
            length:     { in: 2..36 },
            uniqueness: { case_sensitive: true }
  validates :text, presence: true, length: { in: 2..500 }

  has_many :comments
  belongs_to :user
end
