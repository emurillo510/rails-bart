#  BartController class serves Bart API data to the client in json format.
class BartController < ApplicationController
  include BartApiHelper::Advisories
  include BartApiHelper::RealTimeInformation
  include BartApiHelper::RouteInformation
  include BartApiHelper::ScheduleInformation
  include BartApiHelper::StationInformation

@VALID_PARAMETERS = %(cmd, key, orig, plat, dir, route, sched, date, time. b, a, l, dest, Id1, Id2, Id3, st)

def index
    bart_bsa_get_advisories  
end
  
  # Advisories Module
  
  # get_bart_bsa_get_advisories - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_bsa_get_advisories
    bart_bsa_get_advisories
  end
  
  # get_bart_train_count - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_train_count
    bart_train_count
  end
  
  # get_bart_elevator_status - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_elevator_status
    bart_elevator_status
  end
  
  # RealTime Information Module
  
  # get_bart_estimate_departure - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_estimate_departure
    bart_estimate_departure
  end
  
  # get_bart_estimate_departure_filter - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_estimate_departure_filter
    bart_estimate_departure_filter
  end
  
  # RouteInformation Module
  
  # get_bart_routes - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_routes
    bart_routes
  end
  
  # get_bart_routeinfo - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_routeinfo
    bart_routeinfo
  end
  
  # Schedule Information Module
  
  
  # get_bart_arrive - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_arrive
   bart_arrive
 end
 
 
 # get_bart_depart - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_depart
   bart_depart
 end
 
 # get_bart_fare - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_fare
   bart_fare
 end
 
 # get_bart_holiday - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_holiday
   bart_holiday
 end
 
 # get_bart_load - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_load
   bart_load
 end
 
 # get_bart_route_schedule - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_route_schedule
   bart_route_schedule
 end
 
 # get_bart_schedules - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_schedules
   bart_schedules
 end
 
 # get_bart_special - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_special
   bart_special
 end
 
 # get_bart_station_schedule - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
 def get_bart_station_schedule
   bart_station_schedule
 end
  
  # Station Information Module
  
  # get_bart_station_info - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_station_info
    bart_station_info
  end
  
  # get_bart_station_access - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_station_access
    bart_station_access
  end
  
  # get_bart_stations - Requests current advisory information.
  #
  #  *Arguments*
  #  - +cmd=bsa+ => Requests current advisory information (Required)
  #  - +orig=<stn>+ => Only get messages for specified station. Defaults to "all". (Optional) 
  #                      [Note: currently only "orig=all" or leaving the orig parameter off are supported, 
  #                      the BART system does not currently provide station specific BSA messages.]
  #  - +key=<key>+ =>  API registration key (Required)
  # 
  #  *Returns* (in JSON format not XML)
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
  def get_bart_stations
    bart_stations
  end
  
  private
    def client_params
      params.permit(@VALID_PARAMETERS)
    end
end
