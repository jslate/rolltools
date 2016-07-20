require 'Faraday'
require 'json'

module Rolltools::Utils

  def self.conn
    @conn ||= Faraday.new("https://api.rollbar.com")
  end

  def self.get_item_for_counter(counter)
    token = Rolltools::Settings.get('read_token')
    raise "token is not set, use 'rolltools set_config read_token VALUE'" if token.nil?
    get_item_id_res = conn.get "/api/1/item_by_counter/#{counter}", access_token: token
    JSON.parse(get_item_id_res.body)['result']['itemId']
  end

  def self.get_items(counter)
    token = Rolltools::Settings.get('read_token')
    raise "token is not set, use 'rolltools set_config token VALUE'" if token.nil?
    item_id = get_item_for_counter(counter)

    Enumerator.new do |y|
      page = 1
      begin
        get_item_res = conn.get "/api/1/item/#{item_id}/instances/", access_token: token, page: page
        item = JSON.parse(get_item_res.body)
        item['result']['instances'].each do |i|
          e = i['data']['body']['trace']['exception'] rescue nil
          y << {  url: (i['data']['request']['url'] rescue nil),
                  user_agent: (i['data']['request']['headers']['User-Agent'] rescue nil),
                  instance_id: i['id'],
                  params: (i['data']['request']['params'] rescue nil),
                  body: (i['data']['body']['message']['body'] rescue nil),
                  exception: "#{e['class'] rescue ''} #{e['message'] rescue ''}"
                }
        end
        page += 1
      end until item['result']['instances'].empty?
    end
  end

end
