class FriendshipsController < ApplicationController

  before_filter :signed_in_user
  respond_to :html, :js



  def create
     @user = User.find(params[:friendship][:second_person])
     current_user.befriend!(@user)
     respond_with @user
   end

   def destroy
     @user = Relationship.find(params[:id]).second_person
     current_user.unfriend!(@user)
     respond_with @user
   end

end
