module Lookup
  extend ActiveSupport::Concern

  included do
    validates :code, length: { maximum: 32 }, uniqueness: { case_sensitive: false }, presence: true
  end
end
