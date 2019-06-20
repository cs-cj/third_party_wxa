module ThirdPartyWxa
	module Api
		module Token

			# https://api.weixin.qq.com/cgi-bin/component/api_component_token
			def component_access_token_api
				params = {component_appid: appid, component_appsecret: appsecret, component_verify_ticket: component_verify_ticket} 
				ThirdPartyWxa.http_post_without_component_access_token 'cgi-bin', 'component/api_component_token', params
			end


			# 通过component_access_token获取pre_auth_code
			# https://api.weixin.qq.com/cgi-bin/component/api_create_preauthcode?component_access_token=xxx
			def pre_auth_code_api
				params = {component_appid: appid}
				ThirdPartyWxa.http_post_without_component_access_token 'cgi-bin', 'component/api_create_preauthcode', params, {component_access_token: get_component_access_token}
			end


		end
	end
end