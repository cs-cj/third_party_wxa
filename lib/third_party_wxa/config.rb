module ThirdPartyWxa
	class Config
		attr_accessor :redis, :appid, :appsecret
	end

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

	end

end