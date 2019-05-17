class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: [:edit, :update, :destroy]

  
  def index
    @posts = if params[:tag]
      Post.tagged_with(params[:tag])
    else
      Post.all.reverse
    end
  end
  
  def create
     post = Post.new
     post.image =params[:image]
     post.title = params[:title]
     post.content = params[:content]
     post.user_id = current_user.id
     post.board_id = params[:board_id]
     post.tag_list = params[:name]
     
  
     if post.save
        redirect_to post_path(post),notice:"Create Question!"
     else
        render :new 
     end
  end


  def show
    @post = Post.find(params[:id])
   
  end

  def new
    @post = Post.all
    
  end

  def edit
    @post =Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    redirect_to root_path if @post.user.id != current_user.id
    @post.content = params[:content]
    @post.title = params[:title]
    @post.tag_list = params[:name]
    @post.image = params[:image]if params[:image].present?
    if @post.save
      redirect_to root_path
    else
      render:edit 
    end
    
    def destroy
      @post = Post.find_by(params[:id])
      redirect_to root_path if @post.user.id != current_user.id
      
      @post.destroy
      redirect_to root_path
    end


  end
  
  private
  
  def allowed_params
    params.require(:post).permit(:title , :content, :tag_list)
  end
  
  def check_ownership
    @post = Post.find_by(id: params[:id])
    redirect_to root_path if @post.user.id != current_user.id
  end

  
  
end