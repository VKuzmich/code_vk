# frozen_string_literal: true

module CodebreakerVk
  module Uploader
    PATH_FOLDER = './data_base/'
    PATH_NAME = 'database'
    PATH_FORMAT = '.yaml'
    PATH = PATH_FOLDER + PATH_NAME + PATH_FORMAT

    def load_db
      File.exist?(PATH) ? YAML.load_stream(File.open(PATH)) : []
    end

    def save_to_db(results)
      File.open(PATH, 'a') { |f| f.write results.to_yaml }
    end
  end
end
