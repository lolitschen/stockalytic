require "json"
require "open-uri"
require "date"

class ApplicationController < ActionController::Base
  
  def index
    u2= open("http://www.quandl.com/api/v1/datasets/DMDRN/MSFT_STOCK_PX?auth_token=3sJWZjsd8FwnTxAikHm7").read
    u = open("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%20%3D%20%22YHOO%22%20and%20startDate%20%3D%20%222013-09-11%22%20and%20endDate%20%3D%20%222014-05-2%22&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=").read
    @response = JSON.parse(u)
    
    @response['query']['results']['quote'].each do |stock|
      s = Stock.find_by_date(stock['date'])
      unless s
        s=Stock.new
        s.symbol = stock['Symbol']
        s.date = Date.parse(stock['Date'])
        s.open = stock['Open']
        s.high = stock['High']
        s.low = stock['Low']
        s.close = stock['Close']
        s.save
      end  
    end
    
    @data = Stock.all
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end