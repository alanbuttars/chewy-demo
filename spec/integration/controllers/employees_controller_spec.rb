require "integration/rails_helper"

RSpec.describe EmployeesController do
  describe "search" do
    context "when no query is sent" do
      it "redirects to college" do
        get "/colleges/1/employees/search", params: {}
        expect(response.redirect?).to be true
        expect(response.redirect_url).to end_with("/colleges/1")
      end
    end

    context "when query is sent" do
      before(:all) do
        @college = College.last

        Chewy.strategy(:atomic) do
          Employee.create!(
            college: @college,
            first_name: "Alan",
            last_name: "Buttars",
            email: "alan.buttars@brown.edu",
          )
        end
      end

      it "returns all employees matching the first name" do
        get "/colleges/#{@college.id}/employees/search", params: { query: "aln" }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("tbody")[1].css("tr:nth-child(1) > td:nth-child(1)").text).to eq("Alan Buttars")
        expect(doc.css("tbody")[1].css("tr:nth-child(1) > td:nth-child(2)").text).to eq("alan.buttars@brown.edu")
      end

      it "returns all employees matching the last name" do
        get "/colleges/#{@college.id}/employees/search", params: { query: "buttrs" }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("tbody")[1].css("tr:nth-child(1) > td:nth-child(1)").text).to eq("Alan Buttars")
        expect(doc.css("tbody")[1].css("tr:nth-child(1) > td:nth-child(2)").text).to eq("alan.buttars@brown.edu")
      end

      it "returns all employees matching the email" do
        get "/colleges/#{@college.id}/employees/search", params: { query: "alan.buttrs@brown" }
        doc = Nokogiri::HTML(response.body)
        expect(doc.css("tbody")[1].css("tr:nth-child(1) > td:nth-child(1)").text).to eq("Alan Buttars")
        expect(doc.css("tbody")[1].css("tr:nth-child(1) > td:nth-child(2)").text).to eq("alan.buttars@brown.edu")
      end
    end
  end
end
