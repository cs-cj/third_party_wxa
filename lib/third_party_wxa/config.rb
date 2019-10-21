module ThirdPartyWxa

	class << self

		attr_accessor :config

		def configure
			yield self.config ||= Config.new
		end

		def wx_redis
			config.redis
		end

		def appid
			config.appid
		end

		def appsecret
			config.appsecret
		end

		def redis_key
			config.redis_key
		end

	end

	class Config
    	attr_accessor :redis, :appid, :appsecret, :redis_key
  	end

end
