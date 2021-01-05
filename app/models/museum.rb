class Museum < ApplicationRecord


    
end
class Museum < ApplicationRecord

    def self.create_from_collection(museums)
        museums.each do |museum|
            Museum.create(museum)
        end 
    end 
end 