class MacrosController < ApplicationController

  def display_form
  render({ :template => "macro_templates/new_form"})
  end

  def do_magic
    @the_description = params.fetch("description_param")
    @the_image = params.fetch("image_param")

    @the_image_converted = DataURI.convert(@the_image)

    c = OpenAI::Chat.new
    c.system("You are an expert nutritionist. Esitmate the macronutrients (carbohydrates, protein, and fat) in grams, as well as total calories in kcal.:")
    c.user(@the_description)
    @result = c.assistant!


    render({ :template => "macro_templates/results"})
  end

end
