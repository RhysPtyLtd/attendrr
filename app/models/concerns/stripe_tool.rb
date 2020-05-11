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
		customer = Stripe::Customer.create(
			email: email,
			source: stripe_token,
			plan: plan
		)
		#updates Club subscription
		current_club = Club.find_by(email: email)
		current_club.subscription = Subscription.find_by(stripe_id: plan)
		#saves Stripe subscription ID to clubs database
		current_club.stripe_subscription_id = customer.subscriptions['data'][0].id
		current_club.stripe_customer_id = customer.id

		current_club.save
	end

	def self.cancel_subscription(club)
		Stripe::Subscription.delete(club.stripe_subscription_id)
		club.stripe_subscription_id = nil
		club.stripe_customer_id = nil
		club.subscription = Subscription.find(1)
		club.save
	end

	def self.change_subscription(club, plan_changing_to)
		subscription = Stripe::Subscription.retrieve(club.stripe_subscription_id)

		Stripe::Subscription.update(
			subscription.id,
			{
				cancel_at_period_end: false,
				proration_behavior: 'create_prorations',
				items: 
					[{
						id: subscription.items.data[0].id,
						plan: plan_changing_to.stripe_id
					}]
			}
		)

		#club.stripe_subscription_id = nil
		club.subscription = plan_changing_to
		club.save
	end

end