# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Comment, type: :model do
  context "content が記述されているとき" do
    it "コメントは送れる" do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context "content が記述されていないとき" do
    it "コメントは送れる" do
      comment = build(:comment, content: nil)
      expect(comment).to be_invalid
      expect(comment.errors.details[:content][0][:error]).to eq :blank
    end
  end
end
