module StripeTool

	def self.create_customer(email: email, stripe_token: stripe_token)
		Stripe::Customer.create(
			email: email,
			source: stripe_token
		)
	end

	def self.create_charge(customer_id: customer_id, amount: amount, description: description)
		Stripe::Charge.create(
			customer: customer_id,
			amount: amount,
			description: description,
			currency: 'aud'
		)
	end

	def self.create_membership(email: email, stripe_token: stripe_token, plan: plan)
		Stripe::Customer.create(
			email: email,
			source: stripe_token,
			plan: plan
		)
		#updates Club subscription
		current_club = Club.find_by(email: email)
		current_club.subscription = Subscription.find_by(stripe_id: plan)
		current_club.save!
	end

end