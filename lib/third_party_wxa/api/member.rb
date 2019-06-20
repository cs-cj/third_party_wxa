module ThirdPartyWxa
	module Api
		module Member

			# 1、绑定微信用户为小程序体验者
 		 	# https://api.weixin.qq.com/wxa/bind_tester?access_token=TOKEN
 		 	def bind_tester test_id
 		 		http_post_with_token 'wxa', 'bind_tester', {wechatid: test_id}
 		 	end

 		 	# 2、解除绑定小程序的体验者
  			# https://api.weixin.qq.com/wxa/unbind_tester?access_token=TOKEN
  			def unbind_tester test_id
  				http_post_with_token 'wxa', 'unbind_tester', {wechatid: test_id}
  			end

  			# 3. 获取体验者列表
  			# https://api.weixin.qq.com/wxa/memberauth?access_token=TOKEN
  			def get_experiencer
  				http_post_with_token 'wxa', 'memberauth', {action:"get_experiencer"}
  			end

  			# 发送消息
  			def send_message query_auth_code
  				http_post_with_token 'cgi-bin', 'memberauth', {"touser": "OPENID", "msgtype": "text", "text": {"content":"#{query_auth_code}_from_api"}}
  			end



		end
	end
end