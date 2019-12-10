class UsersController < ApplicationController
    
    def my_portfolio
        @user = current_user
        @user_stocks = @user.stocks
    end
    def my_friends
       @friendships = current_user.friends 
    end
    def search
        if params[:search_param].blank?
            flash.now[:danger] = "You have not entered anything...What did you expect to happen?"
        else
            @users = User.search(params[:search_param])
            @users = current_user.except_current_users(@users)
            flash.now[:danger] = "No users were found with that search" if @users.blank?
        end 
        respond_to do |format|
            format.js {render partial: 'friends/result'}
        end
    end
    
    def add_friend
       @friend = User.find(params[:friend])
       current_user.friendships.build(friend_id: @friend.id)
       
       if current_user.save
          flash[:success] = "You have successfully added #{@friend.first_name} as a friend" if @friend.first_name
       else
           flash[:danger] = "You cannot add them as a friend at this time."
       end
       redirect_to my_friends_path
    end
    
    def show
       @user = User.find(params[:id])
       @user_stocks = @user.stocks
    end
    
end