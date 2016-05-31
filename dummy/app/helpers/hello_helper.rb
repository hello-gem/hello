module HelloHelper

  def nav_link_to(*args)
    args.pop
    link_to(*args)
  end

end
