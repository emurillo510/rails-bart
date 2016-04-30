# A module that wraps http://api.bart.gov/  (2016). 
# The api is broken up in various modules such as: Overview, Advisories, Real-Time Estimates, Route Information, and Schedule Information.
module BartApiHelper
  
  # This module utilizes 'net/http' for faciliating HTTP request to BART's backend.
  require 'net/http'
  
  #  Class Variables
  #  @bart_key = Rails.application.secrets.bart_api_key
  #  @bart_base_url = http://api.bart.gov/api/bsa.aspx?
  
  #  Advisory Information API
  #
  #  The Advisory Information API contains command for requesting information about BART Service Advisories (BSA), 
  #  elevator messages, and current system train count. 
  #  This information is pulled from the real-time information system that is used for the BART website as well as the station information signs. 
  #   It is updated every minute.
  
  module Advisories
  
    # bsa - Requests current advisory information.
    #
    #  *Arguments*
    #  - +cmd+ => Requests current advisory information (Required)
    #  - +orig+ => Only get messages for specified station. Defaults to "all". (Optional) 
    #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
    #                      the BART system does not currently provide station specific BSA messages.]
    #  - +key+ =>  API registration key (Required)
    # 
    #  *Returns*
    #  - <root>
    #       <uri>
    #       <![CDATA[
    #       http://api.bart.gov/api/bsa.aspx?cmd=bsa&date=today
    #       ]]>
    #       </uri>
    #       <date>04/30/2016</date>
    #       <time>13:33:00 PM PDT</time>
    #       <bsa>
    #       <station/>
    #       <description>
    #       <![CDATA[ No delays reported. ]]>
    #       </description>
    #       <sms_text>
    #       <![CDATA[ No delays reported. ]]>
    #       </sms_text>
    #       </bsa>
    #       <message/>
    #       </root>
    # ==== Examples
    #
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
    
    # count - Request the number of trains currently active in the system.
    #
    #  *Arguments*
    #  - +cmd+ => Requests current advisory information (Required)
    #  - +key+ =>  API registration key (Required)
    #
    #  *Returns*
    #  - <?xml version="1.0" encoding="utf-8" ?> 
    #  -  <root>
    #       <uri><![CDATA[ http://api.bart.gov/api/bsa.aspx?cmd=count ]]></uri> 
    #       <date>10/14/2009</date> 
    #       <time>15:52:00 PM PDT</time> 
    #       <traincount>51</traincount> 
    #       <message /> 
    #     </root>
    # ==== Examples
    #
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
    
    # elev - Requests current elevator status information.
    #
    #  *Arguments*
    #  - +cmd+ => Requests current advisory information (Required)
    #  - +key+ =>  API registration key (Required)
    #
    #  *Returns*
    #  - <?xml version="1.0" encoding="iso-8859-1" ?> 
    #  <root>
    #    <uri><![CDATA[ http://api.bart.gov/api/bsa.aspx?cmd=elev ]]></uri> 
    #    <date>10/14/2009</date> 
    #    <time>15:57:00 PM PDT</time> 
    #    <bsa>
    #    <description><![CDATA[ Attention passengers: All elevators are in service. Thank You. ]]></description>
    #    <sms_text><![CDATA[ ALL ELEVS ARE IN SVC. ]]></sms_text>
    #    </bsa>
    #    <message /> 
    #  </root>
    # ==== Examples
    #
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
  
  #  Real-Time Information API
  #  The BART real-time information feed contains commands for requesting information about real-time estimated depatures for specific stations.
  module RealTimeInformation
  
    # etd - Requests estimated departure time for specified station.
    #
    #  *Arguments*
    #  - +cmd+ => Requests current departure information. (Required)
    #  - +orig+ =>  Specifies the station. Stations are referenced by their abbreviations. You can also use 'ALL' to get all of the current ETD's. (Required)
    #  - +key+ =>  API registration key. (Required)
    #  - +plat+ =>  This will limit results to a specific platform. Valid platforms depend on the station, but can range from 1-4. (Optional)
    #  - +dir+ =>  This will limit results to a specific direction. Valid directions are 'n' for Northbound and 's' for Southbound. (Optional)
    #
    #  *Returns*
    #  -  <?xml version="1.0" encoding="utf-8"?>
    #  <root>
    #    <uri>
    #    <![CDATA[http://ws.sfbart.org/api/etd.aspx?cmd=etd&orig=RICH]]>
    #    </uri>
    #    <date>09/23/2015</date>
    #    <time>03:03:04 PM PDT</time>
    #    <station>
    #    <name>Richmond</name>
    #    <abbr>RICH</abbr>
    #    <etd>
    #    <destination>Fremont</destination>
    #    <abbreviation>FRMT</abbreviation>
    #    <limited>0</limited>
    #    <estimate>
    #    <minutes>3</minutes>
    #    <platform>2</platform>
    #    <direction>South</direction>
    #    <length>6</length>
    #    <color>ORANGE</color>
    #    <hexcolor>#ff9933</hexcolor>
    #    <bikeflag>1</bikeflag>
    #    </estimate>
    #    <estimate>
    #    <minutes>16</minutes>
    #    <platform>2</platform>
    #     <direction>South</direction>
    #    <length>6</length>
    #    <color>ORANGE</color>
    #    <hexcolor>#ff9933</hexcolor>
    #    <bikeflag>1</bikeflag>
    #    </estimate>
    #    <estimate>
    #    <minutes>31</minutes>
    #    <platform>2</platform>
    #    <direction>South</direction>
    #    <length>6</length>
    #    <color>ORANGE</color>
    #    <hexcolor>#ff9933</hexcolor>
    #    <bikeflag>1</bikeflag>
    #    </estimate>
    #    </etd>
    #    <etd>
    #    <destination>Millbrae</destination>
    #    <abbreviation>MLBR</abbreviation>
    #    <limited>0</limited>
    #    <estimate>
    #    <minutes>9</minutes>
    #    <platform>2</platform>
    #    <direction>South</direction>
    #    <length>9</length>
    #    <color>RED</color>
    #    <hexcolor>#ff0000</hexcolor>
    #    <bikeflag>1</bikeflag>
    #    </estimate>
    #    <estimate>
    #    <minutes>24</minutes>
    #    <platform>2</platform>
    #    <direction>South</direction>
    #   <length>9</length>
    #   <color>RED</color>
    #    <hexcolor>#ff0000</hexcolor>
    #    <bikeflag>1</bikeflag>
    #    </estimate>
    #    <estimate>
    #    <minutes>39</minutes>
    #    <platform>2</platform>
    #    <direction>South</direction>
    #    <length>8</length>
    #    <color>RED</color>
    #    <hexcolor>#ff0000</hexcolor>
    #    <bikeflag>1</bikeflag>
    #    </estimate>
    #    </etd>
    #    </station>
    #    <message></message>
    #  </root>
    # ==== Examples
    #
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
  
  #  Route Information API
  #  The BART Route Information feed contains commands for requesting information about the BART lines. 
  #  Each line contains two routes (northbound and southbound).
  module RouteInformation
  
    #  routeinfo - Requests detailed information regarding a specific route.
    #
    #  *Arguments*
    #  - +cmd+ => Requests current advisory information (Required)
    #  - +key+ =>  API registration key (Required)
    #  - +route+ =>  Specifies the specific route information to return. In addition to route number (i.e. 1, 2, ... 12) 'all' can be specified to get the configuration information for all routes. (Required)
    #  - +sched+ =>  Specifies a specific schedule to use. Defaults to current schedule. (Optional)
    #  - +date+ =>  Specifies a specific date to use. This will determine the appropriate schedule for that date, and give back information about the routes for that schedule. Date can also be specified as "today" or "now". (Optional)
    #
    #  *Returns*
    #  - <?xml version="1.0" encoding="utf-8" ?>
    #    <root>
    #      <uri> http://api.bart.gov/api/route.aspx?cmd=routeinfo&route=6 </uri>
    #      <sched_num>26</sched_num>
    #      <routes>
    #        <route>
    #          <name>Daly City - Fremont</name>
    #          <abbr>DALY-FRMT</abbr>
    #          <routeID>ROUTE 6</routeID>
    #          <number>6</number>
    #          <origin>DALY</origin>
    #          <destination>FRMT</destination>
    #          <direction>south</direction>
    #          <color>#339933</color>
    #          <holidays>0</holidays>
    #          <num_stns>19</num_stns>
    #          <config>
    #            <station>DALY</station>
    #            <station>BALB</station>
    #            <station>GLEN</station>
    #            <station>24TH</station>
    #            <station>16TH</station>
    #            <station>CIVC</station>
    #            <station>POWL</station>
    #            <station>MONT</station>
    #            <station>EMBR</station>
    #            <station>WOAK</station>
    #            <station>LAKE</station>
    #            <station>FTVL</station>
    #            <station>COLS</station>
    #            <station>SANL</station>
    #            <station>BAYF</station>
    #            <station>HAYW</station>
    #            <station>SHAY</station>
    #            <station>UCTY</station>
    #            <station>FRMT</station>
    #          </config>
    #        </route>
    #      </routes>
    #      <message />
    #    </root>
    # ==== Examples
    #
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
    
    #  routes - Requests detailed information current routes.
    #
    #  *Arguments*
    #  - +cmd+ => Requests current advisory information (Required)
    #  - +key+ =>  API registration key (Required)
    #  - +sched+ =>  Specifies a specific schedule to use. Defaults to current schedule. (Optional)
    #  - +date+ =>  Specifies a specific date to use. This will determine the appropriate schedule for that date, and give back information about the lines for that schedule. Date can also be specified as "today" or "now". (Optional)
    #
    #  *Returns*
    #  <?xml version="1.0" encoding="utf-8" ?> 
    #  <root>
    #    <uri><![CDATA[ http://api.bart.gov/api/route.aspx?cmd=routes ]]></uri>
    #    <sched_num>26</sched_num> 
    #    <routes>
    #      <route>
    #        <name>Pittsburg/Bay Point - SFIA/Millbrae</name> 
    #        <abbr>PITT-SFIA</abbr> 
    #        <routeID>ROUTE 1</routeID> 
    #        <number>1</number> 
    #        <color>#ffff33</color> 
    #      </route>
    #       ...
    #      </routes>
    #       <message /> 
    #  </root>
    # ==== Examples
    #
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
  
  #  Schedule Information API
  #  The BART Schedule Information feed contains commands for requesting information about the BART schedules and trip planning. 
  #  Each line contains two routes (northbound and southbound).
  module ScheduleInformation
  
    #  arrive - Requests a trip plan based on arriving by the specified time.
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
    
    #  depart - Requests a trip plan based on departing by the specified time.
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
    
    #  fare - Requests fare information for a trip between two stations.
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
    
    #  holiday - Requests information on the upcoming BART holidays, and what type of schedule will be run on those days.
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
    
    #  load - Requests estimated load factor for specified train(s).
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
    
    #  routesched - Requests a full schedule for the specified route.
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
    
    #  scheds - Requests information about the currently available schedules.
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
    
    #  special - Requests information about all special schedule notices in effect.
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
    
    # stnsched - Requests an entire daily schedule for the particular station specified.
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
  
  #  Station Information API - The BART Station Information feed contains commands for requesting information about the BART stations.
  module StationInformation
  
    #  stninfo - Provides a detailed information about the specified station.
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
    
    #  stnaccess - Requests detailed information how to access the specified station as well as information about the neighborhood around the station.
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
    
    #  stns - Provides a list of all available stations.
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
