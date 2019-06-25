module ThirdPartyWxa
	module Token

		class LocalStore < Store

			def authorizer_access_token_valid *args
				raise 'local_store --- please check expire_time yourself'
			end

			def get_authorizer_access_token *args
				raise 'local_store --- get token from your local store'
			end

			def exchange_authorizer_access_token code. sign=nil
				plugin.authorizer_access_token_api code
			end

			def refresh_authorizer_access_token auth_appid, refresh_token
				plugin.authorizer_access_token_fresh auth_appid, refresh_tokne
			end


		end

	end
end