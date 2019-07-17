module ThirdPartyWxa
	module Api
		module Template

			# 获取代码模版库中的所有小程序代码模版
			# https://api.weixin.qq.com/wxa/gettemplatelist?access_token=TOKEN
			def get_template_list
		    	http_get 'wxa', 'gettemplatelist'
			end

			# 获取草稿箱内的所有临时代码草稿
			def get_template_draft_list
				http_get 'wxa', 'gettemplatedraftlist'
			end

			# 将草稿箱的草稿选为小程序代码模版
			def add_to_template(draft_id)
				http_post 'wxa', 'addtotemplate', {draft_id: draft_id}
			end

			# 删除指定小程序代码模版
			def delete_template(template_id)
				http_post 'wxa', 'deletetemplate', {template_id: template_id}
			end



		end
	end
end