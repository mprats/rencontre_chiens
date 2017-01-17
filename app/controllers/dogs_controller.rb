class DogsController < ApplicationController
  before_action :set_dog, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  
  # GET /dogs
  # GET /dogs.json
  def index
    @dogs = current_user.dogs
  end
  
  def results
    @q = Dog.ransack(params[:q])
    # @dogs = @q.result(distinct: true)
    @dogs = @q.result.includes( :user )
  end
  
  def search
    @q = Dog.ransack(params[:q])
    # @dogs = @q.result(distinct: true)
    @dogs = @q.result.includes( :user )
  end 

  # GET /dogs/1
  # GET /dogs/1.json
  def show
    @dog = Dog.find(params[:id])
    @pictures = @dog.pictures
    @age = Date.today.year - @dog.birthdate.year
    @age -= 1 if Date.today < @dog.birthdate + @age.years
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
      @pictures = @dog.pictures
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @dog.user_id = current_user.id;

    respond_to do |format|
      if @dog.save
        
        if params[:images]
          params[:images].each { |image|
            @dog.pictures.create(image: image)
          }
        end
        
        format.html { redirect_to @dog, notice: 'Le chien a bien été sauvegardé.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    @pictures = @dog.pictures
    
    respond_to do |format|
      if @dog.update(dog_params)
        
        if params[:images]
          params[:images].each { |image|
            @dog.pictures.create(image: image)
          }
        end
        
        format.html { redirect_to @dog, notice: 'Le chien a bien été sauvegardé.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Le chien a bien été supprimé.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      if user_signed_in? 
        @dog = current_user.dogs.find(params[:id])
      end
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :breed, :birthdate, :gender)
    end
    
    # #calcule d'age 
    # def age
    #   ret = (DateTime:current - @dog.birthdate)/3
    # end 
end
