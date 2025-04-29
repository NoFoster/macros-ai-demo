Rails.application.routes.draw do


  # Solutions below. Don't peek until you try it yourself and get stuck!
  get("/blank_form", { :controller => "macros", :action => "display_form"})

  post("/process_inputs", { :controller => "macros", :action => "do_magic"})
  
  
  get("/solutions/blank_form", { :controller => "solutions", :action => "display_form" })
  
  post("/solutions/process_form", { :controller => "solutions", :action => "process_inputs" })
  
end
