require 'net/http'
require 'json'

class Mail_leak
  attr_accessor:mail,:url
  def initialize
    @url = {
      "psbdmp": "https://psbdmp.ws/api/search/#{@mail}",
      "emailrep":"https://emailrep.io/#{@mail}",
    }
  end

  def search_mail(mail)
    Thread::new do
      res = Net::HTTP::get_response(
        URI "https://psbdmp.ws/api/search/#{mail}"
      )
      if res.code == '200'
        data = JSON::parse(res.body)

        if data.length > 0
          puts "\e[31m•>\e[0m #{data["search"]} :breached"

          data["data"].each do |e|
            e.keys.each do |v|
              puts "\e[32m#{v}\e[0m:#{e[v]}"
            end
          end
        end

      end
    end

    Thread::new do
      res = Net::HTTP::get_response(
        URI "https://emailrep.io/#{mail}"
      )

      if res.code == '200'
        data = JSON::parse(res.body)

        puts "\e[31m•>\e[0m #{data["email"]} :breached :#{data["reputation"]}"

        data["details"].keys.map do |k|
          puts "\e[32m#{k}\e[0m:#{data["details"][k]}"
        end
      
      end
    end

    while Thread::list::length > 1;sleep 0.5;end
  end

end

