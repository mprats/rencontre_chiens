class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    
    def show
        @user = User.find(params[:id]);
        @age = Date.today.year - @user.birthdate.year
        @age -= 1 if Date.today < @user.birthdate + @age.years
    end
    
end
