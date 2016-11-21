class PostsController < ApplicationController
	before_action :logged_in_user , only: [:create, :destroy]
	def create
		@newPost = current_user.own_posts.build(post_params)
		@newPost.p_id = Post.count.to_s(36)
		
		###notification for post / comment based on parent_id
		
		if @newPost.save
			flash[:success] = "Posted Sucessfully"
			redirect_to :back
		else
			flash[:info] = "Could Not Post"
			redirect_to :back
		end
	end

	def send_post
		@newPost = current_user.own_posts.build(post_params)
		@newPost.p_id = Post.count.to_s(36)

		if @newPost.save
			flash[:notice] = "Posted Succesfully"
			msg = {:value => "ok"}
			render :json => msg
		else
			flash[:notice] = "Error!, try again"
			msg = {:value => "err"}
			render :json => msg
		end
	end

	def post_params
		params.require(:post).permit(:content, :posted_to_id, :parent_id, :page_id)
	end

end
