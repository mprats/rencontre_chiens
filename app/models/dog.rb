class Dog < ActiveRecord::Base
    belongs_to :user
    
    validates_presence_of :name, :breed, :birthdate, :gender
    
    has_many :pictures, :dependent => :destroy
end
