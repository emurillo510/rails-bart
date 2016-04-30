class BartController < ApplicationController
include BartApiHelper::Advisories
include BartApiHelper::RealTimeInformation
include BartApiHelper::RouteInformation
include BartApiHelper::ScheduleInformation
include BartApiHelper::StationInformation
  
  # Advisories Modules
  def index
     puts "inside controller"
     say_hello
  end
  
  def get_advisories
    puts "inside "
    bart_bsa_get_advisories
  end
  
  def get_train_count
    puts "inside train code"
    bart_train_count
  end
  
  def get_elevator_status
    puts "get elevator status"
    bart_elevator_status
  end
  
  # RealTime Information Modules
  def get_etd
    "puts get etd"
    bart_estimate_departure
  end
  
  def get_etd_filter
    "puts get etd"
    bart_estimate_departure_filter
  end
  
  # RouteInformation Modules
  def get_routes
    puts "get routes"
    bart_routes
  
  end
  
  def get_routeinfo
    puts "route info"
    bart_routeinfo
  end
  
  # ScheduleInformation Modules
 def get_arrive
   puts "bart arrive"
   bart_arrive
 end
 
 def get_depart
   puts "bart depart"
   bart_depart
 end
 
 def get_fare
   puts "fare"
   bart_fare
 end
 
 def get_holiday
   puts "holiday"
   bart_holiday
 end
 
 def get_load
   puts "load"
   bart_load
 end
 
 def get_route_schedule
   puts "route sched"
   bart_route_schedule
 end
 
 def get_schedules
   puts "bart schedules"
   bart_schedules
 end
 
 def get_special
   puts "bart special"
   bart_special
 end
 
 def get_station_schedule
   puts "get station schedule"
   bart_station_schedule
 end
  
  # StationInformation Modules
  def get_station_info
    puts "get station info"
    bart_station_info
  end
  
  def get_station_access
    puts "station access"
    bart_station_access
  end
  
  def get_station_list
    puts "station list"
    bart_stations
  end
end
