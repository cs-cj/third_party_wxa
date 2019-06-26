module ThirdPartyWxa
	class Plugin

		include Api::Token
		include Api::Template
		include Api::Member
		include Api::Qrcode
		include Api::Proxy
		include Api::Authorize

		attr_accessor :appid, :appsecret
		attr_accessor :component_verify_ticket, :ticket_expire_at
		attr_accessor :component_access_token, :component_expire_at	#2小时
		attr_accessor :pre_auth_code,	:pre_expire_at	#10分钟
		attr_accessor :token_store

		def initialize
			@appid = ThirdPartyWxa.appid
			@appsecret = ThirdPartyWxa.appsecret
			@token_store = token_store_init
			p "third party wxa use #{@token_store.class.to_s}"
		end

		def set_tickect ticket, expire_in
			@component_verify_ticket = ticket
			@ticket_expire_at = ThirdPartyWxa.cal_expire_at expire_in
			self
		end

		def component_access_token_valid?
			return false if @component_access_token.nil? || @component_expire_at.nil?
			@component_expire_at <= Time.now.to_i
		end

		def get_component_access_token 
			set_component_access_token if !component_access_token_valid?
			@component_access_token
		end

		def set_component_access_token
			res = component_access_token_api
			@component_access_token = res['component_access_token']
			@component_expire_at = ThirdPartyWxa.cal_expire_at res['expire_in']
			self
		end

		def pre_auth_code_valid?
			return false if @pre_auth_code.nil? || @pre_expire_at.nil?
			@pre_expire_at <= Time.now.to_i
		end

		def get_pre_auth_code
			set_pre_auth_code if !pre_auth_code_valid?
			@pre_auth_code
		end

		def set_pre_auth_code
			res = pre_auth_code_api
			@pre_auth_code = res['pre_auth_code']
			@pre_expire_at = ThirdPartyWxa.cal_expire_at res['expire_in'], 60
			self
		end

		def token_store_init
			Token::Store.init_with(self)
		end

		def authorizer_access_token_valid? sign
			token_store.authorizer_access_token_valid sign
		end

		def get_authorizer_access_token sign
			token_store.get_authorizer_access_token sign
		end

		def exchange_authorizer_access_token code, sign = nil
			token_store.exchange_authorizer_access_token code, sign
		end

		def refresh_authorizer_access_token auth_appid, refresh_token
			token_store.refresh_authorizer_access_token auth_appid, refresh_token
		end

		def http_get scope, url, url_params={}
			url_params.merge! token_params
			ThirdPartyWxa.http_get_without_component_access_token scope, url, url_params
		end

		def http_post scope, url, post_params={}, url_params={}
			url_params.merge! token_params
			ThirdPartyWxa.http_post_without_component_access_token scope, url, post_params, url_params
		end

		def http_get_with_token sign, scope, url, url_params={}
			url_params.merge! auth_token_params
			ThirdPartyWxa.http_get_without_component_access_token scope, url, url_params
		end

		def http_post_with_token sign, scope, url, post_params={}, url_params={}
			url_params.merge! auth_token_params
			ThirdPartyWxa.http_post_without_component_access_token scope, url, post_params, url_params
		end


		private
		def token_params
			{access_token: get_component_access_token}
		end

		def auth_token_params sign
			{access_token: get_authorizer_access_token(sign)}
		end

		def wx_redis
			ThirdPartyWxa.wx_redis
		end



	end
end