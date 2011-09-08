require "spec_helper"

p __FILE__

describe "Parsing the generic URL 'tcp://fbeausoleil:thepassword@c.com:3391/def'" do
  def url
    @url ||= UrlParser.parse("tcp://fbeausoleil:thepassword@c.com/def")
  end

  it "should recognize the 'tcp' scheme" do
    url.scheme.must_equal "tcp"
  end

  it "should recognize the 'fbeausoleil' user" do
    url.user.must_equal "fbeausoleil"
  end

  it "should recognize the 'thepassword' thepassword" do
    url.password.must_equal "thepassword"
  end

  it "should recognize the 'c.com' hostname" do
    url.host.must_equal "c.com"
  end

  it "should recognize the '3391' port" do
    url.port.must_equal 3391
  end

  it "should recognize the '/def' path" do
    url.path.must_equal "/def"
  end
end

describe "Parsing the generic URL 'udp://127.0.0.1:1234'" do
  def url
    @url ||= UrlParser.parse("udp://127.0.0.1:1234")
  end

  it "should recognize the 'udp' scheme" do
    url.scheme.must_equal "udp"
  end

  it "should NOT recognize a user" do
    url.user.must_be_nil
  end

  it "should NOT recognize a password" do
    url.password.must_be_nil
  end

  it "should recognize a numerical host" do
    url.host.must_equal "127.0.0.1"
  end

  it "should recognize a port" do
    url.port.must_equal 1234
  end

  it "should NOT recognize a path" do
    url.path.must_be_nil
  end
end
