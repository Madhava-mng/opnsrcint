require 'net/http';
require_relative 'script'

class User
  attr_accessor :user, :url_list, :tmp_list, :verbose
  def initialize(user, verbose=false, prono=false)
    @user = user
    @verbose = verbose
    puts "\e[36;1mTarget\e[0m :#{user} :collecting info by username"
    @tmp_list = []
    @url_list = {
      "github": [URI("https://github.com/"+@user), '200', 'github'],
      "pypi": [URI("https://pypi.org/user/#{@user}/"), '200', 'pypi'],
      "pypi*C": [URI("https://pypi.org/user/#{@user.capitalize}/"), '200', 'pypi'],
      "udemy": [URI("https://www.udemy.com/user/#{@user}/"), '200', ''],
      "linode": [URI("https://www.linode.com/blog/linode/#{@user}/"), '200', ''],
      "packtpub":[URI("https://www.packtpub.com/authors/#{@user}"), '200', ''],
      "patreon":[URI("https://www.patreon.com/#{@user}"), '200', ''],
      "vimeo":[URI("https://vimeo.com/#{@user}"), '200', ''],
      "soundcloud":[URI("https://soundcloud.com/#{@user}"), '200', ''],
      "academia":[URI("https://independent.academia.edu/#{@user}"), '200', ''],
      "picuki":[URI("https://www.picuki.com/profile/#{@user}"), '200'],
      "networkcomputing":[URI("https://www.networkcomputing.com/author/#{@user}"), '200', ''],
      "m.facebook":[URI("https://m.facebook.com/#{@user}"), '200', ''],
      "credly":[URI("https://www.credly.com/users/#{@user}"), '302', ''],
      "similarchannels":[URI("https://similarchannels.com/c/#{@user}"), '200', ''],
      "pinterest":[URI("https://za.pinterest.com/#{@user}/"), '200', ''],
      "republic":[URI("https://republic.co/#{@user}"), '200', ''],
      "voices":[URI("https://www.voices.com/profile/#{@user}/"), '200', ''],
      "texascyber":[URI("https://texascyber.com/speaker/#{@user}/"), '200', ''],
      "skynettools":[URI("https://skynettools.com/tag/#{@user}/"), '200', ''],
      "twitch":[URI("https://m.twitch.tv/#{@user}"), '200', ''],
      "cbtnuggets":[URI("https://www.cbtnuggets.com/trainers/#{@user}"), '200', ''],
      "gravatar":[URI("http://en.gravatar.com/#{@user}"), '200', '']
      }
    plus_18 ={
      "xcamsters":[URI("https://www.xcamsters.com/chat/#{@user}"), '200', ''],
      "camster":[URI("https://www.camster.com/?model=#{@user}"), '200', ''],
      "freecam..":[URI("https://www.freecamsters.com/chat/#{@user}"), '200', ''],
      "stripchat":[URI("https://stripchat.com/#{@user}"), '200', ''],
      "teencam..":[URI("https://www.teencamsters.com/chat/#{@user}"), '200', ''],
      "xhamster..":[URI("https://xhamsterlive.com/#{@user}"), '200', ''],
    }

    if prono
      @url_list.update(plus_18)
    end
    end

  def print_(s, w, c=':')
    if !@tmp_list.include? w
      @tmp_list.append(w)
      puts "\e[32;1m•>\e[0m \e[31m#{s.to_s}\e[33;1m#{c}\e[0m #{w}"
    end
  end


  def scan_user
    @url_list.keys.map do |key|
      sleep 0.1
      Thread::new do
        begin
          res = Net::HTTP::get_response(@url_list[key][0])
          if res.code != '404'
            if res.code == @url_list[key][1]
              print_(key, @url_list[key][0])
              URI.extract(res.body).uniq do |line|
                if !tmp_list.include? line
                  if line.include? 'mail.com'
                    print_("Mail", line, ':📨:')
                  elsif line.include? 'https://twiter.com' and line != 'https://twiter.com'
                    print_("twiter", line)
                  elsif line.include? 'https://facebook.com' and line != 'https://facebook.com'
                  elsif line.include? 'https://yahoo.com' and line != 'https://yahoo.com'
                    print_("yahoo", line)
                    print_("facebook", line)
                  elsif line.include? 'https://t.me/'
                    print_("telegram", line)
                  elsif line.include? 'https://www.instagram.com/' and line != 'https://www.instagram.com/'
                    print_("instagram", line)
                  elsif line.include? 'https://linkedin.com/' and line != 'https://linkedin.com/'
                    print_("linkedin", line)
                  elsif line.include? "#{@user}" and @verbose
                    print_(URI(line).hostname, "\e[2m#{line}\e[0m")
                  end
                end
              end
              Script::new(@url_list[key][0], @url_list[key][2], @user, @mini_logo, @verbose).run
            end
          end
        rescue => e
          puts "\e[2mError: #{e}\e[0m"
        end
        while Thread::list.length > 50;end
      end
    end

    # wait untill the thread complete
    while Thread::list.length > 1
    end
  end
end
