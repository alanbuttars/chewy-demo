class CollegeService
  def self.find_all
    College.all.order(name: :asc)
  end

  def self.find(params)
    College.find(params[:college_id])
  end

  def self.search(params)
    query = params[:query]
    latitude = params[:latitude]
    longitude = params[:longitude]

    college_query =
      if latitude.present? && longitude.present?
        CollegesIndex.query(
          geo_distance: {
            distance: "150miles",
            location: {
              lat: latitude,
              lon: longitude,
            },
          },
        )
      else
        CollegesIndex.query(
          match_all: {},
        )
      end

    if query.present?
      college_query = college_query.query(
        multi_match: {
          query: query,
          fields: [
            :name,
            :alias,
            :label_codes,
          ],
          fuzziness: "AUTO",
        },
      )
    end

    college_query.records.compact
  end
end
