# TODO:
# Add example link for each endpoint
# Add correct parameters for every endpoint

# A module that wraps http://api.bart.gov/  (2016). 
# The api is broken up in various modules such as: Overview, Advisories, Real-Time Estimates, Route Information, and Schedule Information.
module BartApiHelper
  
  # This module utilizes 'net/http' for faciliating HTTP request to BART's backend.
  require 'net/http'
  
  #  Class Variables
  @@bart_key = Rails.application.secrets.bart_api_key
  @@bart_base_url = "http://api.bart.gov/api/bsa.aspx?"
  
  def self.bart_api_key 
    @@bart_key = Rails.application.secrets.bart_api_key
  end
  
  def self.bart_base_url
    @@bart_base_url = "http://api.bart.gov/api/bsa.aspx?"
  end
   
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
    #  - +cmd=bsa+ => Requests current advisory information (Required)
    #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
    #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
    #                      the BART system does not currently provide station specific BSA messages.]
    #  - +key=<key>+ =>  API registration key (Required)
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
    #  http://api.bart.gov/api/bsa.aspx?cmd=bsa&date=today&key=[Rails.application.secrets.bart_api_key]
    def bart_bsa_get_advisories
      puts "bart base url: " << BartApiHelper.bart_base_url
      puts "bart client command: " << "input from client"
      puts "bart api key: " << BartApiHelper.bart_api_key
      site_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&key=" << BartApiHelper.bart_api_key
       
      uri = URI(site_url)
      output = Hash.from_xml(Net::HTTP.get(uri).strip).to_json
      
      puts "output: " + output 
      
      render  json: output, status: 200
    end
    
    # count - Request the number of trains currently active in the system.
    #
    #  *Arguments*
    #  - +cmd=count+ => Requests current advisory information (Required)
    #  - +key=<key>+ =>  API registration key (Required)
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
    #  http://api.bart.gov/api/bsa.aspx?cmd=count&key=[Rails.application.secrets.bart_api_key]
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
    #  - +cmd=elev+ => Requests current advisory information (Required)
    #  - +key=<key>+ =>  API registration key (Required)
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
    #  http://api.bart.gov/api/bsa.aspx?cmd=elev&key=[Rails.application.secrets.bart_api_key]
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
    #  - +cmd=etd+ => Requests current departure information. (Required)
    #  - +orig=<station>+ =>  Specifies the station. Stations are referenced by their abbreviations. You can also use 'ALL' to get all of the current ETD's. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +plat=<platform>+ =>  This will limit results to a specific platform. Valid platforms depend on the station, but can range from 1-4. (Optional)
    #  - +dir=<dir>+ =>  This will limit results to a specific direction. Valid directions are 'n' for Northbound and 's' for Southbound. (Optional)
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
    #  http://api.bart.gov/api/etd.aspx?cmd=etd&orig=RICH&key=[Rails.application.secrets.bart_api_key]
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
    
    # where is this endpoint?
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
    #  - +cmd=routeinfo+ => Requests current advisory information (Required)
    #  - +key=<key>+ =>  API registration key (Required)
    #  - +route=<route_num>+ =>  Specifies the specific route information to return. In addition to route number (i.e. 1, 2, ... 12) 'all' can be specified to get the configuration information for all routes. (Required)
    #  - +sched=<sched_num>+ =>  Specifies a specific schedule to use. Defaults to current schedule. (Optional)
    #  - +date=<mm/dd/yyyy>+ =>  Specifies a specific date to use. This will determine the appropriate schedule for that date, and give back information about the routes for that schedule. Date can also be specified as "today" or "now". (Optional)
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
    #  http://api.bart.gov/api/route.aspx?cmd=routeinfo&route=6&key=[Rails.application.secrets.bart_api_key]
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
    #  - +cmd=routes+ => Requests current advisory information (Required)
    #  - +key=<key>+ =>  API registration key (Required)
    #  - +sched=<sched_num>+ =>  Specifies a specific schedule to use. Defaults to current schedule. (Optional)
    #  - +date=<mm/dd/yyyy>+ =>  Specifies a specific date to use. This will determine the appropriate schedule for that date, and give back information about the lines for that schedule. Date can also be specified as "today" or "now". (Optional)
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
    #  http://api.bart.gov/api/route.aspx?cmd=routes&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=arrive+ => Requests a trip based on arriving at the time specified. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +orig=<station>+ =>  Specifies the origination station. Stations should be specified using the four character abbreviations. (Required)
    #  - +dest=<station>+ =>  Specifies the destination station. Stations should be specified using the four character abbreviations. (Required)
    #  - +time=h:mm+am/pm+ => Specifies the arrival time for the trip. Using "time=now" is also valid and will return the specified trips based on the current time. If not specified, defaults to the current time. (Optional)
    #  - +date=<mm/dd/yyyy>+ => Specifies a specific date to use for calculating the trip. This will determine the appropriate schedule for that date, and give back information about the lines for that schedule. Date can also be specified as "today" or "now". The default is the current date. (Optional)
    #  - +b=<number>+ => This allows specifying how many trips before the specified time should be returned. This paramter defaults to 2, and can be set between 0 and 4. (Optional)
    #  - +a=<number>+ => RThis allows specifying how many trips after the specified time should be returned. This paramter defaults to 2, and can be set between 0 and 4. (Optional)
    #  - +l=<number>+ => Specifies whether the legend information should be included. By default it is 0 (not shown), but can be turned on by setting it to 1. (Optional)
    #
    #  *Returns*
    #  <?xml version="1.0" encoding="utf-8"?>
    #  -  <root>
    #       <uri><![CDATA[http://ad.sfbart.org/api/sched.aspx?cmd=arrive&orig=ASHB&dest=CIVC&date=now&b=2&a=2&l=1]]></uri>
    #       <origin>ASHB</origin>
    #       <destination>CIVC</destination>
    #       <sched_num>31</sched_num>
    #       <schedule>
    #         <date>Jun 20, 2013</date>
    #         <time>11:21 AM</time>
    #         <before>2</before>
    #         <after>2</after>
    #         <request>
    #           <trip origin="ASHB" destination="CIVC" fare="3.55" origTimeMin="10:42 AM" origTimeDate="06/20/2013 " destTimeMin="11:07 AM" destTimeDate="06/20/2013" clipper="1.30">
    #             <leg order="1" transfercode="" origin="ASHB" destination="CIVC" origTimeMin="10:42 AM" origTimeDate="06/20/2013" destTimeMin="11:07 AM" destTimeDate="06/20/2013" line="ROUTE 7" bikeflag="1" trainHeadStation="MLBR" trainIdx="26"/>
    #           </trip>
    #           <trip origin="ASHB" destination="CIVC" fare="3.55" origTimeMin="10:50 AM" origTimeDate="06/20/2013 " destTimeMin="11:14 AM" destTimeDate="06/20/2013" clipper="1.30">
    #             <leg order="1" transfercode="S" origin="ASHB" destination="MCAR" origTimeMin="10:50 AM" origTimeDate="06/20/2013" destTimeMin="10:53 AM" destTimeDate="06/20/2013" line="ROUTE 4" bikeflag="1" trainHeadStation="FRMT" trainIdx="26"/>
    #             <leg order="2" transfercode="" origin="MCAR" destination="CIVC" origTimeMin="10:53 AM" origTimeDate="06/20/2013" destTimeMin="11:14 AM" destTimeDate="06/20/2013" line="ROUTE 1" bikeflag="1" trainHeadStation="SFIA" trainIdx="39"/>
    #           </trip>
    #           <trip origin="ASHB" destination="CIVC" fare="3.55" origTimeMin="10:57 AM" origTimeDate="06/20/2013 " destTimeMin="11:22 AM" destTimeDate="06/20/2013" clipper="1.30">
    #             <leg order="1" transfercode="" origin="ASHB" destination="CIVC" origTimeMin="10:57 AM" origTimeDate="06/20/2013" destTimeMin="11:22 AM" destTimeDate="06/20/2013" line="ROUTE 7" bikeflag="1" trainHeadStation="MLBR" trainIdx="27"/>
    #           </trip>
    #           <trip origin="ASHB" destination="CIVC" fare="3.55" origTimeMin="11:05 AM" origTimeDate="06/20/2013 " destTimeMin="11:29 AM" destTimeDate="06/20/2013" clipper="1.30">
    #             <leg order="1" transfercode="S" origin="ASHB" destination="MCAR" origTimeMin="11:05 AM" origTimeDate="06/20/2013" destTimeMin="11:08 AM" destTimeDate="06/20/2013" line="ROUTE 4" bikeflag="1" trainHeadStation="FRMT" trainIdx="27"/>
    #             <leg order="2" transfercode="" origin="MCAR" destination="CIVC" origTimeMin="11:08 AM" origTimeDate="06/20/2013" destTimeMin="11:29 AM" destTimeDate="06/20/2013" line="ROUTE 1" bikeflag="1" trainHeadStation="SFIA" trainIdx="40"/>
    #           </trip>
    #         </request>
    #       </schedule>
    #       <message>
    #         <co2_emissions><![CDATA[<p>CO<sub>2</sub> emissions saved by this BART trip: <strong>9.8 pounds.</strong> <a href="http://www.bart.gov/guide/carbon.aspx">Read more</a></p>]]></co2_emissions>
    #         <legend>bikeflag: 1 = bikes allowed. 0 = no bikes allowed. transfercode: blank = no transfer, N = normal transfer, T = timed transfer, connecting trains will wait up to five minutes for transferring passengers. S = scheduled transfer, connecting trains will not wait for transferring #               passengers if there is a delay.
    #         </legend>
    #       </message>
    #     </root>
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=arrive&orig=ASHB&dest=CIVC&date=now&b=2&a=2&l=1&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=depart+ => Requests a trip based on arriving at the time specified. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +orig=<station>+ =>  Specifies the origination station. Stations should be specified using the four character abbreviations. (Required)
    #  - +dest=<station>+ =>  Specifies the destination station. Stations should be specified using the four character abbreviations. (Required)
    #  - +time=h:mm+am/pm+ => Specifies the arrival time for the trip. Using "time=now" is also valid and will return the specified trips based on the current time. If not specified, defaults to the current time. (Optional)
    #  - +date=<mm/dd/yyyy>+ => Specifies a specific date to use for calculating the trip. This will determine the appropriate schedule for that date, and give back information about the lines for that schedule. Date can also be specified as "today" or "now". The default is the current date. (Optional)
    #  - +b=<number>+ => This allows specifying how many trips before the specified time should be returned. This paramter defaults to 2, and can be set between 0 and 4. (Optional)
    #  - +a=<number>+ => RThis allows specifying how many trips after the specified time should be returned. This paramter defaults to 2, and can be set between 0 and 4. (Optional)
    #  - +l=<number>+ => Specifies whether the legend information should be included. By default it is 0 (not shown), but can be turned on by setting it to 1. (Optional)
    #
    #  *Returns*
    #  <?xml version="1.0" encoding="utf-8"?>
    #  -  <root>
    #       <uri><![CDATA[http://ad.sfbart.org/api/sched.aspx?cmd=arrive&orig=ASHB&dest=CIVC&date=now&b=2&a=2&l=1]]></uri>
    #       <origin>ROCK</origin>
    #       <destination>WDUB</destination>
    #       <sched_num>31</sched_num>
    #       <schedule>
    #         <date>Jun 20, 2013</date>
    #         <time>11:21 AM</time>
    #         <before>2</before>
    #         <after>2</after>
    #         <request>
    #           <trip origin="ROCK" destination="WDUB" fare="3.55" origTimeMin="10:42 AM" origTimeDate="06/20/2013 " destTimeMin="11:07 AM" destTimeDate="06/20/2013" clipper="1.30">
    #             <leg order="1" transfercode="" origin="ROCK" destination="WDUB" origTimeMin="10:42 AM" origTimeDate="06/20/2013" destTimeMin="11:07 AM" destTimeDate="06/20/2013" line="ROUTE 7" bikeflag="1" trainHeadStation="MLBR" trainIdx="26"/>
    #           </trip>
    #           <trip origin="ROCK" destination="WDUB" fare="3.55" origTimeMin="10:50 AM" origTimeDate="06/20/2013 " destTimeMin="11:14 AM" destTimeDate="06/20/2013" clipper="1.30">
    #             <leg order="1" transfercode="S" origin="ROCK" destination="MCAR" origTimeMin="10:50 AM" origTimeDate="06/20/2013" destTimeMin="10:53 AM" destTimeDate="06/20/2013" line="ROUTE 4" bikeflag="1" trainHeadStation="FRMT" trainIdx="26"/>
    #             <leg order="2" transfercode="" origin="MCAR" destination="WDUB" origTimeMin="10:53 AM" origTimeDate="06/20/2013" destTimeMin="11:14 AM" destTimeDate="06/20/2013" line="ROUTE 1" bikeflag="1" trainHeadStation="SFIA" trainIdx="39"/>
    #           </trip>
    #           <trip origin="ROCK" destination="WDUB" fare="3.55" origTimeMin="10:57 AM" origTimeDate="06/20/2013 " destTimeMin="11:22 AM" destTimeDate="06/20/2013" clipper="1.30">
    #             <leg order="1" transfercode="" origin="ROCK" destination="WDUB" origTimeMin="10:57 AM" origTimeDate="06/20/2013" destTimeMin="11:22 AM" destTimeDate="06/20/2013" line="ROUTE 7" bikeflag="1" trainHeadStation="MLBR" trainIdx="27"/>
    #           </trip>
    #           <trip origin="ROCK" destination="WDUB" fare="3.55" origTimeMin="11:05 AM" origTimeDate="06/20/2013 " destTimeMin="11:29 AM" destTimeDate="06/20/2013" clipper="1.30">
    #             <leg order="1" transfercode="S" origin="ROCK" destination="WDUB" origTimeMin="11:05 AM" origTimeDate="06/20/2013" destTimeMin="11:08 AM" destTimeDate="06/20/2013" line="ROUTE 4" bikeflag="1" trainHeadStation="FRMT" trainIdx="27"/>
    #             <leg order="2" transfercode="" origin="ROCK" destination="WDUB" origTimeMin="11:08 AM" origTimeDate="06/20/2013" destTimeMin="11:29 AM" destTimeDate="06/20/2013" line="ROUTE 1" bikeflag="1" trainHeadStation="SFIA" trainIdx="40"/>
    #           </trip>
    #         </request>
    #       </schedule>
    #       <message>
    #         <co2_emissions><![CDATA[<p>CO<sub>2</sub> emissions saved by this BART trip: <strong>9.8 pounds.</strong> <a href="http://www.bart.gov/guide/carbon.aspx">Read more</a></p>]]></co2_emissions>
    #         <legend>bikeflag: 1 = bikes allowed. 0 = no bikes allowed. transfercode: blank = no transfer, N = normal transfer, T = timed transfer, connecting trains will wait up to five minutes for transferring passengers. S = scheduled transfer, connecting trains will not wait for transferring #               passengers if there is a delay.
    #         </legend>
    #       </message>
    #     </root>
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=depart&orig=ASHB&dest=CIVC&date=now&b=2&a=2&l=1&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=fare+ => Requests a trip based on arriving at the time specified. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +orig=<station>+ =>  Specifies the origination station. Stations should be specified using the four character abbreviations. (Required)
    #  - +dest=<station>+ =>  Specifies the destination station. Stations should be specified using the four character abbreviations. (Required)
    #  - +date=<mm/dd/yyyy>+ => Specifies a specific date to use for calculating the trip. This will determine the appropriate schedule for that date, and give back information about the lines for that schedule. Date can also be specified as "today" or "now". The default is the current date. (Optional)
    #  - +sched=<number>+ => Specifies a specific schedule to use. (Optional)
    #
    #  *Returns*
    #  - <?xml version="1.0" encoding="utf-8" ?> 
    #      <root>
    #        <uri><![CDATA[ http://api.bart.gov/api/sched.aspx?cmd=fare&orig=12th&dest=embr ]]></uri>
    #        <origin>12TH</origin> 
    #        <destination>EMBR</destination> 
    #        <sched_num>31</sched_num> 
    #        <trip>
    #          <fare>3.15</fare>
    #          <discount>
    #            <clipper>1.15</clipper>
    #          </discount>
    #        </trip>
    #        <message>
    #          <co2_emissions><![CDATA[ <p>CO2 emissions saved by this BART trip: <strong>8.5 pounds.</strong> <a href="http://www.bart.gov/guide/carbon.aspx">Read more</a></p> ]]></co2_emissions>
    #        </message>
    #      </root>
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=fare&orig=12th&dest=embr&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=fare+ => Requests a trip based on arriving at the time specified. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #
    #  *Returns*
    #  -  <?xml version="1.0" encoding="utf-8" ?> 
    #     <root>
    #       <uri><![CDATA[ http://api.bart.gov/api/sched.aspx?cmd=special ]]></uri>
    #       <holidays>
    #         <holiday>
    #           <name>New Year's Day (2009)</name> 
    #           <date>01/01/2009</date> 
    #           <schedule_type>Sunday</schedule_type> 
    #         </holiday>
    #         <holiday>
    #           <name>Presidents' Day</name> 
    #           <date>02/16/2009</date> 
    #           <schedule_type>Saturday</schedule_type> 
    #         </holiday>
    #         <holiday>
    #           <name>Memorial Day</name> 
    #           <date>05/25/2009</date> 
    #           <schedule_type>Sunday</schedule_type> 
    #         </holiday>
    #         <holiday>
    #           <name>Labor Day</name> 
    #           <date>09/07/2009</date> 
    #           <schedule_type>Saturday</schedule_type> 
    #         </holiday>
    #         <holiday>
    #           <name>Thanksgiving Day</name> 
    #           <date>11/26/2009</date> 
    #           <schedule_type>Sunday</schedule_type> 
    #         </holiday>
    #         <holiday>
    #           <name>Christmas Day</name> 
    #           <date>12/25/2009</date> 
    #           <schedule_type>Sunday</schedule_type> 
    #         </holiday>
    #         <holiday>
    #           <name>New Year's Day (2010)</name> 
    #           <date>01/01/2010</date> 
    #           <schedule_type>Sunday</schedule_type> 
    #         </holiday>
    #       </holidays>
    #       <message /> 
    #     </root>
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=special&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=load+ => Requests a trip based on arriving at the time specified. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +ld1=<ssssrrtt>+ =>  First train to get the estimated load factor for. The format for this parameter is a four letter station code, a two digit route (left padded with 0 if needed) and a two digit train id. The train id (trainIdx) information is included in the <leg> element of the results of a arrive/depart request. (Required)
    #  - +ld2=<ssssrrtt>+ =>  Second train to get the estimated load factor for. The format for this parameter is a four letter station code, a two digit route (left padded with 0 if needed) and a two digit train id. The train id (trainIdx) information is included in the <leg> element of the results of a arrive/depart request. (Optional)
    #  - +ld3=<ssssrrtt>+ =>  Third train to get the estimated load factor for. The format for this parameter is a four letter station code, a two digit route (left padded with 0 if needed) and a two digit train id. The train id (trainIdx) information is included in the <leg> element of the results of a arrive/depart request. (Optional)
    #  - +st=<W|S|H>+ =>  Schedule type for this request. Schedule type is a single character representing Weekday (W), Saturday (S) or Sunday/Holiday (H). (Required)
    #
    #  *Returns*
    #  - <?xml version="1.0" encoding="utf-8"?>
    #    <root>
    #      <uri>
    #        <![CDATA[http://ad.sfbart.org/api/sched.aspx?cmd=load&ld1=WDUB1130&ld2=BAYF0331&ld3=19TH0217&st=w]]>
    #      </uri>
    #      <load>
    #        <request schedueType="W" scheduleID="31">
    #          <leg id="0" station="WDUB" route="11" trainId="30" load="1"></leg>
    #          <leg id="1" station="BAYF" route="3" trainId="31" load="1"></leg>
    #          <leg id="2" station="19TH" route="2" trainId="17" load="1"></leg>
    #        </request>
    #      </load>
    #    </root> 
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=load&ld1=WDUB1130&ld2=BAYF0331&ld3=19TH0217&st=w&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=routesched+ => Requests a trip based on arriving at the time specified. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +sched=<sched_num>+ =>  Specifies a specific schedule to use. Defaults to current schedule. (Optional)
    #  - +date=<mm/dd/yyyy>or <wd|sa|su>+ =>  Specifies a specific date to use. This will determine the appropriate schedule for that date, and give back information about the lines for that schedule. Date can also be specified as "today" or "now". New options for generic schedules have been added: "wd", "sa", and "su" for weekday, Saturday and Sunday. (Optional)
    #  - +l=<number>+ =>  Specifies whether the legend information should be included. By default it is 0 (not shown), but can be turned on by setting it to 1. (Optional)
    #
    #  *Returns*
    #  - <?xml version="1.0" encoding="utf-8" ?> 
    #    <root>
    #      <uri><![CDATA[ http://api.bart.gov/api/sched.aspx?cmd=routesched&route=6 ]]></uri>
    #      <date>10/26/2009</date> 
    #      <sched_num>26</sched_num> 
    #      <route>
    #        <train index="1">
    #          <stop station="DALY" origTime="6:13 AM" bikeflag="1" /> 
    #          <stop station="BALB" origTime="6:17 AM" bikeflag="1" /> 
    #          <stop station="GLEN" origTime="6:19 AM" bikeflag="1" /> 
    #          <stop station="24TH" origTime="6:22 AM" bikeflag="1" /> 
    #          <stop station="16TH" origTime="6:24 AM" bikeflag="1" /> 
    #          <stop station="CIVC" origTime="6:27 AM" bikeflag="1" /> 
    #          <stop station="POWL" origTime="6:28 AM" bikeflag="1" /> 
    #          <stop station="MONT" origTime="6:30 AM" bikeflag="1" /> 
    #          <stop station="EMBR" origTime="6:32 AM" bikeflag="1" /> 
    #          <stop station="WOAK" origTime="6:39 AM" bikeflag="1" /> 
    #          <stop station="LAKE" origTime="6:43 AM" bikeflag="1" /> 
    #          <stop station="FTVL" origTime="6:47 AM" bikeflag="1" /> 
    #          <stop station="COLS" origTime="6:50 AM" bikeflag="1" /> 
    #          <stop station="SANL" origTime="6:54 AM" bikeflag="1" /> 
    #          <stop station="BAYF" origTime="6:58 AM" bikeflag="1" /> 
    #          <stop station="HAYW" origTime="7:02 AM" bikeflag="1" /> 
    #          <stop station="SHAY" origTime="7:06 AM" bikeflag="1" /> 
    #          <stop station="UCTY" origTime="7:11 AM" bikeflag="1" /> 
    #          <stop station="FRMT" origTime="7:16 AM" bikeflag="1" /> 
    #        </train>
    #        <train index="2">
    #          <stop station="DALY" origTime="6:28 AM" bikeflag="1" /> 
    #          <stop station="BALB" origTime="6:32 AM" bikeflag="1" /> 
    #          <stop station="GLEN" origTime="6:34 AM" bikeflag="1" /> 
    #          <stop station="24TH" origTime="6:37 AM" bikeflag="1" /> 
    #          <stop station="16TH" origTime="6:39 AM" bikeflag="1" /> 
    #          <stop station="CIVC" origTime="6:42 AM" bikeflag="1" /> 
    #          <stop station="POWL" origTime="6:43 AM" bikeflag="1" /> 
    #          <stop station="MONT" origTime="6:45 AM" bikeflag="1" /> 
    #          <stop station="EMBR" origTime="6:47 AM" bikeflag="1" /> 
    #          <stop station="WOAK" origTime="6:54 AM" bikeflag="1" /> 
    #          <stop station="LAKE" origTime="6:58 AM" bikeflag="1" /> 
    #          <stop station="FTVL" origTime="7:02 AM" bikeflag="1" /> 
    #          <stop station="COLS" origTime="7:05 AM" bikeflag="1" /> 
    #          <stop station="SANL" origTime="7:09 AM" bikeflag="1" /> 
    #          <stop station="BAYF" origTime="7:13 AM" bikeflag="1" /> 
    #          <stop station="HAYW" origTime="7:17 AM" bikeflag="1" /> 
    #          <stop station="SHAY" origTime="7:21 AM" bikeflag="1" /> 
    #          <stop station="UCTY" origTime="7:26 AM" bikeflag="1" /> 
    #          <stop station="FRMT" origTime="7:31 AM" bikeflag="1" /> 
    #        </train>
    #            ...
    #        <train index="52">
    #          <stop station="DALY" origTime="6:58 PM" bikeflag="1" /> 
    #          <stop station="BALB" origTime="7:02 PM" bikeflag="1" /> 
    #          <stop station="GLEN" origTime="7:04 PM" bikeflag="1" /> 
    #          <stop station="24TH" origTime="7:07 PM" bikeflag="1" /> 
    #          <stop station="16TH" origTime="7:09 PM" bikeflag="1" /> 
    #          <stop station="CIVC" origTime="7:12 PM" bikeflag="1" /> 
    #          <stop station="POWL" origTime="7:13 PM" bikeflag="1" /> 
    #          <stop station="MONT" origTime="7:15 PM" bikeflag="1" /> 
    #          <stop station="EMBR" origTime="7:17 PM" bikeflag="1" /> 
    #          <stop station="WOAK" origTime="7:24 PM" bikeflag="1" /> 
    #          <stop station="LAKE" origTime="7:28 PM" bikeflag="1" /> 
    #          <stop station="FTVL" origTime="7:32 PM" bikeflag="1" /> 
    #          <stop station="COLS" origTime="7:35 PM" bikeflag="1" /> 
    #          <stop station="SANL" origTime="7:39 PM" bikeflag="1" /> 
    #          <stop station="BAYF" origTime="7:43 PM" bikeflag="1" /> 
    #          <stop station="HAYW" origTime="7:47 PM" bikeflag="1" /> 
    #          <stop station="SHAY" origTime="7:51 PM" bikeflag="1" /> 
    #          <stop station="UCTY" origTime="7:56 PM" bikeflag="1" /> 
    #          <stop station="FRMT" origTime="8:01 PM" bikeflag="1" /> 
    #        </train>
    #      </route>
    #      <message>
    #        <legend>bikeflag = 1, bikes allowed. bikeflag = 0, no bikes allowed.</legend>
    #        <special_schedule>
    #          <![CDATA[ Starting at 9:00 pm tonight, there will be a bus bridge between Walnut Creek and Pleasant Hill due to necessary track work. <a href="http://www.bart.gov/news/articles/2010/news20100310.aspx">Read more...</a>    ]]>
    #        </special_schedule>
    #      </message>
    #      <message>
    #    </root>
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=routesched&route=6&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=scheds+ => Requests a trip based on arriving at the time specified. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #
    #  *Returns*
    #  -  <?xml version="1.0" encoding="utf-8" ?> 
    #  <root>
    #    <uri><![CDATA[ http://api.bart.gov/api/sched.aspx?cmd=scheds ]]></uri>
    #      <schedules>
    #        <schedule id="26" effectivedate="09/14/2009 12:00 AM" /> 
    #        <schedule id="23" effectivedate="07/01/2009 12:00 AM" /> 
    #      </schedules>
    #      <message /> 
    #  </root>
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=scheds&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=special+ => Requests information about the current and upcoming BART Special Schedules. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +l=<number>+ =>  Specifies whether the legend information should be included. By default it is 0 (not shown), but can be turned on by setting it to 1. (Optional)
    #
    #  *Returns*
    #  -  <?xml version="1.0" encoding="utf-8" ?> 
    #     <root>
    #       <uri><![CDATA[ http://api.bart.gov/api/sched.aspx?cmd=special&l=1 ]]></uri>
    #       <special_schedules>
    #       <special_schedule>
    #         <start_date>08/09/2009</start_date> 
    #         <end_date>09/13/2009</end_date> 
    #         <start_time>03:45</start_time> 
    #         <end_time>19:15</end_time> 
    #         <text>Weekday trains may arrive later than scheduled at the Dublin/Pleasanton station due to construction.</text> 
    #         <link><![CDATA[ http://www.bart.gov/news/articles/2007/news20070705.aspx ]]></link>
    #         <orig>DUBL</orig>
    #         <dest>DUBL</dest> 
    #         <day_of_week /> 
    #         <routes_affected>ROUTE 1,ROUTE 2</routes_affected>
    #      </special_schedule>
    #     </special_schedules>
    #     <message>
    #       <legend>day_of_week: 0 = Sunday, 1 = Monday, 2 = Tuesday, 3 = Wednesday, 4 = Thursday, 5 = Friday, 6 = Saturday, blank = all days</legend> 
    #     </message>
    #  </root>
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=special&l=1&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=stnsched+ => Requests information about the current and upcoming BART Special Schedules. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +org=<stn>+ =>  The station for which a schedule is requested. (Required)
    #  - +date=<mm/dd/yyyy>+ =>  Specifies a specific date to use. This will determine the appropriate schedule for that date, and give back information about the station for that schedule. Date can also be specified as "today" or "now". (Optional)
    #
    #  *Returns*
    #  <?xml version="1.0" encoding="utf-8" ?> 
    #  <root>
    #    <uri><![CDATA[ http://api.bart.gov/api/sched.aspx?cmd=stnsched&orig=12th&l=1 ]]></uri>
    #    <date>10/26/2009</date> 
    #    <sched_num>26</sched_num> 
    #    <station>
    #      <name>12th St. Oakland City Center</name> 
    #      <abbr>12TH</abbr> 
    #      <item line="ROUTE 7" trainHeadStation="MLBR" origTime="4:35 AM" destTime="5:21 AM" trainIdx="1" bikeflag="1" /> 
    #      <item line="ROUTE 3" trainHeadStation="RICH" origTime="4:37 AM" destTime="5:01 AM" trainIdx="1" bikeflag="1" /> 
    #      <item line="ROUTE 2" trainHeadStation="PITT" origTime="4:37 AM" destTime="5:17 AM" trainIdx="1" bikeflag="1" /> 
    #      <item line="ROUTE 1" trainHeadStation="SFIA" origTime="4:42 AM" destTime="5:27 AM" trainIdx="1" bikeflag="1" /> 
    #      <item line="ROUTE 4" trainHeadStation="FRMT" origTime="4:44 AM" destTime="5:20 AM" trainIdx="1" bikeflag="1" /> 
    #      <item line="ROUTE 7" trainHeadStation="MLBR" origTime="4:50 AM" destTime="5:36 AM" trainIdx="2" bikeflag="1" /> 
    #      ...
    #      <item line="ROUTE 1" trainHeadStation="MLBR" origTime="12:19 AM" destTime="1:09 AM" trainIdx="90" bikeflag="1" /> 
    #      <item line="ROUTE 4" trainHeadStation="FRMT" origTime="12:21 AM" destTime="12:57 AM" trainIdx="75" bikeflag="1" /> 
    #      <item line="ROUTE 3" trainHeadStation="RICH" origTime="12:37 AM" destTime="1:04 AM" trainIdx="76" bikeflag="1" /> 
    #      <item line="ROUTE 2" trainHeadStation="PITT" origTime="12:37 AM" destTime="1:20 AM" trainIdx="91" bikeflag="1" /> 
    #      <item line="ROUTE 1" trainHeadStation="SFIA" origTime="12:50 AM" destTime="1:35 AM" trainIdx="91" bikeflag="1" /> 
    #      <item line="ROUTE 4" trainHeadStation="FRMT" origTime="12:52 AM" destTime="1:28 AM" trainIdx="76" bikeflag="1" /> 
    #    </station>
    #    <message>
    #      <legend>bikeflag = 1, bikes allowed. bikeflag = 0, no bikes allowed.</legend> 
    #    </message>
    #  </root>
    # ==== Examples
    #  http://api.bart.gov/api/sched.aspx?cmd=stnsched&orig=12th&l=1&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=stninfo+ => Requests information about the current and upcoming BART Special Schedules. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +orig=<station>+ =>  The station for which a schedule is requested. (Required)
    #  - +date=<mm/dd/yyyy>+ =>  Specifies the origination station. Stations should be specified using the four character abbreviations. (Required)
    #
    #  *Returns*
    #  <?xml version="1.0" encoding="utf-8" ?> 
    #  <root>
    #    <uri><![CDATA[ http://api.bart.gov/api/stn.aspx?cmd=stninfo&orig=24th ]]></uri>
    #      <stations>
    #        <station>
    #          <name>24th St. Mission</name> 
    #          <abbr>24TH</abbr> 
    #          <gtfs_latitude>37.752411</gtfs_latitude> 
    #          <gtfs_longitude>-122.418292</gtfs_longitude> 
    #          <address>2800 Mission Street</address> 
    #          <city>San Francisco</city> 
    #          <county>sanfrancisco</county> 
    #          <state>CA</state> 
    #           <zipcode>94110</zipcode> 
    #           <north_routes>
    #           <route>ROUTE 2</route> 
    #           <route>ROUTE 6</route> 
    #           <route>ROUTE 8</route> 
    #           <route>ROUTE 12</route> 
    #           </north_routes>
    #           <south_routes>
    #           <route>ROUTE 1</route> 
    #            <route>ROUTE 5</route> 
    #           <route>ROUTE 7</route> 
    #           <route>ROUTE 11</route> 
    #           </south_routes>
    #           <north_platforms>
    #           <platform>2</platform> 
    #           </north_platforms>
    #           <south_platforms>
    #           <platform>1</platform> 
    #           </south_platforms>
    #           <platform_info>Always check destination signs and listen for departure announcements.</platform_info> 
    #           <intro><![CDATA[ "The Mission" refers to the San Francisco de Asis Mission, also known as Mission Dolores, which was founded 1776. Today the neighborhood is host to an eclectic mix of restaurants, markets, performance spaces, shops, and nightspots. ]]></intro>
    #           <cross_street><![CDATA[ Nearby Cross: 24th St. ]]></cross_street>
    #           <food><![CDATA[ Nearby restaurant reviews from <a rel="external" href="http://www.yelp.com/search?find_desc=Restaurant+&ns=1&rpp=10&find_loc=2800 Mission Street San Francisco, CA 94110">yelp.com</a> ]]></food>
    #           <shopping><![CDATA[ Local shopping from <a rel="external"" href="http://www.yelp.com/search?find_desc=Shopping+&ns=1&rpp=10&find_loc=2800 Mission Street San Francisco, CA 94110">yelp.com</a> ]]></shopping>
    #           <attraction><![CDATA[ More station area attractions from <a rel="external" href="http://www.yelp.com/search?find_desc=+&ns=1&rpp=10&find_loc=2800 Mission Street San Francisco, CA 94110">yelp.com</a> ]]></attraction>
    #           <link>http://www.bart.gov/stations/24TH</link> 
    #         </station>
    #       </stations>
    #       <message /> 
    #  </root>
    # ==== Examples
    #  http://api.bart.gov/api/stn.aspx?cmd=stninfo&orig=24th&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=stnaccess+ => Requests information about the current and upcoming BART Special Schedules. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #  - +orig=<station>+ =>  Specifies the origination station. Stations should be specified using the four character abbreviations. (Required)
    #  - +l=<number>+ =>  Specifies whether the legend information should be included. By default it is 0 (not shown), but can be turned on by setting it to 1. (Optional)
    #
    #  *Returns*
    #  -  <?xml version="1.0" encoding="utf-8" ?> 
    #     <root>
    #       <uri><![CDATA[ http://api.bart.gov/api/stn.aspx?cmd=stnaccess&orig=12th&l=1 ]]></uri>
    #      <stations>
    #        <station parking_flag="0" bike_flag="0" bike_station_flag="0" locker_flag="1">
    #          <name>12th St. Oakland City Center</name> 
    #          <abbr>12TH</abbr> 
    #          <entering><![CDATA[ <p>The BART trains at 12th St. Oakland City Center Station are located two and three levels below the street. The first level below ground is the concourse level. The second level is the upper platform level and the third level is the lower platform level.</p>
    #          <p>Two separate elevators (referred to as Street and Platform) are needed to get from the street to the train platforms.</p>
    #          <p>The street access to the elevator is located on Broadway between 11th Street and 12th Street.</p>
    #          <p>From the street, the Street elevator will take you to the concourse level where the station agent and paid area are located. The Street elevator buttons are labeled "C" for Concourse and "S" for Street.</p>
    #          <p>When you arrive at the concourse level you will need to travel approximately 60 feet to reach the Platform elevator. The Platform elevator buttons are labeled "C" for Concourse, "UL" for upper platform, and "LL" for lower platform.</p>
    #          <p>Depending on your destination, the Platform elevator will take you to the upper platform or the lower platform. When the elevator arrives at either platform you will be at the far end of the platforms. Go straight to reach the center of the train boarding area.</p> ]]></entering>
    #          <exiting><![CDATA[ <p>The BART trains at 12th St. Oakland City Center Station are located two and three levels below the street.</p>
    #          <p>Two separate elevators (referred to as Platform and Street) are needed to get from the train platforms to the street.</p>
    #          <p>Prior to 8:45 AM weekdays Fremont and San Francisco – Daly City- bound trains arrive at both the upper platform and lower platform. After 8:45 AM on weekdays Fremont and San Francisco – Daly City bound trains arrive at the lower platform only. When departing a Fremont or San Francisco - Daly City train, the elevator will be towards the front of the train at the far end of the platform. The elevator buttons are labeled "C" for concourse, "UL" for upper platform, and "LL" for lower platform.</p>
    #          <p>When departing a Richmond or Pittsburg – Bay Point train you will be on the upper platform two levels below the street. When exiting the trains the elevator will be towards the rear of the train at the far end of the platform. The elevator buttons are labeled "C" for concourse, "UL" for upper platform, and "LL" for lower platform.</p> ]]></exiting>
    #          <parking> <![CDATA[ <p>There's no parking at 12th St. Oakland City Center Station. The closest station with parking is <a href="http://www.bart.gov/stations/LAKE/">Lake Merritt</a>.</p> ]]></parking>
    #          <fill_time><![CDATA[ ]]></fill_time>
    #          <car_share><![CDATA[ ]]></car_share>
    #          <lockers><![CDATA[ <p>8 electronic bicycle lockers managed by City of Oakland. For more information on these lockers, contact the City of Oakland at <a href="mailto:bikeped@oaklandnet.com">bikeped@oaklandnet.com</a> or (510) 238-3983.</p> ]]></lockers>
    #          <bike_station_text><![CDATA[ ]]></bike_station_text>
    #          <destinations><![CDATA[ <p>To find a destination near 12th St. Oakland City Center Station, visit the <a href="http://www.bart.gov/stations/12th/neighborhood">neighborhood section</a>.</p> ]]></destinations>
    #          <transit_info><![CDATA[ <p>12th St. Oakland City Center Station is served by <a rel="external" href="http://www.actransit.org">AC Transit</a> Routes <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=1">1</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=1R">1R</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=11">11</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=12">12</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=13">13</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=14">14</a>, <a href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=15">15</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=18">18</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=19">19</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=40">40</a>, <a href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=51">51</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=63">63</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=72">72</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=72M">72M</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=72R">72R</a>, <a rel="external" href="http://www.actransit.org/maps/schedule_results.php?version_id=3&quick_line=88">88</a>; and the regional <a rel="external" href="http://transit.511.org/providers/night.aspx">All Nighter</a>. The <a rel="external" href="http://www.greyhound.com/scripts/en/TicketCenter/terminal.asp?city=892540">Greyhound</a> bus terminal located three blocks down 20th Street at San Pablo Avenue.</p>
    #          <p><strong>Try BART's free trip planning service!</strong><br />For a personalized trip plan with BART and connecting transit, call the BART <a href="http://www.bart.gov/siteinfo/contact">Transit Information Center</a>. It's fast, it's easy, and it's tailored just for you!</p> ]]></transit_info>
    #          <link>http://www.bart.gov/stations/12TH</link> 
    #        </station>
    #      </stations>
    #      <message>
    #        <legend>parking_flag: 0 = No BART parking, 1 = Yes, parking available. bike_flag: 0 = No bike racks, 1 = Yes, bike racks available. bike_station_flag: 0 = Not a bike station, 1 = Yes, station is a bike station. locker_flag: 0 = No lockers, 1 = Yes, station has lockers.</legend> 
    #      </message> 
    #  </root>
    # ==== Examples
    #  http://api.bart.gov/api/stn.aspx?cmd=stnaccess&orig=12th&l=1&key=[Rails.application.secrets.bart_api_key]
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
    #
    #  *Arguments*
    #  - +cmd=stns+ => Requests information about the current and upcoming BART Special Schedules. (Required)
    #  - +key=<key>+ =>  API registration key. (Required)
    #
    #  *Returns*
    #  -  <?xml version="1.0" encoding="utf-8" ?> 
    #     <root> 
    #       <uri><![CDATA[ http://api.bart.gov/api/stn.aspx?cmd=stns ]]></uri>
    #       <stations>
    #         <station>
    #           <name>12th St. Oakland City Center</name> 
    #           <abbr>12TH</abbr>
    #           <gtfs_latitude>37.803664</gtfs_latitude>
    #           <gtfs_longitude>-122.271604</gtfs_longitude>
    #           <address>1245 Broadway</address> 
    #           <city>Oakland</city> 
    #           <county>alameda</county> 
    #           <state>CA</state> 
    #           <zipcode>94612</zipcode> 
    #         </station>
    #           ...
    #         <station>
    #           <name>West Oakland</name> 
    #           <abbr>WOAK</abbr>
    #           <gtfs_latitude>37.80467476</gtfs_latitude>
    #           <gtfs_longitude>-122.2945822</gtfs_longitude>
    #           <address>1451 7th Street</address> 
    #           <city>Oakland</city> 
    #           <county>alameda</county> 
    #           <state>CA</state> 
    #           <zipcode>94607</zipcode> 
    #         </station>
    #       </stations>
    #       <message /> 
    #  </root>
    # ==== Examples
    #  http://api.bart.gov/api/stn.aspx?cmd=stns&key=[Rails.application.secrets.bart_api_key]
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
