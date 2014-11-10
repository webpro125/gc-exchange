class Skill < ActiveRecord::Base
  include Elasticsearch::Model

  SKILL_TYPES = [].freeze

  before_create :lower_code

  validates :code, length: { maximum: 128 }, uniqueness: { case_sensitive: false }, presence: true

  def self.search(query)
    __elasticsearch__.search query: { fuzzy: { code: query }}
  end

  private

  def lower_code
    self.code.downcase!
  end
end
