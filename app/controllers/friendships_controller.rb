class FriendshipsController < ApplicationController

  #before_filter :signed_in_user
  before_filter :authenticate_user!
  respond_to :html, :js



  def create
    @user = User.find(params[:other_person_id])
    Friendship.create(:first_person_id => current_user.id, :second_person_id => @user.id)
    respond_with @user
  end

  def destroy

    @user = User.find(params[:other_person_id])
    @friendship = Friendship.find_by_first_person_id_and_second_person_id(current_user.id, @user.id) || 
    Friendship.find_by_first_person_id_and_second_person_id(@user.id, current_user.id)
    @friendship.destroy
    respond_with @user
  end

end
