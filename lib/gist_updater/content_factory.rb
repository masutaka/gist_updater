# frozen_string_literal: true

module GistUpdater
  # ContentFactory
  class ContentFactory
    def self.build(user, access_token, config, content_class = Content)
      content_class.new(
        user: user,
        access_token: access_token,
        gist_id: config[0],
        file_name: config[1]
      )
    end
  end
end
