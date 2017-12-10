class CollegesIndex < Chewy::Index
  define_type College.includes(:labels) do
    root do
      field :name
      field :alias
      field :label_codes, value: -> (college) do
        college.labels.map(&:code)
      end
      field :location, type: 'geo_point', value: ->(college) do
        { lat: college.latitude, lon: college.longitude }
      end
    end
  end
end
