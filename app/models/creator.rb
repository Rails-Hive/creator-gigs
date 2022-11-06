class Creator < ApplicationRecord
    has_many :gigs

    default_scope -> { select(:id, :first_name, :last_name) } 
    scope :like, ->(argument){ where("first_name ILIKE ? or last_name ILIKE ?", "%#{argument}%", "%#{argument}%") }

    def name
        self.first_name + " " + self.last_name
    end

    private

    def self.build_query(params)

        @creators = self.all

        if params[:sort] && params[:sort_direction]
            @creators = @creators.order(params[:sort] => params[:sort_direction])
        end
    
        if params[:limit]
            @creators =  @creators.limit(params[:limit])
        end
    
        if params[:offset]
            @creators = @creators.offset(params[:offset])
        end
        
        @creators
    end
end
