class StocksController < ApplicationController 
   def search
      if params[:stock].present?
         @stock = Stock.new_from_lookup(params[:stock])
         if @stock 
            puts "should be"
            respond_to do |format|
            format.js { render partial: 'users/result' }            
            end

         else
            puts "incorrect symbol"
            flash[:danger] = "You have entered an incorrect symbol."
            redirect_to my_portfolio_path
         end
          
      else
         puts "nothing"
         flash[:danger] = "You need to type something, what did you expect to happen?"
         redirect_to my_portfolio_path
      end
   end
end