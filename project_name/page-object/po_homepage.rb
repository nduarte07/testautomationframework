	require "selenium-webdriver"

	class PO_HOMEPAGE
		include Selenium
		
		#ACT ========================================
		def initialize(driver)
			@driver = driver
		end

		def get_base_url(proj_env)
			case proj_env
		    	when "PROD"
		        	return "https://yourPRODurl"
		    	when "DEV"
		        	return "https://yourDEVurl"
		    	when "QA"
		        	return "https://yourQAurl"
		     end
		end

		def close_policy
			sleep 3
			locate = @driver.find_element(:id, "popup-buttons").displayed?
			puts "Cookies button displayed: #{locate}"
			
			if locate
				@driver.find_element(:xpath,"//*[@id='popup-buttons']/button[1]").click
				puts "Cookies alert closed"
				sleep 3
			end

			rescue Selenium::WebDriver::Error::NoSuchElementError

		end

		def close_cookies
			sleep 3
			locate = @driver.find_element(:link_text,"Close").displayed?
			puts "Cookies button displayed: #{locate}"
			
			if locate
				@driver.find_element(:link_text,"Close").click
				puts "Cookies alert closed"
				sleep 3
			end

			rescue Selenium::WebDriver::Error::NoSuchElementError

		end



#========================== GET PARAMETER

		def return_login
			return "auto_neli"
		end

		def return_password
			return "automation"
		end
end
			