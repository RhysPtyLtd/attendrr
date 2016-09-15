class String
	def capitalize_name
		name_capitalized = ""
		self.capitalize!
		char_array = self.split("")
		char_array.each_index do |i|
			if char_array[i-1] == "-" || char_array[i-1] == "'" || char_array[i-1] == " "
				char_array[i].upcase!
			end
			name_capitalized << char_array[i]
		end
		name_capitalized.strip.squeeze(" ")
	end
end