class MyAreasController < ApplicationController

  #
  # KEEP ONE
  #
  dont_kick :guest,  only: :guest_page
  dont_kick :novice, only: :novice_page
  dont_kick :webmaster, only: :webmaster_page


  #
  # KICK ONE
  #
  kick :webmaster, only: :non_webmaster_page
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

  def webmaster_page
    yes
  end

  def non_webmaster_page
    yes
  end



  private

  def yes
    render text: "yes!"
  end

end
