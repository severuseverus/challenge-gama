# encoding: UTF-8
require_relative '../app'
require 'minitest/autorun'
require 'rack/test'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_home
    get '/'
    assert_match /Busca de Endereço/, last_response.body
  end

  def test_home_busca_de_endereco
    endereco = 'Avenida Paulista, 1813'
    escaped  = URI.escape(endereco)
    get "/?url=#{escaped}"
    assert_match /Av. Paulista/, last_response.body
  end

  def test_home_busca_de_vazio
    endereco = ''
    escaped  = URI.escape(endereco)
    get "/?url=#{escaped}"
    assert_match /Nenhum endereço encontrado/, last_response.body
  end
end
