require "selenium-webdriver"
#require "rspec"

class HOMEPAGE_Env
	include Selenium

	def initialize
		@caps = Selenium::WebDriver::Remote::Capabilities.firefox()
	end
	
	def get_caps(test_name,env)

		@caps['platform'] = 'Windows 10'
		#@caps['build'] = '1.0'
		@caps['name'] = test_name
		@caps['browserName'] = 'firefox'
		@caps['version'] = '63'
		@caps['screenResolution'] = '1024x768'
		#@caps['autoAcceptAlerts'] = true

		return @caps
	end

	#return date to populate test name in browserstack
	def get_ini_test_name
		time = Time.new
		puts Time.now.strftime("%b-%d-%Y")
		return Time.now.strftime("%b-%d-%Y")
	end

end
		