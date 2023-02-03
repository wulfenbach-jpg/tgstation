/obj/item/storage/backpack/duffelbag/debug_surgery
	name = "alien surgery duffel bag"
	desc = "An alien looking duffel bag for holding surgery tools."
	icon_state = "duffel-abductor"
	inhand_icon_state = "duffel-syndie"

/obj/item/surgical_processor/debug
	name = "debug surgical processor"

/obj/item/surgical_processor/debug/Initialize(mapload)
	. = ..()
	var/list/req_tech_surgeries = subtypesof(/datum/surgery)
	for(var/datum/surgery/beep as anything in req_tech_surgeries) // see surgery.dm for copy and pasted code
		if(initial(beep.requires_tech))
			loaded_surgeries += beep

/obj/item/storage/backpack/duffelbag/debug_surgery/PopulateContents()
	new /obj/item/scalpel/alien(src)
	new /obj/item/hemostat/alien(src)
	new /obj/item/retractor/alien(src)
	new /obj/item/circular_saw/alien(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgicaldrill/alien(src)
	new /obj/item/cautery/alien(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/blood_filter(src)
	new /obj/item/stack/medical/bone_gel/four(src)
	new /obj/item/surgical_processor/debug(src)
