class StaticPagesController < ApplicationController
  def home
    @ending_soon = Auction.ordered_search('ending', '').limit(4)
    @recently_posted = Auction.ordered_search('recent', '').limit(4)
    @lowest_buyout = Auction.ordered_search('buyout_price', '').limit(4)
  end
end
