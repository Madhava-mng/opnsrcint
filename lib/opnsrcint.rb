# frozen_string_literal: true

require_relative "opnsrcint/version"
require_relative "opnsrcint/user"


module Opnsrcint
  def search_for_username(usernames, verbose, plus_18)
    usernames.map do |user_name|
      user = User::new(user_name, verbose, plus_18)
      user.scan_user
    end
  end
end

include Opnsrcint
