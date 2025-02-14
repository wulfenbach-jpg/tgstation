/mob/living/simple_animal/hostile/skeleton/necromancer
	desc = "The creation of a powerful necromancer."
	faction = list("necromancer")
	mob_size = MOB_SIZE_LARGE // So crusher works on them

/mob/living/simple_animal/hostile/skeleton/necromancer/strong
	desc = "The creation of a powerful necromancer. This one looks a bit tougher."
	maxHealth = 75
	health = 75
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/simple_animal/hostile/skeleton/necromancer/mage
	name = "mage skeleton"
	desc = "A skeleton with a tiny bit more magic put into its revival."
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	maxHealth = 100
	health = 100
	ranged = 1
	ranged_cooldown_time = 40
	melee_damage_lower = 12
	melee_damage_upper = 12
	retreat_distance = 2
	minimum_distance = 1
	light_range = 2
	outfit = /datum/outfit/skelemage
	held_item = /obj/item/nullrod/godhand

/datum/outfit/skelemage
	name = "SkeleMage"
	r_hand = /obj/item/nullrod/godhand

/mob/living/simple_animal/hostile/skeleton/necromancer/mage/OpenFire()
	var/T = get_turf(target)
	if(!isturf(T))
		return
	if(get_dist(src, T) <= 8)
		visible_message("<span class='warning'>[src] raises its hand in the air as red light appears under [target]!</span>")
		ranged_cooldown = world.time + ranged_cooldown_time
		var/list/fire_zone = list()
		for(var/i = 0 to 2)
			playsound(T, 'ModularRail/tomb/sound/stargazer_activate.ogg', 50, 1)
			fire_zone = spiral_range_turfs(i, T) - spiral_range_turfs(i-1, T)
			for(var/turf/open/TC in fire_zone)
				new /obj/effect/temp_visual/cult/turf/floor(TC)
			SLEEP_CHECK_DEATH(1.5, src)
		SLEEP_CHECK_DEATH(2.5, src)
		for(var/i = 0 to 2)
			fire_zone = spiral_range_turfs(i, T) - spiral_range_turfs(i-1, T)
			playsound(T, 'ModularRail/tomb/sound/ark_damage.ogg', 50, TRUE)
			for(var/turf/open/TC in fire_zone)
				new /obj/effect/temp_visual/cult/sparks(TC)
				for(var/mob/living/L in TC)
					if("necromancer" in L.faction)
						continue
					L.adjustFireLoss(15)
					to_chat(L, "<span class='userdanger'>You're hit by a death field!</span>")
			SLEEP_CHECK_DEATH(1.5, src)
