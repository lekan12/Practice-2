class ReviewsController < ApplicationController
    before_action :find_review, only: [:show, :edit, :update, :destroy]
    
    def index
    if params[:category].blank?
			@reviews = Review.all.order("created_at DESC")
	     else
			@category_id = Category.find_by(name: params[:category]).id
			@reviews = Review.where(:category_id => @category_id).order("created_at DESC")
    end
    end
    
    def show
       @review = Review.find(params[:id])
    end
    
    def new
        @review = current_user.reviews.build
        @categories = Category.all.map{ |c| [c.name, c.id] }      
    end
    
    def create
        @review = current_user.reviews.build(review_params)
        @review.category_id = params[:category_id]   
        
        if @review.save
			redirect_to root_path
		else
			render 'new'
	end
    end
    
    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end
    
    def update
        @review.category_id = params[:category_id] 
        if @review.update(review_params)
			redirect_to review_path(@review)
		else
			render 'edit'
	end
    end
    
    def destroy
        @review.destroy
        redirect_to root_path
    end
    
    private
     
      def review_params
          params.require(:review).permit(:headline, :summary, :link, :writer, :category_id)
      end
      
      def find_review
         @review = Review.find(params[:id]) 
      end
      
end

