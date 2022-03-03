require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }

    it "記事の一覧が更新順に取得できる" do
      subject
      binding.pry
    end
  end
end
