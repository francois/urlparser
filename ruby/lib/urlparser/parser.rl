require "ostruct"

module UrlParser
  class Parser

    def parse(str)
      data = str.unpack("C*")
      parts = Hash.new
      eof = :eof # Why do I need to declare it myself?

      %%{
          machine urlparser;

          action begin_scheme   { the_scheme_start = p }
          action scheme         { parts[:scheme] = data[the_scheme_start ... p].pack("C*") }

          action begin_user     { the_user_start = p }
          action user           { parts[:user] = data[the_user_start ... p].pack("C*") }

          action begin_password { the_password_start = p }
          action password       { parts[:password] = data[the_password_start ... p].pack("C*") }

          action begin_host     { the_host_start = p; p "begin host: #{p}" }
          action host           { parts[:host] = data[the_host_start ... p].pack("C*"); p "end host: #{p}" }

          action begin_port     { the_port_start = p; p "begin port: #{p}" }
          action port           { parts[:port] = data[the_port_start ... p].pack("C*").to_i; "end port: #{p}" }

          action begin_path     { the_path_start = p; p "begin path: #{p}" }
          action path           { parts[:path] = data[the_path_start ... p].pack("C*"); p "end path: #{p}" }

          include url "url.rl";

          main := url;

          write data;

          write init;
          write exec;
        }%%

        OpenStruct.new(parts)
    end

  end
end
