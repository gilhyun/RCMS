require 'net/http'
require 'json'

start=Time.now

url = "http://localhost:4242"
uri = URI.parse(url)
data = { "_type"=>"_incr", "value"=> 1, "gauge"=> "sales_per_minute" }.to_json

headers = {"Content-Type" => "application/json"}

net = Net::HTTP.new(uri.host,uri.port)   # Creates a http object
request = Net::HTTP::Post.new("/events", initheader=headers)
request.body=data

response=net.start do |http|
  http.request(request)
end

puts "working time : #{Time.now-start}"
