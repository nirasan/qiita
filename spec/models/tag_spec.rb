require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "#follow" do
    context "未フォロー" do
      let!(:user1) { create(:user) }
      let!(:tag1) { create(:tag) }
      it {
        expect(Tag.following?(user1, tag1)).to eq false
        expect(Tag.follow(user1, tag1)).to be_truthy
        user1.reload
        expect(Tag.following?(user1, tag1)).to eq true
      }
    end
    context "フォロー済" do
      let!(:user1) { create(:user) }
      let!(:tag1) { create(:tag) }
      before do
        Tag.follow(user1, tag1)
        user1.reload
      end
      it {
        expect(Tag.following?(user1, tag1)).to eq true
        expect(Tag.follow(user1, tag1)).to be_falsey
      }
    end
  end
  describe "#unfollow" do
    context "未フォロー" do
      let!(:user1) { create(:user) }
      let!(:tag1) { create(:tag) }
      it {
        expect(Tag.following?(user1, tag1)).to eq false
        expect(Tag.unfollow(user1, tag1)).to be_falsey
      }
    end
    context "フォロー済み" do
      let!(:user1) { create(:user) }
      let!(:tag1) { create(:tag) }
      before do
        Tag.follow(user1, tag1)
        user1.reload
      end
      it {
        expect(Tag.following?(user1, tag1)).to eq true
        expect(Tag.unfollow(user1, tag1)).to be_truthy
        user1.reload
        expect(Tag.following?(user1, tag1)).to eq false
      }
    end
  end
end
