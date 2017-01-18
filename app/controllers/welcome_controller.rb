class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
    def index
      @q = Dog.ransack(params[:q])
    end
end
