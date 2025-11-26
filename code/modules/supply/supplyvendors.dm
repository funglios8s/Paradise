// this will define the vendors and how to define them

/datum/supplyvendors
	// Name of this vendor
	var/name = ""
	 // This will define which section this vendor appears in
	var/category = null
	// This will define the positive or negative relationship with the vendor
	var/list/relationship = list()
	// This defines what abstractions can occur when purchasing
	var/list/abstractions
	// This defines if the shuttle time is increased or decreased when buying from this vendor
	var/list/shuttle_time_modifiers = list()
	// This defines if the crate cost is increased or decreased when buying from this vendor
	var/list/crate_cost_modifiers = list()

	New(n)
		..()
		name = n
		category = list()
		relationship = list()
		abstractions = list()
		shuttle_time_modifiers = list()
		crate_cost_modifiers = list()

/datum/supplyvendor_manager
	// All the vendors possible to roll
	var/list/all_vendors = list()
	 // The vendors that have rolled
	var/global/list/category_actives = list()
	// List of possible rolled vendors per category
	var/list/category_pools = list()

	catergory_pools = list(
		"Emergency" = list(),
		"Security" = list(),
		"Engineering" = list(),
		"Medical" = list(),
		"Science" = list(),
		"Food and Livestock" = list(),
		"Raw Materials" = list(),
		"Miscellaneous" = list(),
		"Vending" = list(),= list()
	)


	// Utility proc to list active vendors for cargo console

	proc/get_active_names()
		var/list/names = list()
		for(var/vendor in active_vendors)
			names += vendor.name
		return names

	// A proc that connects category and category_pools
		proc/register_vendor(var/datum/supplyvendors/V)
			for(var/cat in V.category)
				if(!(cat in category_pools))
					category_pools[cat] = list()
				category_pools[cat] += V

	/datum/supplyvendor_manager/proc/register_vendor
		var/cat = V.category
		if (!cat) return // Return if theres no category

		if(!(cat in category_pools))
			category_pools[cat] = list()

		category_pools[cat] += V

	proc/roll_category_vendors(amount = 4)
		for(var/category_name in category_pools)
			var/list/pool = category_pools[category_name]
			if (!pool || !pool.len)
				continue // Skips if no pool exists

			var/list/rolled = pool.Copy()
			var/list/results = list()

			for(var/i = 1; i <= amount; i++)
				if(!rolled.len) break //Breaks if no vendors left to roll, which shouldn't happen
			var/idx = rand(1, rolled.len)
			var/vendor = rolled[idx]
			results += vendor
			rolled -= vendor

		category_actives[category_name] = results
