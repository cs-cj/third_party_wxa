module ThirdPartyWxa
	module Token

		class LocalStore < Store

			def valid?
				return false if plugin.component_access_token.nil? || plugin.component_expire_at.nil?
				Time.now.to_i <= plugin.component_expire_at
			end

			def set_token
				res = plugin.component_access_token_api
				plugin.component_access_token = res['component_access_token']
				plugin.component_expire_at = ThirdPartyWxa.cal_expire_at res['expires_in']
				plugin
			end

			def get_token
				plugin.component_access_token
			end


		end

	end
end