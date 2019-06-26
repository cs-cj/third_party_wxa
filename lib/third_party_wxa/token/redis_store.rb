module ThirdPartyWxa
	module Token

		class RedisStore < Store


			def authorizer_access_token_valid? options
				expire_at = wx_redis.hget options[:redis_key], 'expire_at'
				return false if wx_redis.hget(options[:redis_key], 'access_token').blank? || expire_at.blank?
				Time.now.to_i <= expire_at.to_i
			end

			def get_authorizer_access_token options
				if !authorizer_access_token_valid?(options)  # raise exception?
					if wx_redis.hget(options[:redis_key], 'refresh_token').present?
						auth_appid = wx_redis.hget(options[:redis_key], 'appid')
						refresh_token = wx_redis.hget(options[:redis_key], 'refresh_token')
						refresh_authorizer_access_token auth_appid, refresh_token
					else
						raise 'refresh token is missing, please authorize again'
					end
				end
				wx_redis.hget(options[:redis_key], 'access_token')
			end

			def exchange_authorizer_access_token options
				res = plugin.authorizer_access_token_api options[:code]
				authorizer_access_token = res['authorization_info']['authorizer_access_token']
				authorizer_appid = res['authorization_info']['authorizer_appid']
				authorizer_expire_at = ThirdPartyWxa.cal_expire_at res['authorization_info']['expires_in']
				authorizer_refresh_token = res['authorization_info']['authorizer_refresh_token']
				wx_redis.hset options[:redis_key], 'access_token', authorizer_access_token, 'appid', authorizer_appid,
								'expire_at', authorizer_expire_at, 'refresh_token', authorizer_refresh_token
				authorizer_access_token
			end

			def refresh_authorizer_access_token auth_appid, refresh_token
				res = plugin.authorizer_access_token_fresh auth_appid, refresh_tokne
				authorizer_access_token = res['authorizer_access_token']
				authorizer_expire_at = ThirdPartyWxa.cal_expire_at res['expires_in']
				authorizer_refresh_token = res['authorizer_refresh_token']
				wx_redis.hset options[:redis_key], 'access_token', authorizer_access_token,
								'expire_at', authorizer_expire_at, 'refresh_token', authorizer_refresh_token
				authorizer_access_token
			end


		end

	end
end