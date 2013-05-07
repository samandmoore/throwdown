# open up sinatra base class and add some helpers
class Sinatra::Base
	helpers do
		def show_alert(key=:flash)
			return "" if flash(key).empty?
			id = (key == :flash ? "alert" : "alert-#{key}")
			messages = flash(key).collect {|message| "  <div class='alert #{message[0]}'>#{message[1]}</div>\n"}
			"<div id='#{id}'>\n" + messages.join + "</div>"
		end
	end
end