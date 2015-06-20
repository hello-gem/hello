class MyAreasController < ApplicationController

  #
  # KEEP ONE
  #
  dont_kick :guest,  only: :guest_page
  dont_kick :novice, only: :novice_page
  dont_kick :master, only: :master_page


  #
  # KICK ONE
  #
  kick :master, only: :non_master_page
  kick :guest,  only: :authenticated_page



  #
  # USER AREA
  #
  kick :guest, :novice, only: :user_page









  def guest_page
    yes
  end

  def authenticated_page
    yes
  end

  def novice_page
    yes
  end

  def user_page
    yes
  end

  def master_page
    yes
  end

  def non_master_page
    yes
  end



  private

  def yes
    render text: "yes!"
  end

end
