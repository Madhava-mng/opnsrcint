# frozen_string_literal: true

require_relative "opnsrcint/version"
require_relative "opnsrcint/subdomain_enum"
require_relative "opnsrcint/user"


module Opnsrcint
  def search_for_username(usernames, verbose=false, plus_18=false)
    usernames.map do |user_name|
      user = User::new(user_name, verbose, plus_18)
      user.scan_user
    end
  end
end

include Opnsrcint
