# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def encode(name)
    name + "_"
  end
end
