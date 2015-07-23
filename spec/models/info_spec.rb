require 'rails_helper'

RSpec.describe Info, type: :model do
  describe "#create_comment" do
    context "コメントついたら通知が出る" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user:user1) }
      it {
        expect(user1.infos.size).to eq 0
        create(:comment, user:user2, entry:entry1)
        user1.reload
        expect(user1.infos.size).to eq 1
        expect(user1.infos.first.info_type).to eq Info.info_type.comment
      }
    end
  end
  describe "#create_stock" do
    context "ストックされたら通知が出る" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user:user1) }
      it {
        expect(user1.infos.size).to eq 0
        Entry.stock(user2, entry1)
        user1.reload
        expect(user1.infos.size).to eq 1
        expect(user1.infos.first.info_type).to eq Info.info_type.stock
      }
    end
  end
  describe "#create_stock_update" do
    context "ストックしている記事が更新したら通知が出る" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user:user1) }
      it {
        expect(user2.infos.size).to eq 0
        Entry.stock(user2, entry1)
        entry1.update(title: "NEW TITLE")
        user2.reload
        expect(user2.infos.size).to eq 1
        expect(user2.infos.first.info_type).to eq Info.info_type.stock_update
      }
    end
  end
end
