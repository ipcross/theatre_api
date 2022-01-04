module RequestResponce
  def json
    @json ||= JSON.parse response.body, symbolize_names: true
  end

  def request_api(method, path, **hsh)
    headers = hsh[:headers] || {}
    headers['Accept'] = "application/vnd.example.v#{hsh[:v] || 1}"
    headers['Authorization'] = "Bearer #{hsh[:token] || nil}"
    send method, path, params: hsh[:params] || {}, headers: headers
  end
end
