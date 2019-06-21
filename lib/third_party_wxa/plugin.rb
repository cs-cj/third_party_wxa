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
		attr_accessor :authorizer_appid
		attr_accessor :authorizer_access_token, :authorizer_refresh_token, :authorizer_expire_at

		def initialize
			@appid = ENV['appid']
			@appsecret = ENV['appsecret']
		end

		def set_tickect ticket, expire_in
			@component_verify_ticket = ticket
			@ticket_expire_at = ThirdPartyWxa.cal_expire_at expire_in
			self
		end

		def component_access_token_valid?
			return false if @component_access_token.nil? || @component_expire_at.nil?
			@component_expire_at <= Time.now
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

		def authorizer_access_token_valid?
			return false if @authorizer_access_token.nil? || @authorizer_expire_at.blank?
			@authorizer_expire_at <= Time.now.to_i
		end

		def get_authorizer_access_token
			if !authorizer_access_token_valid? # raise exception?
				if @authorizer_refresh_token.present?
					refresh_authorizer_access_token
				else
					throw 'refresh token is missing, please authorize again'
				end
			end
			@authorizer_access_token
		end

		def set_authorizer_access_token code
			res = authorizer_access_token_api code
			@authorizer_access_token = res['authorization_info']['authorizer_access_token']
			@authorizer_appid = res['authorization_info']['authorizer_appid']
			@authorizer_expire_at = ThirdPartyWxa.cal_expire_at res['authorization_info']['expire_in']
			@authorizer_refresh_token = res['authorization_info']['authorizer_refresh_token']
			self
		end

		def refresh_authorizer_access_token
			res = authorizer_access_token_fresh
			@authorizer_access_token = res['authorizer_access_token']
			@authorizer_expire_at = ThirdPartyWxa.cal_expire_at res['expires_in']
			@authorizer_refresh_token = res['authorizer_refresh_token']
			self
		end

		def http_get scope, url, url_params={}
			url_params.merge! token_params
			ThirdPartyWxa.http_get_without_component_access_token scope, url, url_params
		end

		def http_post scope, url, post_params={}, url_params={}
			url_params.merge! token_params
			ThirdPartyWxa.http_post_without_component_access_token scope, url, post_params, url_params
		end

		def http_get_with_token scope, url, url_params={}
			url_params.merge! auth_token_params
			ThirdPartyWxa.http_get_without_component_access_token scope, url, url_params
		end

		def http_post_with_token scope, url, post_params={}, url_params={}
			url_params.merge! auth_token_params
			ThirdPartyWxa.http_post_without_component_access_token scope, url, post_params, url_params
		end


		private
		def token_params
			{access_token: get_component_access_token}
		end

		def auth_token_params
			{access_token: get_authorizer_access_token}
		end



	end
end