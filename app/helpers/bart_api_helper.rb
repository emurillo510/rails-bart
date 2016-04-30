# A module that wraps http://api.bart.gov/  (2016). 
# The api is broken up in various modules such as: Overview, Advisories, Real-Time Estimates, Route Information, and Schedule Information.
module BartApiHelper
  require 'net/http'
  
  module Advisories
  def say_hello
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    #Advisories - Contains commands and calls pertaining to BART service advisories (BSA), elevator outages and train counts.
    def bart_bsa_get_advisories
      puts "bart service announcement"
      
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_train_count
      puts "bart service announcement"
      
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_elevator_status
     puts "bart elevator status"
     
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
  end
  
  module RealTimeInformation
    #Real-Time Estimates - Contains commands and calls pertaining to estimated time of departure (ETD).
    def bart_estimate_departure
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_estimate_departure_filter
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
  end
  
  module RouteInformation
   #Route Information - Contains commands and calls pertaining to BART routes.
    def bart_routes
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200 
    end
    
    def bart_routeinfo
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
  end
    
  module ScheduleInformation
  #Schedule Information - Contains commands and calls pertaining to trip planning, route schedules, station schedules, holiday schedules, and special messages.
    
    def bart_arrive
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_depart
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_fare
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_holiday
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_load
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_route_schedule
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_schedules
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_special
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
   def bart_station_schedule
     puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
   end
  end
  
  module StationInformation
   #Station Information - Contains commands and calls pertaining to BART stations
    def bart_station_info
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_station_access
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    def bart_stations
      puts "Hello there"
      
      bart_key = Rails.application.secrets.bart_api_key
      
      puts "bart key: " + bart_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << bart_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
  end
end
