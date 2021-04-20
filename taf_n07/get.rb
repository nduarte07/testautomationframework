	#Action class of crf-taf - to be used in all automation project
	require "selenium-webdriver"
	
class Get

	def initialize(driver)
		@driver = driver
	end
	 #method to get the element status displayed?
	 def is_element_displayed?(criteria, value, seconds_wait)
	    
	   	wait_for(seconds_wait) { @driver.find_element(criteria.to_sym,value).displayed? }
	   	found = @driver.find_element(criteria.to_sym,value).displayed?
	    
	    return found
	 	
	 	rescue Selenium::WebDriver::Error::NoSuchElementError
	    	puts "-- Element not found --"
	        return false   
	  end 
	  
	  #get element get the element status enabled? -- explicit wait
	  def is_element_enabled?(criteria, value, seconds_wait)
	    
	   	wait_for(seconds_wait) { @driver.find_element(criteria.to_sym,value).enabled? }
	   	found = @driver.find_element(criteria.to_sym,value).enabled?
	    
	 	return found
	 	
	 	rescue Selenium::WebDriver::Error::NoSuchElementError
	    	puts "-- Element not found --"
	        return false   
	  end 

	  #method to get element's value -- explicit wait
		def return_element_text(criteria, value, seconds_wait)
		 
		    wait_for(seconds_wait) { @driver.find_element(criteria.to_sym,value).displayed? }
		    text = @driver.find_element(criteria.to_sym, value).text 
		
			puts text   
	    	return text
	  	end 
		
		#method to get the current URL
		def return_current_url()
			return @driver.current_url	
		end
		
		#method to get the parent window - in case of more than one window opened
		def return_first_window_handle
			return @driver.window_handles.first
		end

		def return_last_window_handle
			return @driver.window_handles.last
		end
		
		#method to get the page title
		def return_page_title
			puts @driver.title
			return @driver.title		
		end
		
		#method to get the element's attribute
		def return_element_attribute(criteria, value, attribute, seconds_wait)
	    
	    	wait_for(seconds_wait) { @driver.find_element(criteria.to_sym,value).displayed? }
	        att = @driver.find_element(criteria.to_sym, value).attribute(attribute)
	    	puts att
	    	return att
	  	end
		
		#method to get the background color
		def return_background_color_on_mouse_over(css_value, seconds_wait)
			  
			wait_for(seconds_wait) { @driver.find_element(:css,css_value).displayed? }
				
			element = @driver.find_element(:css,css_value)		
			value = element.css_value('background-color')
			puts value
				
			@driver.action.move_to(element).perform
			sleep 3
				
			value = element.css_value('background-color')
			puts value	
				
			return value
		end

		
		#method to get the HTTP header information
		def return_HTTP_header(url)
			puts "inside getHeader"
			response = Net::HTTP.get_response(URI.parse(url))
			puts "this is reponse: "
			puts response
			#response.header
			response.header.each_header {|key,value| puts "#key = #{value}" }
			
			return response.header.each_header{|key,value|}
		end


		def wait_for(seconds)
	  		Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }

	  		rescue Selenium::WebDriver::Error::TimeOutError
	    		puts "-- TimeOut Error"
	        	return false   
	  	end

	  	def return_current_year
	  		time = Time.new
			return Time.now.strftime("%Y")
	  	end

	  	#def return_session_id
	  	#	return @driver.session_id
	  	#end
end
			
