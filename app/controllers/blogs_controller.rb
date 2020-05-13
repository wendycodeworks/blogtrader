class BlogsController < ApplicationController
    before_action :authenticate_user!

    def index
        @blogs = Blog.all
    end

    def show
        @blog = Blog.find_by(id: params[:param])
    end

    def new
        @blog = Blog.new
    end

    def create
        @blog = current_users.blogs.create(blog_params)
    end

    def edit
    
    end

    def update
        @blog = Blog.update(params["id"], blog_params)
        if @blog.errors.any?
            render "edit"
        else
            redirect_to root_path
        end
    end

    def destroy
        Blog.find(params["id"]).destroy
        redirect_to root_path
    end

    private
    
    def set_blog
        @blog.find(params["id"])
    end

    def blog_params
        params.require(:blog).permit(:title, :website, :description, :revenue, :price)
    end

end
