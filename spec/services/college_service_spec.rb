require "rails_helper"

RSpec.describe CollegeService do
  describe "find_all" do
    it "returns all colleges" do
      expected_colleges = (1..5).map do |i|
        _create_college(name: "A University #{i}")
      end
      actual_colleges = CollegeService.find_all

      expect(actual_colleges.count).to eq(25)
      expect(actual_colleges.first(5)).to eq(expected_colleges)
    end
  end

  describe "find" do
    it "returns the college matching the college_id" do
      expected_college = _create_college
      actual_college = CollegeService.find(college_id: expected_college.id)

      expect(actual_college).to eq(expected_college)
    end
  end

  def _create_college(params = {})
    College.create!(
      name: params[:name] || Faker::University.name,
      alias: params[:alias],
      enrollment: rand(10_000),
      address: params[:address] || Faker::Address.street_address,
      city: params[:city] || Faker::Address.city,
      state: params[:state] || Faker::Address.state_abbr,
      zip: params[:zip] || Faker::Address.zip_code,
      latitude: params[:latitude] || Faker::Address.latitude,
      longitude: params[:longitude] || Faker::Address.longitude,
    )
  end
end
