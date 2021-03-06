require_relative 'version'

NAME_SERVERS = {
  "Cloudflare": ['1.1.1.1', '1.0.0.1'],
  "Google": ['8.8.8.8', '8.8.4.4'],
  "Quad9": ['9.9.9.9', '149.112.112.112'],
  "OpenDns": ['208.67.222.222', '208.67.220.222']
}

TIME_OUT = 1
MAX_THREAD = 50
WORDLIST = Gem::path[1]+"/gems/opnsrcint-#{Opnsrcint::VERSION}/dict/subdomain.txt" 

require 'resolv'
require 'resolv-replace'

class Subdomain_enum


  attr_accessor :target, :wordlist, :timeout, :max_thread


  def initialize
    @timeout = TIME_OUT
    @max_thread = MAX_THREAD
    @wordlist = WORDLIST
  end

  def loader(list)
    return Resolv::DefaultResolver.replace_resolvers([
      Resolv::Hosts.new,
      Resolv::DNS.new(
        nameserver: list,
        ndots: 1
      )
    ])
  end



  def get_domain(domain)
    NAME_SERVERS.keys.shuffle.map do |dns|

      begin

        Timeout::timeout(@timeout) do
          addrs = Resolv::new(
            loader(NAME_SERVERS[dns])
          ).getaddresses(domain)


          if addrs.length > 0
            return addrs
          end

        end
      
      rescue Timeout::Error => e
      end

    end
    return []
  end

  def print_domain(domain)
    response = get_domain(domain)
    if response.length > 0
      puts "\e[32m#{domain}\e[0m :#{response.join("\e[2m/\e[0m")}"
    end
  end

  def brut

    File.open(@wordlist).readlines.map do |line|

      Thread::new do

        print_domain(
          [line.chomp, @target.strip].join(".")
        )

      end

      sleep 0.03

      while Thread::list.length > @max_thread;end

    end

    while Thread::list.length > 1;end

  end

end

