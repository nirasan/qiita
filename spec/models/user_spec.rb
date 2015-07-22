require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#follow" do
    context "未フォロー" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      it {
        expect(user1.following?(user2)).to eq false
        expect(user1.follow(user2)).to be_truthy
        user1.reload
        expect(user1.following?(user2)).to eq true
      }
    end
    context "フォロー済み" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      before do
        user1.follow(user2)
        user1.reload
      end
      it {
        expect(user1.following?(user2)).to eq true
        expect(user1.follow(user2)).to be_falsey
      }
    end
  end

  describe "#unfollow" do
    context "未フォロー" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      it {
        expect(user1.following?(user2)).to eq false
        expect(user1.unfollow(user2)).to be_falsey
      }
    end
    context "フォロー済み" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      before do
        user1.follow(user2)
        user1.reload
      end
      it {
        expect(user1.following?(user2)).to eq true
        expect(user1.unfollow(user2)).to be_truthy
        user1.reload
        expect(user1.following?(user2)).to eq false
      }
    end
  end
end
