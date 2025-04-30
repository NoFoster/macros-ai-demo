class MacrosController < ApplicationController

  def display_form
  render({ :template => "macro_templates/new_form"})
  end

  def do_magic
    @the_description = params.fetch("description_param", "")
    @the_image = params.fetch("image_param", "")

    @the_image_converted = DataURI.convert(@the_image)

    chat = OpenAI::Chat.new
    chat.model = "gpt-4.1-nano"
    chat.system("You are an expert nutritionist. Esitmate the macronutrients (carbohydrates, protein, and fat) in grams, as well as total calories in kcal.:")

        
    #chat.user(@the_description, image: @the_image)

    chat.schema = '{
      "name": "nutrition_info",
      "schema": {
        "type": "object",
        "properties": {
          "carbohydrates": {
            "type": "integer",
            "description": "Amount of carbohydrates in grams."
          },
          "protein": {
            "type": "integer",
            "description": "Amount of protein in grams."
          },
          "fat": {
            "type": "integer",
            "description": "Amount of fat in grams."
          },
          "total_calories": {
            "type": "integer",
            "description": "Total calories in kilocalories."
          }
        },
        "required": [
          "carbohydrates",
          "protein",
          "fat",
          "total_calories",
          "notes"
        ],
        "additionalProperties": false
      },
      "strict": true
    }'

    result = chat.assistant!

    @g_carbs = result.fetch("carbohydrates")
    @g_protein = result.fetch("protein")
    @g_fat = result.fetch("fat")
    @kcal = result.fetch("total_calories")
    @notes = result.fetch("notes")
  

    render({ :template => "macro_templates/results"})
  end

end
