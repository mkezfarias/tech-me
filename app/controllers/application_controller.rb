class ApplicationController < ActionController::Base

require 'uri'
require 'net/http'
require 'openssl'

url = URI("https://api.daily.co/v1/rooms")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["authorization"] = 'Bearer Bea3bea85143a30f4699b6028f381cf9804d1b72c38b49d993baa71fc2f23b98'

response = http.request(request)
puts response.read_body
end
