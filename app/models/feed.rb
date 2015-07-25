class Feed < ActiveRecord::Base
  extend Enumerize

  belongs_to :user
  belongs_to :tag
  belongs_to :entry

  enumerize :feed_type, in: {user_create: 0, user_update:1, user_stock:2, user_comment:3, tag_create:4, tag_update:5}

  def self.create_at_entry_created(entry)
    self.create(feed_type: Feed.feed_type.user_create, user: entry.user, entry: entry)
    entry.tags.each do |tag|
      self.create(feed_type: Feed.feed_type.tag_create, tag: tag, entry: entry)
    end
  end

  def self.create_at_entry_updated(entry)
    self.create(feed_type: Feed.feed_type.user_update, user: entry.user, entry: entry)
    entry.tags.each do |tag|
      self.create(feed_type: Feed.feed_type.tag_update, tag: tag, entry: entry)
    end
  end

  def self.create_at_entry_stocked(entry, user)
    self.create(feed_type: Feed.feed_type.user_stock, user: user, entry: entry)
  end

  def self.create_at_entry_commented(entry, user)
    self.create(feed_type: Feed.feed_type.user_comment, user: user, entry: entry)
  end

  def self.search_by_user(user)
    user_ids = user.follow_from.pluck(:to_user_id)
    tag_ids = user.user_tags.pluck(:tag_id)
    self.where('user_id IN (?) OR tag_id IN (?)', user_ids, tag_ids)
  end

end
