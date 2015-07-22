class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries
  has_many :comments

  has_many :follow_from, class_name: FollowUser, foreign_key: :from_user_id
  has_many :follow_to,   class_name: FollowUser, foreign_key: :to_user_id
  has_many :followers, through: :follow_from, source: :to_user
  has_many :followees, through: :follow_to, source: :from_user

  has_many :user_tags
  has_many :tags, through: :user_tags

  def follow(user)
    unless self.following?(user)
      self.followers << user
    end
  end

  def unfollow(user)
    if self.following?(user)
      self.follow_from.find_by(to_user: user).destroy
    end
  end

  def following?(user)
    self.followers.find_by(id: user.id).present?
  end

end
