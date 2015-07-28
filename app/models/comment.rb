class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  validates :body, presence: true

  after_create :create_info
  after_create :create_feed

  def create_info
    Info.create_comment(entry.user, entry, user)
  end

  def create_feed
    Feed.create_at_entry_commented(self.entry, self.user)
  end
end
