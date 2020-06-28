class BlogPostsController < ApplicationController

	def index
		@blog_posts = BlogPost.all.order("created_at DESC")
    @most_recent = @blog_posts[0..2]
    @all_others = @blog_posts[3..-1]

	end

  def admin
    unless admin?
          redirect_to root_url 
      end
    @blog_posts = BlogPost.all.order("created_at DESC")
  end

	def show
  		@blog_post = BlogPost.find(params[:id])
      @posting_date = @blog_post.created_at.to_date.to_formatted_s(:long)
      @content = @blog_post.content
      @picture = @blog_post.picture
	end

	def new
		unless admin?
      		redirect_to root_url 
    	end
        @blog_post = BlogPost.new
    end

    def create
        @blog_post = BlogPost.new(blog_post_params)
        if @blog_post.save
            redirect_to @blog_post
        else
            render 'new'
        end
    end

    def update
    	unless admin?
      		redirect_to root_url 
    	end
        @blog_post = BlogPost.find(params[:id])
        if @blog_post.update(blog_post_params)
          flash[:success] = "Post edited"
            redirect_to @blog_post
        else
            render 'edit'
        end
    end

    def edit
    	unless admin?
      		redirect_to root_url 
    	end
        @blog_post = BlogPost.find(params[:id])
    end

    def destroy
    	unless admin?
      		redirect_to root_url 
    	end
        @blog_post = BlogPost.find(params[:id])
        @blog_post.destroy

        flash[:success] = "Post deleted"
        redirect_to admin_blog_posts_path
    end

    private

       	def blog_post_params
           	params.require(:blog_post).permit(:title, :subtitle, :content, :picture)
       	end

       	def admin?
      		if current_club
        		if current_club.admin?
          			true
        		end
      		end
    	end

end