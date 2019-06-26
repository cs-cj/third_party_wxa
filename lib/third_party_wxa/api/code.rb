module ThirdPartyWxa
	module Api
		module Code

			# 1、为授权的小程序帐号上传小程序代码
			# post https://api.weixin.qq.com/wxa/commit?access_token=TOKEN
			def commit options={}
				rest = options.slice!(:template_id, :ext_json, :user_version, :user_desc)
				http_post_with_token rest, 'wxa', 'commit', options
			end

			# 2、获取体验小程序的体验二维码
			# get https://api.weixin.qq.com/wxa/get_qrcode?access_token=TOKEN&path=page%2Findex%3Faction%3D1
			def get_qrcode options={}
				rest = options.slice!(:path)
				http_get_with_token rest, 'wxa', 'get_qrcode', options
			end

			# 3、获取授权小程序帐号已设置的类目
			# get https://api.weixin.qq.com/wxa/get_category?access_token=TOKEN
			def get_category options={}
				http_get_with_token options, 'wxa', 'get_category'
			end

			# 4、获取小程序的第三方提交代码的页面配置（仅供第三方开发者代小程序调用）
			# get https://api.weixin.qq.com/wxa/get_page?access_token=TOKEN
			def get_page options={}
				http_get_with_token options, 'wxa', 'get_page'
			end

			# 5、将第三方提交的代码包提交审核（仅供第三方开发者代小程序调用）
			# post https://api.weixin.qq.com/wxa/submit_audit?access_token=TOKEN
			def submit_audit options={}
				rest = options.slice!(:item_list, :feedback_info, :feedback_stuff)
				http_post_with_token rest, 'wxa', 'submit_audit', options
			end

			# 7、查询某个指定版本的审核状态（仅供第三方代小程序调用）
			# post https://api.weixin.qq.com/wxa/get_auditstatus?access_token=TOKEN 
			def get_auditstatus options={}
				rest = options.slice!(:auditid)
				http_post_with_token rest, 'wxa', 'get_auditstatus', options
			end

			# 8、查询最新一次提交的审核状态（仅供第三方代小程序调用）
			# get https://api.weixin.qq.com/wxa/get_latest_auditstatus?access_token=TOKEN
			def get_latest_auditstatus options
				http_get_with_token options, 'wxa', 'get_latest_auditstatus'
			end

			# 9、发布已通过审核的小程序（仅供第三方代小程序调用)
			# post https://api.weixin.qq.com/wxa/release?access_token=TOKEN
			def release options={}
				http_post_with_token options, 'wxa', 'release', {}
			end

			# 10、修改小程序线上代码的可见状态（仅供第三方代小程序调用）
			# https://api.weixin.qq.com/wxa/change_visitstatus?access_token=TOKEN
			def change_visitstatus options={}
				rest = options.slice!(:action)
				http_post_with_token rest, 'wxa', 'change_visitstatus', options
			end

			# 11. 小程序版本回退（仅供第三方代小程序调用）
			# get https://api.weixin.qq.com/wxa/revertcoderelease?access_token=TOKEN
			def revertcoderelease options={}
				http_get_with_token options, 'wxa', 'revertcoderelease'
			end

			#

		end
	end
end