$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'test/unit'
require 'proxy/header'
require 'pp'


class TestHeader < Test::Unit::TestCase

  def setup
      @data = open(File.join(File.dirname(__FILE__), "..", "data", "google.com")).read
  end

  def teardown
  end

  def test_header
      h, b = @data.split("\r\n\r\n")
      headers = Proxy::Header.parse(h)
      headers.keys.map { |k| p "#{k} =>  #{headers[k]}" }
  end


end
