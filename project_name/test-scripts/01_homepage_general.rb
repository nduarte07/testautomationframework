#Smoke Test: Homepage and Footer
require "rspec"
require "rspec/retry"
require "rspec/retry"
require "../../taf_n07/act"
require "../../taf_n07/get"
require "../../taf_n07/env"
require "../po_homepage"

include RSpec::Expectations

describe "Smoke Test: Homepage and Footer" do 

		before(:each) do
			setup()
		end
		
		after(:each) do
			@act.teardown
		end

      context ""
      it "BDD 01 Scenario: VP Hambuger icon on homepage
          ---> Given the user loads 'homepage'
          ---> Then the user should see the 'Hamburger' menu icon o left top", :retry => 2 do 
      
        #test name/ framework instances
        vp_setup("BDD_01")

        #open page
        @po_homepage.go_to_homepage_url(@base_url)

        #validation
        value = @get.is_element_displayed?("class","main-nav__menu-btn",55)
        expect(value).to be true
      end
end

def setup
  
  @po_env = HOMEPAGE_Env.new
  puts "this is Po env #{@po_env}"
 
  #Environment variable
  @browser = ENV['BROWSER']
  puts "Browser: "
  puts @browser

  #to be used to change the url eg. dev-yourproject.com, qa-yourporject.com
  #Should set the env variable in the console as 'dev', 'qa'
  @env = ENV['PROJ_ENV']
  puts "Environment: "
  puts @env
  
  puts " "
  puts "Setup >> executed"
  puts " "

end

def vp_setup(vp_num)
  #test name to be used in browserstack/saucelabs
  ini_name = @po_env.get_ini_test_name
  tname = "#{@env}_#{ini_name}_homepage_footer_general_#{vp_num}"
  puts "Test name is: #{tname}"

  caps = @po_env.get_caps(tname,@env)
  
  @act = Act.new(caps,@browser)
  
  driver = @act.return_driver
        
  @get = Get.new(driver)
  @po_homepage = PO_HOMEPAGE.new(driver)

    #base url based on environment
  @base_url = @po_homepage.get_base_url(@env)
  puts @base_url
end
