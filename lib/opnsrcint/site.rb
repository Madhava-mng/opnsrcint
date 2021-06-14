require 'net/http';

class Site
  attr_accessor :site
  def initialize(site)
    @site = site
    @tmp_list = []
  end

  def  print_(c, n='', cl="\e[2m", a='')
    if !@tmp_list.include? c
      @tmp_list.append(c)
      #puts "\e[32;1m•>\e[0m #{n} \e[33;1m#{a}\e[0m #{cl}#{c}\e[0m"
    end
  end

  def esculate_page(line, url)
    if line.start_with? "http"
      if !@tmp_list.include? line
        @tmp_list.append(line)
        if line.include? @site
          puts "•> \e[2m#{line}\e[0m"
          begin
            enum(url)
          rescue => e
            puts "#{url}:#{e}"
          end
        else
          puts "•> \e[32m#{line}\e[0m"
        end
      end
    elsif line.include? 'mail.com'
      if !@tmp_list.include? line
        @tmp_list.append(line)
        puts "•> Mail \e[33;1m~> \e[0m\e[36m#{line}\e[0m"
      end
    end
  end

  def enum(url)
    res = Net::HTTP::get_response(URI(url))
    if !['404', '403'].include? res.code
      URI::extract(res.body) do |line|
        Thread::new do
          esculate_page(line, url)
        end
        sleep 0.1
      end
    end
  end

  def scan
    enum(@site)
    while Thread::list.length > 1;end
  end
end

a = Site::new("https://red5cracker.wordpress.com")
#a = Site::new("https://hsploit.com")
a.scan
