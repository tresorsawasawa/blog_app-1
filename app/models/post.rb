class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', autosave: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  after_save :update_counter
  before_destroy :update_counter_down

  validates :title, presence: true, allow_blank: false, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def update_counter
    author.increment!(:posts_counter)
  end

  def update_counter_down
    author.posts_counter = author.posts_counter - 1
    author.save
  end

  def recent_comments
    comments.order(created_at: :desc).includes([:author]).limit(5)
  end
end
