class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_counter
  before_destroy :update_counter_down

  def update_counter
    post.increment!(:comments_counter)
  end

  def update_counter_down
    post.update_columns('comments_counter' => post.comments_counter - 1)
  end
end
