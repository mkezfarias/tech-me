require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module SubjectsHelper
    URL = URI("https://api.daily.co/v1/rooms")

    def create_room(name)
        http = Net::HTTP.new(URL.host, URL.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(URL)
        request["content-type"] = 'application/json'
        request["authorization"] = 'Bearer 209d8220e3df025bbbb170ff312c20b2aabf088329012ddd40533bfb03042806'
        if name
           request.body = "{\"name\":\"#{name}\",\"properties\":{\"max_participants\":2,\"autojoin\":false,\"enable_knocking\":true,\"enable_screenshare\":true,\"enable_chat\":true,\"start_video_off\":false,\"start_audio_off\":false}}"
        else
           request.body = "{\"properties\":{\"max_participants\":2,\"autojoin\":false,\"enable_knocking\":true,\"enable_screenshare\":true,\"enable_chat\":true,\"start_video_off\":false,\"start_audio_off\":false}}"
        end
        response = http.request(request)
        puts response.read_body
        JSON.parse(response.body)["url"]
    end

    def all_rooms
        http = Net::HTTP.new(URL.host, URL.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(URL)
        request["content-type"] = 'application/json'
        request["authorization"] = 'Bearer 209d8220e3df025bbbb170ff312c20b2aabf088329012ddd40533bfb03042806'
        request.body = "{\"properties\":{\"max_participants\":2,\"autojoin\":false,\"enable_knocking\":true,\"enable_screenshare\":true,\"enable_chat\":true,\"start_video_off\":false,\"start_audio_off\":false}}"

        response = http.request(request)
        puts response.read_body
        hasho = JSON.parse(response.body)
        room_names = hasho["data"].map{ |hsh| hsh["name"]}
    end

    def delete_room(room_name)
            url = URI("https://api.daily.co/v1/rooms/#{room_name}")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
            request = Net::HTTP::Delete.new(url)
            request["content-type"] = 'application/json'
            request["authorization"] = 'Bearer 209d8220e3df025bbbb170ff312c20b2aabf088329012ddd40533bfb03042806'
            request.body = "{\"properties\":{\"max_participants\":2,\"autojoin\":false,\"enable_knocking\":true,\"enable_screenshare\":true,\"enable_chat\":true,\"start_video_off\":false,\"start_audio_off\":false}}"
    
            response = http.request(request)
            puts response.read_body
    end
end
