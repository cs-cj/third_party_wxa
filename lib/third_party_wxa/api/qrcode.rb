module ThirdPartyWxa
	module Api
		module Qrcode

			# 获取小程序码
			# 接口A: 适用于需要的码数量较少的业务场景 接口地址：
			# https://api.weixin.qq.com/wxa/getwxacode?access_token=ACCESS_TOKEN
			def get_wxa_code options = {}
				path = options.delete(:path)
				width = options.delete(:width) || 430 
				http_post_with_token options, 
									'wxa', 
									'getwxacode', 
									{path: path, width: width}
			end

			# # 获取体验小程序的体验二维码
			# # https://api.weixin.qq.com/wxa/ get_qrcode?access_token=TOKEN&path=page%2Findex%3Faction%3D1
			# def get_qrcode(sign, path = nil)
			# 	params = {}
			# 	params.merge!({path: path}) if path.present?
			# 	http_get_with_token sign, 'wxa', 'get_qrcode', params
			# end

		end
	end
end