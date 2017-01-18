class PicturesController < ApplicationController
    def destroy
        @dog = Dog.find(params[:dog_id])
        @picture = Picture.find(params[:id])
        @picture.destroy
    
        respond_to do |format|
          format.html { redirect_to edit_dog_path(@dog) }
          format.js
        end
    end
end
