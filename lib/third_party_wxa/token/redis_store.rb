module ThirdPartyWxa
	module Token

		class RedisStore < Store

			def valid?
				return false if wx_redis.hget(plugin.redis_key, 'component_access_token').blank?
				Time.now.to_i <= wx_redis.hget(plugin.redis_key, 'component_expire_at').to_i
			end

			def set_token
				res = plugin.component_access_token_api
				wx_redis.hmset plugin.redis_key,
											'component_access_token', res['component_access_token'],
											'component_expire_at', ThirdPartyWxa.cal_expire_at(res['expires_in'])
				plugin
			end

			def get_token
				wx_redis.hget(plugin.redis_key, 'component_access_token')
			end

			def wx_redis
				ThirdPartyWxa.wx_redis
			end


		end

	end
end