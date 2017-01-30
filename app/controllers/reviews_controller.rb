class ReviewsController < ApplicationController
    
    def index
       @reviews = Review.all.order("created_at DESC")
    end
    
    def new
        @review = Review.new
    end
    
    def create
        @review = Review.new(review_params)
        
        if @review.save
			redirect_to root_path
		else
			render 'new'
	end
    end
    
    private
     
      def review_params
          params.require(:review).permit(:headline, :summary, :link, :writer)
      end
      
end

