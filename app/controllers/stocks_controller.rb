puts "TESTEST"
class StocksController < ApplicationController 
  def search
    if params[:stock].blank?
      flash.now[:danger] = "You have not entered anything...What did you expect to happen?"
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "That is an incorrect symbol" unless @stock
    end 
    respond_to do |format|
      format.js {render partial: 'users/result'}
    end
  end
end