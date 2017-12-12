require "integration/rails_helper"

RSpec.describe CollegesController do
  describe "find_all" do
    it "returns all colleges" do
      get "/colleges"
      doc = Nokogiri::HTML(response.body)
      expect(doc.css("h1:first").text).to eq("Colleges")
      expect(doc.css("tbody > tr").count).to eq(20)
      expect(doc.css("tbody > tr:first > td:nth-child(2)").text).to eq("Brown University")
      expect(doc.css("tbody > tr:last > td:nth-child(2)").text).to eq("Yale University")
    end
  end

  describe "find" do
    it "returns the college matching the college_id" do
      mit = College.find(1)

      get "/colleges/1"
      doc = Nokogiri::HTML(response.body)
      expect(doc.css("h1:first").text).to eq("Massachusetts Institute of Technology")
      expect(doc.css("tbody")[0].css("tr:nth-child(2) > td:first").text.to_i).to eq(mit.enrollment)
      expect(doc.css("tbody")[0].css("tr:nth-child(3) > td:first").text).to include(mit.address)
      expect(doc.css("tbody")[0].css("tr:nth-child(3) > td:first").text).to include(mit.city)
      expect(doc.css("tbody")[0].css("tr:nth-child(3) > td:first").text).to include(mit.state)
      expect(doc.css("tbody")[0].css("tr:nth-child(3) > td:first").text).to include(mit.zip)
    end

    it "returns all college employees matching the college_id" do
      mit = College.find(1)
      employees = mit.employees.order(first_name: :asc)

      get "/colleges/1"
      doc = Nokogiri::HTML(response.body)
      expect(doc.css("tbody")[1].css("tr").count).to eq(10)
      expect(doc.css("tbody")[1].css("tr:nth-child(1) > td:nth-child(1)").text).to eq(employees.first.full_name)
      expect(doc.css("tbody")[1].css("tr:nth-child(1) > td:nth-child(2)").text).to eq(employees.first.email)
      expect(doc.css("tbody")[1].css("tr:nth-child(10) > td:nth-child(1)").text).to eq(employees.last.full_name)
      expect(doc.css("tbody")[1].css("tr:nth-child(10) > td:nth-child(2)").text).to eq(employees.last.email)
    end
  end

  describe "search" do
    context "when no params are sent" do
      it "redirects to find_all" do
        get "/colleges/search", params: {}
        expect(response.redirect?).to be true
        expect(response.redirect_url).to end_with(colleges_path)
      end
    end

    context "when only query is sent" do
      it "returns all colleges matching the name" do
        get "/colleges/search", params: { query: "California" }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("h1:first").text).to eq("Colleges matching 'California'")
        expect(doc.css("tbody > tr").count).to eq(4)
        [
          "California Institute of Technology",
          "University of California, Berkeley",
          "University of California, Los Angeles",
          "University of California, San Diego",
        ].each do |name|
          expect(doc.css("tbody > tr").text).to include(name)
        end
      end

      it "returns all colleges matching the alias" do
        get "/colleges/search", params: { query: "Caltech" }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("h1:first").text).to eq("Colleges matching 'Caltech'")
        expect(doc.css("tbody > tr").count).to eq(1)
        expect(doc.css("tbody > tr").text).to include("California Institute of Technology")
      end

      it "returns all colleges matching the label" do
        get "/colleges/search", params: { query: "public" }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("h1:first").text).to eq("Colleges matching 'public'")
        expect(doc.css("tbody > tr").count).to eq(4)
        [
          "University of Michigan",
          "University of California, Berkeley",
          "University of California, Los Angeles",
          "University of California, San Diego",
        ].each do |name|
          expect(doc.css("tbody > tr").text).to include(name)
        end
      end
    end

    context "when only latitude and longitude are sent" do
      it "returns all colleges matching the location" do
        get "/colleges/search", params: { latitude: 33.28, longitude: -117.39 }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("h1:first").text).to eq("Colleges near 33.28, -117.39")
        expect(doc.css("tbody > tr").count).to eq(3)
        [
          "California Institute of Technology",
          "University of California, Los Angeles",
          "University of California, San Diego",
        ].each do |name|
          expect(doc.css("tbody > tr").text).to include(name)
        end
      end
    end

    context "when query, latitude, and longitude are sent" do
      it "returns all colleges matching the location and name" do
        get "/colleges/search", params: { query: "University", latitude: 33.28, longitude: -117.39 }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("h1:first").text).to eq("Colleges matching 'University' near 33.28, -117.39")
        expect(doc.css("tbody > tr").count).to eq(2)
        [
          "University of California, Los Angeles",
          "University of California, San Diego",
        ].each do |name|
          expect(doc.css("tbody > tr").text).to include(name)
        end
      end

      it "returns all colleges matching the location and alias" do
        get "/colleges/search", params: { query: "calteh", latitude: 33.28, longitude: -117.39 }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("h1:first").text).to eq("Colleges matching 'calteh' near 33.28, -117.39")
        expect(doc.css("tbody > tr").count).to eq(1)
        [
          "California Institute of Technology",
        ].each do |name|
          expect(doc.css("tbody > tr").text).to include(name)
        end
      end

      it "returns all colleges matching the location and label" do
        get "/colleges/search", params: { query: "public", latitude: 33.28, longitude: -117.39 }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("h1:first").text).to eq("Colleges matching 'public' near 33.28, -117.39")
        expect(doc.css("tbody > tr").count).to eq(2)
        [
          "University of California, Los Angeles",
          "University of California, San Diego",
        ].each do |name|
          expect(doc.css("tbody > tr").text).to include(name)
        end
      end
    end
  end
end
