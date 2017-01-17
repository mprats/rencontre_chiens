class Dog < ActiveRecord::Base
    belongs_to :user
    
    has_many :pictures, :dependent => :destroy
end
