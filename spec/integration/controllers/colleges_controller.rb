require "integration/rails_helper"

RSpec.describe CollegesController do
  describe "find_all" do
    it "returns all colleges" do
      get "/colleges"
      doc = Nokogiri::HTML(response.body)
      expect(doc.css("tbody > tr").count).to eq(20)
      expect(doc.css("tbody > tr:first > td:first").text).to eq("Brown")
      expect(doc.css("tbody > tr:last > td:first").text).to eq("Yale")
    end
  end

  describe "find" do
  end

  describe "search" do
  end
end
