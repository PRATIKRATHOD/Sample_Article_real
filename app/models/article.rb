class Article < ApplicationRecord
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                      length: { minimum: 5 }
    validates :user_id, presence: true
  end