class CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def create
         comment = Comment.new
         comment.post_id = params[:post_id]
         comment.content = params[:content]
         comment.user_id = params[:user_id]
         comment.save
         redirect_to post_path(comment.post)
    end
end
