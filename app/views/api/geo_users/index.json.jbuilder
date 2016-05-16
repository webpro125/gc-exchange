json.type "FeatureCollection"
json.features @consultants do |consultant|
  json.cache! ['v1', consultant], expires_in: 2.hours do
    json.type "Feature"
    json.properties do
      json.key_format! camelize: :lower
      json.first_name consultant.user.first_name
      json.last_name consultant.user.last_name
      json.title "Government Contractor"
      json.image consultant.profile_image.url(:medium)
    end
    if consultant.address.present?
      json.geometry do
        json.type "Point"
        json.coordinates consultant.address.coordinates 
      end
    end
  end
end
