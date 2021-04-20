require "selenium-webdriver"
require "rspec"

class Env
	include Selenium


	#return date to populate test name in browserstack
	def get_ini_test_name
		time = Time.new
		puts Time.now.strftime("%b-%d-%Y")
		return Time.now.strftime("%b-%d-%Y")
	end
	
end
		