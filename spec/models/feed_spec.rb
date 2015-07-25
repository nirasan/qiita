require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe "#create_at_entry_created" do
    context "エントリー作成時にユーザーとタグにひもづいたフィードができる" do
      let!(:user1) { create(:user) }
      it {
        expect(Feed.count).to eq 0
        create(:entry, user: user1, tag_string: 'tag1, tag2')
        expect(Feed.count).to eq 3
        expect(Feed.where(feed_type: 0).count).to eq 1
        expect(Feed.where(feed_type: 4).count).to eq 2
      }
    end
  end

  describe "#create_at_entry_updated" do
    context "エントリー更新時にユーザーとタグにひもづいたフィードができる" do
      let!(:user1) { create(:user) }
      let!(:entry1) { create(:entry, user: user1, tag_string: 'tag1, tag2') }
      it {
        Feed.all.each{|feed| feed.destroy}
        expect(Feed.count).to eq 0
        entry1.update(body: 'new body')
        expect(Feed.count).to eq 3
        expect(Feed.where(feed_type: 1).count).to eq 1
        expect(Feed.where(feed_type: 5).count).to eq 2
      }
    end
  end

  describe "#create_at_entry_stocked" do
    context "エントリーがストックされた時にユーザーにひもづいたフィードができる" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user: user1, tag_string: 'tag1, tag2') }
      it {
        Feed.all.each{|feed| feed.destroy}
        expect(Feed.count).to eq 0
        Entry.stock(user2, entry1)
        expect(Feed.count).to eq 1
        expect(Feed.where(feed_type: 2).count).to eq 1
      }
    end
  end

  describe "#create_at_entry_commented" do
    context "エントリーがコメントされた時にユーザーにひもづいたフィードができる" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user: user1, tag_string: 'tag1, tag2') }
      it {
        Feed.all.each{|feed| feed.destroy}
        expect(Feed.count).to eq 0
        create(:comment, user: user2, entry: entry1)
        expect(Feed.count).to eq 1
        expect(Feed.where(feed_type: 3).count).to eq 1
      }
    end
  end

  describe "#search_by_user" do
    context "ユーザーに関連するフィードが取得できる" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:user3) { create(:user) }
      let!(:entry1) { create(:entry, user: user1, tag_string: 'tag1, tag2') }
      let!(:entry2) { create(:entry, user: user2, tag_string: 'tag1, tag3, tag4') }
      before do
        Entry.stock(user2, entry1)
        user3.follow(user2)
        Tag.follow(user3, Tag.find_by(body: 'tag1'))
        entry2.update(body: 'new body')
      end
      it {
        expect(Feed.search_by_user(user3).count).eq to 6
      }
    end
  end

end
