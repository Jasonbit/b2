require "httparty"
require 'helpers/configuration'

require "b2/version"
require "b2/authentication"
require "b2/base"
require "b2/bucket"
require "b2/doc"

BASE_URI = 'https://api.backblaze.com/b2api/v1/'
BASE_PATH = '/b2api/v1/'

module B2
  extend Configuration
  
  define_setting :account_id
  define_setting :application_key
end
