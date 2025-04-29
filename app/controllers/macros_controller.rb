class MacrosController < ApplicationController

  def display_form
  render({ :template => "macro_templates/new_form"})
  end

  def do_magic
    render({ :template => "macro_templates/results"})
  end

end
