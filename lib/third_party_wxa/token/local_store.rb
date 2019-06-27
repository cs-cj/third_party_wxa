module ThirdPartyWxa
	module Token

		class LocalStore < Store

			def authorizer_access_token_valid *args
				raise 'local_store --- please check expire_time yourself'
			end

			def get_authorizer_access_token options
				options.delete(:access_token)
			end

			def exchange_authorizer_access_token options
				plugin.authorizer_access_token_api options.delete(:code)
			end

			def refresh_authorizer_access_token options
				plugin.authorizer_access_token_fresh options.delete(:appid), options.delete(:refresh_token)
			end


		end

	end
end