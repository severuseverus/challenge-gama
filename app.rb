# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'httparty'

get '/' do
	endereco = params['url']

	if (endereco == nil) then
		parsed = "Nenhum endereço encontrado"
	else
		escaped  = URI.escape(endereco)
		url      = "http://maps.google.com/maps/api/geocode/json?address=#{escaped}"
		response = HTTParty.get(url)
		parsed   = JSON.parse(response.body)['results'][0]['formatted_address']
	end
  	erb :index, :locals => {result: parsed}
end

