RSpec.describe Employee do
  describe "full_name" do
    it "returns full name" do
      employee = Employee.new(
        first_name: "Alan",
        last_name: "Buttars",
      )

      expect(employee.full_name).to eq("Alan Buttars")
    end
  end
end
