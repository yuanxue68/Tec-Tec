module AuctionsHelper
  def time_passed_in_percent(auction)
    "#{((Time.now - auction.start_time)/(auction.end_time - auction.start_time))*100}%"
  end  
end
