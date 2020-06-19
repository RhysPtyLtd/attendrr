module StripeTool

	# Not used anywhere. This is to create a customer for a one-off purchase.
	def self.create_customer(email: email, stripe_token: stripe_token)
		Stripe::Customer.create(
			email: email,
			source: stripe_token
		)
	end

	# Not used anywhere. This is to create a one-off payment
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
		club.subscription = plan_changing_to
		club.save
	end

	def self.calculate_proration(club, plan_changing_to)
		# Set proration date to this moment:
		proration_date = Time.now.to_i

		subscription = Stripe::Subscription.retrieve(club.stripe_subscription_id)

		# See what the next invoice would look like with a plan switch and proration set:
		items = [{
    		id: subscription.items.data[0].id,
    		plan: plan_changing_to.stripe_id, # Switch to new plan
		}]

		invoice = Stripe::Invoice.upcoming({
    		customer: club.stripe_customer_id,
   			subscription: club.stripe_subscription_id,
    		subscription_items: items,
    		subscription_proration_date: proration_date,
		})

		# Calculate the proration cost:
		current_prorations = invoice.lines.data.select { |ii| ii.period.start - proration_date <= 1 }
		cost = 0
		current_prorations.each do |p|
    		cost += p.amount
		end
	end

end