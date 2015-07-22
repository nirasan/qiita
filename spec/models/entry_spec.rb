require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "#tag_string_to_tags" do
    let!(:user1) { create(:user) }
    context "タグを追加する" do
      let!(:entry1) { create(:entry, user:user1) }
      it {
        entry1.update(tag_string:'tag1, tag2 ')
        entry1.reload
        expect(Tag.count).to eq 2
        expect(entry1.tags.find_by(body: 'tag2').present?).to eq true
      }
    end
    context "タグを追加削除する" do
      let!(:entry1) { create(:entry, user:user1, tag_string: ' tag1, tag2 ') }
      it {
        entry1.update(tag_string: 'tag4, tag3, tag1')
        entry1.reload
        expect(Tag.count).to eq 4
        expect(entry1.tags.find_by(body: 'tag1').present?).to eq true
        expect(entry1.tags.find_by(body: 'tag2').present?).to eq false
        expect(entry1.tags.find_by(body: 'tag3').present?).to eq true
        expect(entry1.tags.find_by(body: 'tag4').present?).to eq true
      }
    end
  end
  describe "#stock" do
    context "未ストック" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user:user2) }
      it {
        expect(Entry.stocking?(user1, entry1)).to eq false
        expect(Entry.stock(user1, entry1)).to be_truthy
        user1.reload
        expect(Entry.stocking?(user1, entry1)).to eq true
      }
    end
    context "ストック済" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user:user2) }
      before do
        Entry.stock(user1, entry1)
        user1.reload
      end
      it {
        expect(Entry.stocking?(user1, entry1)).to eq true
        expect(Entry.stock(user1, entry1)).to be_falsey
      }
    end
  end
  describe "#unstock" do
    context "未ストック" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user:user2) }
      it {
        expect(Entry.stocking?(user1, entry1)).to eq false
        expect(Entry.unstock(user1, entry1)).to be_falsey
      }
    end
    context "ストック済み" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:entry1) { create(:entry, user:user2) }
      before do
        Entry.stock(user1, entry1)
        user1.reload
      end
      it {
        expect(Entry.stocking?(user1, entry1)).to eq true
        expect(Entry.unstock(user1, entry1)).to be_truthy
        user1.reload
        expect(Entry.stocking?(user1, entry1)).to eq false
      }
    end
  end
end
