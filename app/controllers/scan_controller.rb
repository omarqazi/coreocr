require 'google/cloud/vision'

class ScanController < ApplicationController
  def index
  end
  
  def upload
    vision = Google::Cloud::Vision.new project: 'bqe-core-ocr'
    
    image  = vision.image params[:picture].path
    @result_text = image.text
    
    currency_regex = /\d+\.\d\d/
    possible_currency_numbers = @result_text.to_s.scan(currency_regex)
    dollar_amounts = possible_currency_numbers.map { |n| n.to_f }
    
    @possibly_receipt = possible_currency_numbers.length > 0
    @receipt_total = dollar_amounts.max
    render action: :index
  end
end
