#I want to put all the info on a google spreadsheet, but I'm still figuring out how to do it properly. 
#This is a work in progress
require 'rubygems'
require 'nokogiri'
require "google_drive" #to write on a google spreadsheet
puts "your mail"
mail = gets.chomp
puts "your password"
password = gets.chomp
puts "URL: "
remote_full_url = gets.chomp #link to be parsed
puts "spreadsheet"
spreadsheet = gets.chomp

session = GoogleDrive.login(mail,password)
# First worksheet of
# https://docs.google.com/spreadsheet/ccc?key=0ApYLZ3W1aumqdFVONnRGMVF5Z1RwRm5CMjZRRHpPX0E - as example
ws = session.spreadsheet_by_key(spreadsheet).worksheets[0]
remote_data = Nokogiri::HTML(open(remote_full_url)) 
# this is only printing on row 2. I need to make it read if there's anything on a row and if it is, to print the data to 
#the row below. 
# I also need to figure out how to handle things like "Actividades" 
#(span#ctl00_ctl13_g_e4f66c46_a162_4329_83cb_3d7fe77e4b57_ctl00_gvActividades_ctl02_lblActividade), where some of the 
#Members have more than one entry. the <span> is always identical, with a different number before "_lblText"
ws [2,1] = (remote_data.css("span.title2").text)
ws[2,2] = (remote_data.css("span#percentagem_entrega.relatorio_campanha_metricas_grandes_numeros").text) #Nome Completo
ws[2,3] = (remote_data.css("span#percentagem_bounce.relatorio_campanha_metricas_grandes_envios_numero").text)
ws[2,4] = (remote_data.css("span#percentagem_visualizacao.relatorio_campanha_metricas_grandes_numeros").text)
ws[2,5] = (remote_data.css("span#percentagem_por_abrir.relatorio_campanha_metricas_grandes_envios_numero").text)
ws[2,6] = (remote_data.css("span#taxa_clicks.relatorio_campanha_metricas_grandes_envios_numero").text)
ws[2,7] = (remote_data.css("span#taxa_queixas.relatorio_campanha_metricas_grandes_envios_numero").text)
#  
ws.save()

puts "Done"
