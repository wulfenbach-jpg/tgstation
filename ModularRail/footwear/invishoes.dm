/obj/item/clothing/shoes/invisiboots
	name = "light-warping invisifibre"
	desc = "A set of entirely transparent, thin coverings for your feet."
	icon_state = "invisi"
	clothing_traits = list(TRAIT_SILENT_FOOTSTEPS)

/obj/item/clothing/shoes/invisiboots/Initialize(mapload)
	. = ..()
	var/static/list/bare_footstep_sounds = list(
		'sound/effects/footstep/hardbarefoot1.ogg' = 1,
		'sound/effects/footstep/hardbarefoot2.ogg' = 1,
		'sound/effects/footstep/hardbarefoot3.ogg' = 1,
		'sound/effects/footstep/hardbarefoot4.ogg' = 1,
		'sound/effects/footstep/hardbarefoot5.ogg' = 1)

	AddComponent(/datum/component/squeak, bare_footstep_sounds, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)
