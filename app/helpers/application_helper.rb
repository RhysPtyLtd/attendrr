module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title = " ")
		base_title = "Attendrr"
		if page_title.empty? || page_title.nil?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	# Formats names correctly  	THIS DOESN'T WORK
	#class String
	    # def capitalize_name
	    #     name_capitalized = ""
	    #     self.capitalize!
	    #     char_array = self.split("")
	    #     char_array.each_index do |i|
	    #         if char_array[i-1] == "-" || char_array[i-1] == "'" || char_array[i-1] == " "
	    #             char_array[i].upcase!
	    #         end
	    #         name_capitalized << char_array[i]
	    #     end
	    #     name_capitalized.strip.squeeze(" ")
	    # end
	#end
end