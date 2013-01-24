class UsersController < ApplicationController
  before_filter :authenticate_user!



  def adminify
    @user = User.find(params[:id])
    if @user.update_attribute(:admin, true);
      redirect_to @user, :notice => "Level up!"
    else
      redirect_to @user, :notice => "Could not make you admin"
    end 
  end


  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    @users = User.search(params[:search])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @post = Post.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    if(current_user.admin)
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to users_path, :notice => "You are not allowed to do Users#new"
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
      if @user == current_user || current_user.admin
        @user.update_attributes(params[:user])
      else
        redirect_to users_path, :notice => "You are not allowed to do Users#edit"
      end  

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if current_user.admin
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    else
      redirect_to users_path, :notice => "You are not allowed to do this"
    end
  end
end
