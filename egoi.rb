require 'rubygems'
require 'nokogiri' #to parse html
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
ws = session.spreadsheet_by_key(spreadsheet).worksheets[0]
remote_data = Nokogiri::HTML(open(remote_full_url)) 
ws [2,1] = (remote_data.css("span.title2").text) #it chooses the info inside the span title2 and pastes the text to the 
#spreadsheet
ws[2,2] = (remote_data.css("span#percentagem_entrega.relatorio_campanha_metricas_grandes_numeros").text)
ws[2,3] = (remote_data.css("span#percentagem_bounce.relatorio_campanha_metricas_grandes_envios_numero").text)
ws[2,4] = (remote_data.css("span#percentagem_visualizacao.relatorio_campanha_metricas_grandes_numeros").text)
ws[2,5] = (remote_data.css("span#percentagem_por_abrir.relatorio_campanha_metricas_grandes_envios_numero").text)
ws[2,6] = (remote_data.css("span#taxa_clicks.relatorio_campanha_metricas_grandes_envios_numero").text)
ws[2,7] = (remote_data.css("span#taxa_queixas.relatorio_campanha_metricas_grandes_envios_numero").text)
#  
ws.save()

puts "Done"
