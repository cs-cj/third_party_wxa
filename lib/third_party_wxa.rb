require 'rest_client'
require 'redis'
# require "third_party_wxa/version"
require 'third_party_wxa/config'
require "third_party_wxa/api"
require 'third_party_wxa/plugin'
module ThirdPartyWxa

	module Token
		autoload(:Store,       		"third_party_wxa/token/store")
		autoload(:LocalStore,       "third_party_wxa/token/local_store")
		autoload(:RedisStore,       "third_party_wxa/token/redis_store")
	end


  	BASE = 'https://api.weixin.qq.com/'.freeze
  	# scope => [cgi-bin, wxa]
	class << self
		def http_get_without_component_access_token scope, url, url_params={}
			url = "#{BASE}#{scope}/#{url}"
			p "get -----  #{url}"
			JSON.parse RestClient.get URI.encode(url), {params: url_params}
		end

		# url cant end with '/', url should be encoded
		def http_post_without_component_access_token scope, url, post_params={}, url_params={}
			url = "#{BASE}#{scope}/#{url}"
			param = url_params.to_param
			url += "?#{param}" if !param.blank?
			p "post -----  #{url}"
			p post_params
			JSON.parse RestClient.post URI.encode(url), post_params.to_json
		end

		def pre_expire
			5.minutes.to_i
		end

		def cal_expire_at expire_in, pre=nil
			return (Time.now.to_i + expire_in.to_i - pre_expire) if pre.blank?
			Time.now.to_i + expire_in.to_i - pre
		end
	end
end

module ThirdPartyWxa
  class Error < StandardError; end
  # Your code goes here...
end
