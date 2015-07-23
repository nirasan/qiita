class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  after_create :create_info

  def create_info
    Info.create_comment(entry.user, entry, user)
  end
end
