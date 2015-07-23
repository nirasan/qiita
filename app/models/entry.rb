class Entry < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_many :entry_tags
  has_many :tags, through: :entry_tags

  has_many :user_entries
  has_many :stock_users, through: :user_entries, source: :user

  after_save :tag_string_to_tags

  def tag_string_to_tags
    if tag_string_changed?
      before = self.tag_string_was.present? ? self.tag_string_was.strip.split(/\s*,\s*/) : []
      after = self.tag_string.strip.split(/\s*,\s*/)
      added = after - before
      deleted = before - after
      added.each do |tag_body|
        tag = Tag.find_or_create_by(body: tag_body)
        self.tags << tag
      end
      deleted.each do |tag_body|
        tag = Tag.find_by(body: tag_body)
        self.entry_tags.find_by(tag: tag).destroy
      end
    end
  end

  def self.stock(user, entry)
    unless self.stocking?(user, entry)
      user.entries << entry
    end
  end

  def self.unstock(user, entry)
    if self.stocking?(user, entry)
      user.user_entries.find_by(entry: entry).destroy
    end
  end

  def self.stocking?(user, entry)
    user.entries.find_by(id: entry.id).present?
  end

  def self.render_markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
  end
end
