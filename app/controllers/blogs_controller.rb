class BlogsController < ApplicationController
    before_action :authenticate_user!
    before_action 

    def index
        @blogs = Blog.all
    end

    def show
        @blog = Blog.find(params["id"])
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
        for topic in params[:blog][:topic].split(", ")
           Blog.last.topics.create(name: topic)
        end
    end

    def edit
    @blog = Blog.find(params["id"])

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
