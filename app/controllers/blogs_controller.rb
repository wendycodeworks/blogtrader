class BlogsController < ApplicationController
    before_action :authenticate_user!

# ==================== Search Methods ===================== #
    def index
        @q = Blog.ransack(params[:q])
        @blogs = @q.result(distinct: true)
        @blogs = Blog.all
    end
# ==================== Search Methods End ================= #
# ===================== Blog Methods ====================== #
   
    def show
        @blog = Blog.find(params["id"])
        @blog_topic = Blog.find(params["id"]).topics

        session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
                name: @blog.title,
                description: @blog.website,
                amount: @blog.deposit_amount * 100,
                currency: 'aud',
                quantity: 1,
            }],
            payment_intent_data: {
                metadata: {
                    user_id: current_user.id,
                    listing_id: @blog.id
                }
            },
            success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{@blog.id}",
            cancel_url: "#{root_url}listings"
        )
    
        @session_id = session.id
    end

    def new
        @blog = Blog.new
    end

    def create       
        @blog = current_user.blogs.create(blog_params)
        if @blog.errors.any?
            render "new"
        else
            redirect_to root_path
        end
# ---------------------------------------------------------
#       Create blog listing with new topics per user input
#----------------------------------------------------------
        for topic in params[:blog][:topic].downcase.split(", ")
           Blog.last.topics.create(name: topic)
        end
    end
# ---------------------------------------------------------
#       Manage blog listing display current user blogs
#----------------------------------------------------------
    def manage
    @blogs = current_user.blogs.all
    end

    def edit
        @blog = Blog.find(params["id"])
    end

    def update
        @blog = Blog.update(params["id"], blog_params)
        if @blog.errors.any?
            render "edit"
        else
            redirect_to blog_url
        end
# --------------------------------------------------------
#       Update blog listing with new topics per user input
#----------------------------------------------------------
        Blog.find(params["id"]).topics.destroy_all
        for topic in params[:blog][:topic].downcase.split(", ")
            Blog.find(params["id"]).topics.create(name: topic)
        end
    end

    def destroy
        Blog.find(params["id"]).destroy
        redirect_to manage_listings_path
    end
# =================== Blog Methods End ==================== #

# ===================Favourite Methods ==================== #

# ===================Favourite Methods End================= #


    private
    
    def set_blog
        Blog.find(params["id"])
    end

    def blog_params
        params.require(:blog).permit(:title, :website, :description, :revenue, :price, :deposit_amount, :picture)
    end

end
