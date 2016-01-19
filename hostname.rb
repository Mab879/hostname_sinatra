require 'sinatra'
require 'resolv'

get '/' do
  @hostname = get_hostname
  erb :index
end

get '/ip' do
  request.ip
end

get '/hostname' do
  get_hostname
end

get '/ipv4' do
  'document.getElementById("ipv4_ip").innerHTML = "<br /> IPv4: <%= request.remote_ip %>"'
  'document.getElementById("ipv4_hostname").innerHTML = "<br /> IPv4: <%= @hostname %>"'
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
