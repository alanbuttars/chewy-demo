class LabelService
  def self.find_all
    Label.all.order(:text)
  end
end
