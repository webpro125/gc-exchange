Geocoder.configure(
  always_raise: :all,
  timeout: 1,
  google: {
    api_key: Rails.application.secrets.google_api_key
  },
  bing: {
    api_key: Rails.application.secrets.bing_api_key
  }
)
