module ThirdPartyWxa
	module Api
		module Member

			# 1、绑定微信用户为小程序体验者
 		 	# https://api.weixin.qq.com/wxa/bind_tester?access_token=TOKEN
 		 	def bind_tester options={}
 		 		http_post_with_token options, 'wxa', 'bind_tester', {wechatid: options.delete(:wechatid)}
 		 	end

 		 	# 2、解除绑定小程序的体验者
  			# https://api.weixin.qq.com/wxa/unbind_tester?access_token=TOKEN
  			def unbind_tester options={}
  				http_post_with_token options, 'wxa', 'unbind_tester', {wechatid: options.delete(:wechatid)}
  			end

  			# 3. 获取体验者列表
  			# https://api.weixin.qq.com/wxa/memberauth?access_token=TOKEN
  			def get_experiencer options={}
          options.delete(:action)
  				http_post_with_token options, 'wxa', 'memberauth', {action:"get_experiencer"}
  			end



		end
	end
end