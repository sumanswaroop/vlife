class PostsController < ApplicationController
	before_action :logged_in_user , only: [:create, :destroy]
	def create
		@newPost = current_user.own_posts.build(post_params)
		@newPost.p_id = Base64.encode64(Post.count.to_s);
		
		if @newPost.posted_to_id.nil? 
			@newPost.posted_to_id = current_user.u_id
		end
		if @newPost.save
			flash[:success] = "Posted Sucessfully"
			redirect_to home_url
		else
			flash[:info] = "Could Not Post"
			redirect_to home_url
		end
	end

	def post_params
		params.require(:post).permit(:content, :posted_to_id)
	end


end
