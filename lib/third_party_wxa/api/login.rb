module ThirdPartyWxa
	module Api
		module Login

			# code 换取 session_key
			# get https://api.weixin.qq.com/sns/component/jscode2session?appid=APPID&js_code=JSCODE&grant_type=authorization_code&component_appid=COMPONENT_APPID&component_access_token=ACCESS_TOKEN
			# support local store only now
			def jscode2session options
				params = {
					component_appid: appid,
					component_access_token: get_component_access_token,
					grant_type: 'authorization_code'
				}.merge!(options.slice(:appid, :js_code))
				ThirdPartyWxa.http_get_without_component_access_token 'sns', 'component/jscode2session', params
			end

		end
	end
end