class Tag < ActiveRecord::Base
  has_many :entry_tags
  has_many :entries, through: :entry_tags

  has_many :user_tags
  has_many :users, through: :user_tags

  def self.follow(user, tag)
    unless self.following?(user, tag)
      user.tags << tag
    end
  end

  def self.unfollow(user, tag)
    if self.following?(user, tag)
      user.tags.find_by(id: tag.id).destroy
    end
  end

  def self.following?(user, tag)
    user.tags.find_by(id: tag.id).present?
  end
end
