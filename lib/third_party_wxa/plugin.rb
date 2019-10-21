module ThirdPartyWxa
	class Plugin

		include Api::Authorize
		include Api::Code
		include Api::Login
		include Api::Member
		include Api::Qrcode
		include Api::Server
		include Api::Template

		attr_accessor :appid, :appsecret
		attr_accessor :component_verify_ticket, :ticket_expire_at
		attr_accessor :component_access_token, :component_expire_at	#2小时
		attr_accessor :pre_auth_code,	:pre_expire_at	#10分钟
		attr_accessor :token_store, :redis_key

		def initialize ticket = nil
			@appid = ThirdPartyWxa.appid
			@appsecret = ThirdPartyWxa.appsecret
			@component_verify_ticket = ticket
			@token_store = token_store_init
			@redis_key = ThirdPartyWxa.redis_key || 'third_party_wxa_component_token'
			p "third party wxa use #{@token_store.class.to_s}"
		end

		def set_tickect ticket, expire_in
			@component_verify_ticket = ticket
			@ticket_expire_at = ThirdPartyWxa.cal_expire_at expire_in
			self
		end

		def get_component_access_token
			m = Mutex.new
			m.synchronize{
				token_store.set_token if !token_store.valid?
				token_store.get_token
			}
		end

		def pre_auth_code_valid?
			return false if @pre_auth_code.nil? || @pre_expire_at.nil?
			Time.now.to_i <= @pre_expire_at
		end

		def get_pre_auth_code
			set_pre_auth_code if !pre_auth_code_valid?
			@pre_auth_code
		end

		def set_pre_auth_code
			res = pre_auth_code_api
			@pre_auth_code = res['pre_auth_code']
			@pre_expire_at = ThirdPartyWxa.cal_expire_at res['expires_in']#, 60
			self
		end

		def token_store_init
			Token::Store.init_with(self)
		end

		def get_authorizer_access_token options={}
			authorizer_access_token_api options.delete(:code)
		end

		def refresh_authorizer_access_token options={}
			authorizer_access_token_fresh options.delete(:appid), options.delete(:refresh_token)
		end

		def http_get scope, url, url_params={}
			url_params.merge! token_params
			ThirdPartyWxa.http_get_without_component_access_token scope, url, url_params
		end

		def http_post scope, url, post_params={}, url_params={}
			url_params.merge! token_params
			ThirdPartyWxa.http_post_without_component_access_token scope, url, post_params, url_params
		end

		def http_get_with_token options, scope, url, url_params={}
			url_params.merge! auth_token_params(options)
			ThirdPartyWxa.http_get_without_component_access_token scope, url, url_params
		end

		def http_post_with_token options, scope, url, post_params={}, url_params={}
			url_params.merge! auth_token_params(options)
			ThirdPartyWxa.http_post_without_component_access_token scope, url, post_params, url_params
		end


		private
		def token_params
			{access_token: get_component_access_token}
		end

		def auth_token_params options
			{access_token: options.delete(:access_token)}
		end

		def wx_redis
			ThirdPartyWxa.wx_redis
		end



	end
end