class MacrosController < ApplicationController

  def display_form
  render({ :template => "macro_templates/new_form"})
  end
end
