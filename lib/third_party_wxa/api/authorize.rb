module ThirdPartyWxa
	module Api
		module Authorize

			def componentloginpage_url redirect, sign, type=2
				redirect_uri = "#{redirect}?sign=#{sign}"
				"https://mp.weixin.qq.com/cgi-bin/componentloginpage?component_appid=#{appid}&pre_auth_code=#{get_pre_auth_code}&auth_type=#{type}&redirect_uri=#{redirect_uri}"
			end

			def bindcomponent redirect, type=2
				"https://mp.weixin.qq.com/safe/bindcomponent?action=bindcomponent&auth_type=#{type}&no_scan=1&component_appid=#{appid}&pre_auth_code=#{get_pre_auth_code}&redirect_uri=#{redirect}&auth_type=#{type}#wechat_redirect"
			end

			def authorizer_access_token_api(auth_code)
				params = {component_appid: appid, authorization_code: auth_code}
				ThirdPartyWxa.http_post_without_component_access_token 'cgi-bin','component/api_query_auth', params, {component_access_token: get_component_access_token}
			end

			#https:// api.weixin.qq.com /cgi-bin/component/api_authorizer_token?component_access_token=xxxxx
			def authorizer_access_token_fresh
				
				params = {
				"component_appid": appid,
				"authorizer_appid": wx_redis.hget(sign, 'appid'),
				"authorizer_refresh_token": wx_redis.hget(sign, 'refresh_token'),
				}
				http_post 'cgi-bin', 'component/api_authorizer_token', params
			end


		end
	end
end