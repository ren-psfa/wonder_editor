# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_article_id  (article_id)
#  index_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Like, type: :model do
  context "user_id と article_id があるとき" do
    it "いいねが保存される" do
      like = create(:like)
      expect(like).to be_valid
    end
  end

  context "user_id がないとき" do
    it "like は保存されない" do
      like = create(:like)
      like.user_id = nil
      expect(like).to be_invalid
      expect(like.errors.details[:user_id][0][:error]).to eq :blank
    end
  end

  context "article_id がないとき" do
    it "like は保存されない" do
      like = create(:like)
      like.article_id = nil
      expect(like).to be_invalid
      expect(like.errors.details[:article_id][0][:error]).to eq :blank
    end
  end

  context "user_id が同じでも article_id が違うとき" do
    let(:like) { create(:like) }
    let(:user_id) { like.user_id }
    it "like が保存される" do
      expect(create(:like, user_id: user_id)).to be_valid
    end
  end

  context "article_id が同じでも user_id が違うとき" do
    let(:like) { create(:like) }
    let(:article_id) { like.article_id }
    it "like は保存される" do
      expect(create(:like, article_id: article_id)).to be_valid
    end
  end

  context "article_id と user_id が同じとき" do
    let(:like) { create(:like) }
    let(:user_id) { like.user_id }
    let(:article_id) { like.article_id }
    it "like は保存されない" do
      new_like = build(:like, user_id: user_id, article_id: article_id)
      expect(new_like).to be_invalid
      expect(new_like.errors.details[:article_id][0][:error]).to eq :taken
    end
  end
end
