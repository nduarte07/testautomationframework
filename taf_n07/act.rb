	#Action class of crf-taf - to be used in all automation project
	require "selenium-webdriver"

	class Act
		include Selenium
		
		
		#ACT ========================================
		def initialize(caps,browser_place)
			
			if (browser_place.include? ('local_profile') )
				
				#must creatfe a firefox profile named: automation_cloud with the basic authentication credentials saved
				profile = Selenium::WebDriver::Firefox::Profile.from_name 'automation'
				profile.add_extension '../../autoauth-2.1-fx+fn.xpi'
				@driver = Selenium::WebDriver.for :firefox, :profile => profile
				#options = Selenium::WebDriver::Firefox::Options.new
				#options.profile = profile
				#@driver = Selenium::WebDriver.for :firefox, options: options, :marionette => true

			elsif (browser_place.include?('local_no_profile'))
				@driver = Selenium::WebDriver.for :firefox
				
			elsif (browser_place.include?('bstack'))
				@driver =  Selenium::WebDriver.for(:remote,
			      	#browserstack
			      	:url => "frombrowserstack",
			      	:desired_capabilities => caps)
			
			elsif (browser_place.include?('remote'))
				@driver =  Selenium::WebDriver.for(:remote,
					#saucelabs
		            :url => "fromsaucelabs",
		            :desired_capabilities => caps)

			elsif (browser_place.include?('cbt'))
				  	#CBT
				user = 'user'
            	key = 'key'
				@driver =  Selenium::WebDriver.for(:remote,
	            	:url => "http://#{user}:#{key}@hub.crossbrowsertesting.com:80/wd/hub",
		            :desired_capabilities => caps) 
			end

			puts ""
			puts "Actions Initialize >> executed"
			puts ""
		end

		#close browser
		def teardown
			@driver.quit
			puts "Teardown >> executed"
		end

		#navigate to the URL
		def go_to_url(base_url)
			puts "Going to: #{base_url}" 
			@driver.get(base_url)
			@driver.manage.timeouts.implicit_wait = 10
		end
		
		#click in element in the screen
		def click_element(criteria, value, seconds_wait)    

			wait_for(seconds_wait) { @driver.find_element(criteria.to_sym,value).displayed? }
			@driver.find_element(criteria.to_sym, value).click

		rescue Selenium::WebDriver::Error::NoSuchElementError
			false
		end 

		#method to send keys to the form
		def fill_form(criteria,field,value,seconds_wait)

			wait_for(seconds_wait) { @driver.find_element(criteria.to_sym,field).displayed? }
			@driver.find_element(criteria.to_sym, field).clear
			@driver.find_element(criteria.to_sym, field).send_keys(value)
		end	

		#method to switch to the new window opened
		def switch_to_new_window(window)	
			# Switch to new window
			#new_window = @driver.window_handles.last
			@driver.switch_to.window(window)
		end

		#method to press keyboard 
		def press_key(criteria,element,key)
			puts key
			@driver.find_element(criteria.to_sym, element).send_keys [:control, 'a'], key.to_sym
			sleep 1
			#http://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Keys#KEYS-constant
		end

		#method to click ok in dialog
		def press_confirm_in_alert
			@driver.switch_to.alert.accept
			sleep 20
		end
		
		#method to switch to the specific frame
		def switch_to_frame(criteria,value)
			el = @driver.find_element(criteria.to_sym, value)	
			puts "Iframe: "
			puts el	
			@driver.switch_to.frame(el)
		end
		
		#method to put mouse over element
		def mouse_over(criteria,value,seconds_over)
			
			element = @driver.find_element(criteria.to_sym,value)	
			
			puts element
			
			@driver.action.move_to(element).perform
			sleep seconds_over
		end	
		

	  	#method to wait for the page load - comparing text shown in the page
	  	def wait_page_load(criteria,value,expected_element_text,seconds_wait)
	  		text_on_page = @driver.find_element(criteria.to_sym, value).text
	  		wait_for(seconds_wait) { text_on_page.include?(expected_element_text)}
	  	end

	  #explicit wait 
	  def wait_for(seconds)
	  	Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
	  end

	#method to resize the browser according to the coordinates
	def resize_browser(x,y)
		#resize
		@driver.manage.window.resize_to(x,y)
		sleep 3
	end

	#method to get the webdriver object
	def return_driver
		return @driver
	end

	def wait_element_enabled(criteria,value,seconds_wait)
		wait_for(seconds_wait) { @driver.find_element(criteria.to_sym,value).enabled? }
	end

	def maximize_window
		@driver.manage.window.maximize
		sleep 3
	end

	def refresh_page
		#@driver.refresh
		sleep 5
	end

	
end
