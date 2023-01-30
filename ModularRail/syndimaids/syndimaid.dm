/obj/item/clothing/gloves/syndimaid_arms_fake
	name = "combat maid sleeves"
	desc = "Gloves attached to cylindrical tubes that cover your arms. They don't feel very high quality."
	icon = 'ModularRail/syndimaids/syndimaid.dmi'
	worn_icon = 'ModularRail/syndimaids/syndimaid_mob.dmi'
	icon_state = "syndimaid_arms"

/obj/item/clothing/gloves/syndimaid_arms
	name = "combat maid sleeves"
	desc = "These tactical gloves and sleeves for the Syndicate-ly servile are fireproof and electrically insulated. Warm to boot."
	icon = 'ModularRail/syndimaids/syndimaid.dmi'
	worn_icon = 'ModularRail/syndimaids/syndimaid_mob.dmi'
	icon_state = "syndimaid_arms"
	siemens_coefficient = 0
	strip_delay = 80
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/syndimaid_arms

/datum/armor/syndimaid_arms
	melee = 5
	laser = 5
	bio = 90
	fire = 80
	acid = 50

/obj/item/clothing/head/costume/syndieheadband
	name = "Tactical maid headband"
	desc = "Tacticute."
	icon = 'ModularRail/syndimaids/syndimaid.dmi'
	worn_icon = 'ModularRail/syndimaids/syndimaid_mob.dmi'
	icon_state = "syndieheadband"

/obj/item/clothing/head/costume/syndieheadband/fake
	name = "tactical maid headband"
	desc = "Hey! This is just a normal maid headband dyed red! You feel like you've been scammed."

/obj/item/clothing/accessory/maidapronsynd
	name = "tactical maid apron"
	desc = "Useful? Not really. Cute? Definitely is. On the inner tag, the words Rail Inc. stand out."
	icon = 'ModularRail/syndimaids/syndimaid.dmi'
	worn_icon = 'ModularRail/syndimaids/syndimaid_mob.dmi'
	icon_state = "maidapronsynd"
	armor_type = /datum/armor/maidapronsynd

/datum/armor/maidapronsynd
	melee = 10

/obj/item/clothing/under/syndicate/syndimaid
	name = "tactical maid outfit"
	desc = "The Syndicate's cutting-edge armor technology fashioned into the likeness of a... maid outfit. Whatever suits your fancy, I suppose."
	icon = 'ModularRail/syndimaids/syndimaid.dmi'
	worn_icon = 'ModularRail/syndimaids/syndimaid_mob.dmi'
	icon_state = "syndimaid"
	has_sensor = NO_SENSORS
	can_adjust = FALSE
	armor_type = /datum/armor/syndimaid

/datum/armor/syndimaid
	melee = 10
	bullet = 10
	laser = 10
	energy = 10
	bio = 10
	fire = 65
	acid = 65

/obj/item/clothing/under/syndicate/syndimaid/fake
	desc = "Tailored into the appearance of Syndicate's finest maids, assistants make these costumes to commemmorate the numerous times Nanotrasen waged and won against the treacherous kitties of the Syndicate. It doesn't seem very protective."
	has_sensor = HAS_SENSORS
	armor_type = null
