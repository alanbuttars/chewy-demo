require "rails_helper"

RSpec.describe LabelService do
  describe "find_all" do
    it "returns all labels" do
      expected_labels = (1..5).map do |i|
        _create_label(code: "CODE_#{i}", text: "Text #{i}")
      end
      actual_labels = LabelService.find_all

      expect(actual_labels.count).to eq(7)
      expect(actual_labels.last(5)).to eq(expected_labels)
    end
  end

  def _create_label(params = {})
    Label.create!(
      code: params[:code],
      text: params[:text],
    )
  end
end
