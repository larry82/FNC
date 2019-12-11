class Post < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  has_rich_text :body
  has_many :users, through: :posts

  scope :sorted, -> { order(created_at: :asc) }

  def send_notifications!
    users = discussion.users.uniq - [user]

    users.each do |user|
      DiscussionMailer.new_post(self, user)
    end
  end
end
