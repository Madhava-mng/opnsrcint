require 'net/http'
require 'open-uri'
require 'json'

class Script
  attr_accessor :url, :script_name, :list,:user, :tmp_list, :mini_logo, :verbose
  def initialize(url, script_name, user, mini_logo=true, verbose=false)
    @min_logo = mini_logo
    @url = url
    @verbose = verbose
    @script_name = script_name
    @list = ['github', 'pypi']
    @user = user
    @tmp_list = []
  end

  def print_(s, w, c=':')
    if true and @mini_logo
      c = ':'
    end
    print "\e[32;1m•>\e[0m \e[31m#{s.to_s}\e[33;1m#{c}\e[0m #{w}\n"
  end

  def git_hub
    html = Net::HTTP::get_response(URI(@url+'?tab=repositories'))
    json_repos = JSON::parse(Net::HTTP::get_response(URI("https://api.github.com/users/#{@user}/repos")).body)
    result = ''
    html.body.split("\n").map do |line|
      if line.include? '<title>'
        line = line.strip
        line = line[7, line.length-38]
        result += ("(Github.com  name ) ~>  "+line+"\n")
      end
    end

    URI::extract(html.body) do |line|
      if !@tmp_list.include? line
        if line.include? "https://avatars.githubusercontent.com/"
          result += "   | Profile: \e[35;1m#{line}\e[0m\n"
          @tmp_list.append(line)
        end
      end
    end

    json_repos.length.times do |r|
      result += ("   | "+ json_repos[r]['svn_url']+"\n")
    end
    
    json_repos.length.times do |r|
      url = json_repos[r]['svn_url']
      sleep 0.1
      begin
        Thread::new do |e|
          html = Net::HTTP::get_response(URI(url))
          URI::extract(html.body) do |line|
            if line.include? 'https://gist.github.com' and line != 'https://gist.github.com'
              print_("gist", line )
            elsif line.include? 'https://facebook.com' and line != 'https://facebook.com'
              print_("facebook", line)
            elsif line.include? 'https://twiter.com' and line != 'https://twiter.com'
              print_("twiter", line)
            elsif line.include? 'https://yahoo.com' and line != 'https://yahoo.com'
              print_("yahoo", line)
            elsif line.include? 'https://t.me/' and line != 'https://t.me/'
              print_("telegram", line, "\e[m34;1m➣" )
            elsif line.include? 'mail.com'
              print_("Mail", line, ':📨:')
            elsif line.include? 'https://www.instagram.com/' and line != 'https://www.instagram.com/'
              print_("instagram", line)
            elsif line.include? 'https://linkedin.com/' and line != 'https://linkedin.com/'
              print_("linkedin", line)
            elsif line.include? "#{@user}" and @verbose and !line.start_with? 'https://github.com/'
              print_(URI(line).hostname, "\e[2m#{line}\e[0m")
            end
          end
        end
      rescue => e
        puts "\e[2mError: #{e}\e[0m"
      end
    end
    puts result
  end
  def run
    if @list.include? @script_name
      case @script_name
      when 'github'
        git_hub
      end
    end
  end

end
