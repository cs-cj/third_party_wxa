module ThirdPartyWxa
	module Api
		module Proxy

			# 获取授权小程序帐号的可选类目
			# https://api.weixin.qq.com/wxa/get_category?access_token=TOKEN
			def  get_category
				http_get_with_token 'wxa', 'get_category'
			end

			# 获取小程序的第三方提交代码的页面配置（仅供第三方开发者代小程序调用）
			# https://api.weixin.qq.com/wxa/get_page?access_token=TOKEN
			def get_page
				http_get_with_token 'wxa', 'get_page'
			end

			# 将第三方提交的代码包提交审核（仅供第三方开发者代小程序调用
			# https://api.weixin.qq.com/wxa/submit_audit?access_token=TOKEN
			def submit_audit config_json
				http_post_with_token 'wxa', 'submit_audit', config_json
			end

			# 7、查询某个指定版本的审核状态（仅供第三方代小程序调用
			# https://api.weixin.qq.com/wxa/get_auditstatus?access_token=TOKEN
			def get_auditstatus auditid
				http_post_with_token 'wxa', 'get_auditstatus', {auditid: auditid}
			end

			# 8、查询最新一次提交的审核状态（仅供第三方代小程序调用）
			# https://api.weixin.qq.com/wxa/get_latest_auditstatus?access_token=TOKEN
			def get_latest_auditstatus
				http_get_with_token 'wxa', 'get_latest_auditstatus'
			end

			# 9、发布已通过审核的小程序（仅供第三方代小程序调用）
  			# https://api.weixin.qq.com/wxa/release?access_token=TOKEN
  			def release
  				http_post_with_token 'wxa', 'release'
  			end

  			# 10、修改小程序线上代码的可见状态（仅供第三方代小程序调用）close为不可见，open为可见
  			# https://api.weixin.qq.com/wxa/change_visitstatus?access_token=TOKEN
  			def change_visitstatus action
  				http_post_with_token 'wxa', 'change_visitstatus', {action: action}
  			end

		end
	end
end