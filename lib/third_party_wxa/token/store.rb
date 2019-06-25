module ThirdPartyWxa
	module Token

		class Store
			attr_accessor :plugin

			def initialize plugin
				@plugin = plugin
			end

			def self.init_with plugin
				if ThirdPartyWxa.wx_redis.nil?
					LocalStore.new plugin
				else
					RedisStore.new plugin
				end
			end

			def wx_redis
				ThirdPartyWxa.wx_redis
			end

		end

	end
end