module ApplicationHelper

	def kramdown(text)
    	return sanitize Kramdown::Document.new(text).to_html
  	end

	# Returns the full title on a per-page basis.
	def full_title(page_title = " ")
		base_title = "Attendrr"
		if page_title.empty? || page_title.nil?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	def link_to_image(image_path, target_link,options={})
  	link_to(image_tag(image_path, :border => "0",:class => "custom_icons align-self-center"), target_link, options)
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
