$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'test/unit'
require 'proxy/header'
require 'pp'


class TestHeader < Test::Unit::TestCase

  def setup
      @data = open(File.join(File.dirname(__FILE__), "..", "data", "google.com")).read
      @fd = open(File.join(File.dirname(__FILE__), "..", "data", "google.com"))
  end

  def teardown
  end

  def test_header_parse
      h, b = @data.split("\r\n\r\n")
      headers = Proxy::Header.parse(h)
      # headers.keys.map { |k| p "#{k} =>  #{headers[k]}" }
  end

  def test_header_parse_by_line
      headers = Proxy::Header.parse_by_line(@fd)
      # headers.keys.map { |k| p "#{k} =>  #{headers[k]}" }
  end

  def test_body_parse_chunked
      headers = Proxy::Header.parse_by_line(@fd)
      body, h = Proxy::Body.parse_chunked(headers, @fd) 
      assert(h['Content-Length'] == 6484, "Correct content length parsed.")
  end


end
