class Sessions::ShowSerializer < SessionSerializer
  attributes :access_token, :refresh_token, :expire_at
end
