/obj/item/megafauna_perfume
	name = "megafauna perfume"
	desc = "A bottle of exotic reagents that draw megafauna into the area when aerosolized."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"
	var/turf/spawning_turf
	var/megafauna_choice

/obj/item/megafauna_perfume/Initialize(mapload)
	. = ..()
	spawning_turf = locate(rand(1,255), rand(1,255), src.z)
	megafauna_choice = pick(
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/dragon,
		/mob/living/simple_animal/hostile/megafauna/hierophant,
	)

/obj/item/megafauna_perfume/proc/spawn_megafauna(megafauna_choice, turf/spawning_turf)
	new megafauna_choice(spawning_turf)

/obj/item/megafauna_perfume/attack_self(mob/user)
	if(!SSmapping.level_trait(src.z, ZTRAIT_MINING))
		to_chat(user, span_notice("You should probably break it on Lavaland."))
		return
	else
		to_chat(user, span_notice("You shatter the bottle!"))
		playsound(user.loc, 'sound/effects/glassbr1.ogg', 100, TRUE)
		spawn_megafauna()
		qdel(src)
