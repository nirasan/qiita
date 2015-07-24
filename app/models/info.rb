class Info < ActiveRecord::Base
  extend Enumerize

  belongs_to :user

  serialize :data
  enumerize :info_type, in: {comment: 0, stock:1, stock_update:2}

  def self.create_comment(user, entry, comment_user)
    user.infos.create(
      info_type: self.info_type.comment,
      data: {entry: {id: entry.id, title: entry.title}, comment_user: {id: comment_user.id, name: comment_user.name}})
  end

  def self.create_stock(user, entry, stock_user)
    user.infos.create(
      info_type: self.info_type.stock,
      data: {entry: {id: entry.id, title: entry.title}, stock_user: {id: stock_user.id, name: stock_user.name}})
  end

  def self.create_stock_update(user, entry)
    user.infos.create(
      info_type: self.info_type.stock_update,
      data: {entry: {id: entry.id, title: entry.title}})
  end

end
