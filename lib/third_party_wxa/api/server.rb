module ThirdPartyWxa
	module Api
		module Server

			# 1、设置小程序服务器域名
			# post https://api.weixin.qq.com/wxa/modify_domain?access_token=TOKEN
			def modify_domain options={}
				rest = options.slice!(:action, :requestdomain, :wsrequestdomain, :uploaddomain, :downloaddomain)
				http_post_with_token rest, 'wxa', 'modify_domain', options
			end

			# 2、设置小程序业务域名（仅供第三方代小程序调用）
			# post https://api.weixin.qq.com/wxa/setwebviewdomain?access_token=TOKEN
			def setwebviewdomain options={}
				rest = options.slice!(:action, :webviewdomain)
				http_post_with_token rest, 'wxa', 'setwebviewdomain', options
			end


		end
	end
end
