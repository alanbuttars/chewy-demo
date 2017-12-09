Chewy.strategy(:atomic) do
  data = YAML.load_file 'config/labels.yml'
  data.map(&:deep_symbolize_keys).each do |datum|
    Label.create!(datum)
  end
end
