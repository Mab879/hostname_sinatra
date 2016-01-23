require 'sinatra'
require 'resolv'
require 'tilt/erubis'

get '/' do
  headers \
   "Access-Control-Allow-Origin" => "*"
  @hostname = get_hostname
  erb :index
end

get '/ip' do
  request.ip
end

get '/hostname' do
  get_hostname
end

get '/ipv4.js' do
  content_type 'text/javascript'
  "document.getElementById(\"ipv4_ip\").innerHTML = \"<br /> IPv4:  #{request.ip}\"" + "\n" +
  "document.getElementById(\"ipv4_hostname\").innerHTML = \"<br /> IPv4:' + #{get_hostname}\""
end

private

def get_hostname
  begin
    hostname = Resolv.getname(request.ip)
  rescue
    hostname = "N/A"
  end
  return hostname
end
