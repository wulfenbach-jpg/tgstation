#define PIN_COMBO "GH"
#define STROKE_COMBO "HH"
#define SLOPPY_COMBO "GG"
#define MAKEOUT_COMBO "DG"
#define LEGLOCK_COMBO "DDH"

/datum/martial_art/cqf
	name = "Close Quarters Femdom"
	id = MARTIALART_CQF
	help_verb = /mob/living/proc/cqf_help
	block_chance = 75
	smashes_tables = TRUE
	display_combos = TRUE
	var/old_grab_state = null
	var/mob/restraining_mob

/datum/martial_art/cqf/teach(mob/living/cqf_user, make_temporary)
	. = ..()
	RegisterSignal(cqf_user, COMSIG_PARENT_ATTACKBY, PROC_REF(on_attackby))

/datum/martial_art/cqf/on_remove(mob/living/cqf_user)
	UnregisterSignal(cqf_user, COMSIG_PARENT_ATTACKBY)
	. = ..()

/datum/martial_art/cqf/reset_streak(mob/living/new_target)
	if(new_target && new_target != restraining_mob)
		restraining_mob = null
	return ..()

/datum/martial_art/cqf/proc/on_attackby(mob/living/cqf_user, obj/item/attack_weapon, mob/attacker, params)
	SIGNAL_HANDLER

	if(!istype(attack_weapon, /obj/item/melee/touch_attack))
		return
	if(!can_use(cqf_user))
		return
	cqf_user.visible_message(
		span_danger("[cqf_user] twists [attacker]'s arm, sending their [attack_weapon] back towards them!"),
		span_userdanger("Making sure to avoid [attacker]'s [attack_weapon], you twist their arm to send it right back at them!"),
	)
	var/obj/item/melee/touch_attack/touch_weapon = attack_weapon
	var/datum/action/cooldown/spell/touch/touch_spell = touch_weapon.spell_which_made_us?.resolve()
	if(!touch_spell)
		return
	INVOKE_ASYNC(touch_spell, TYPE_PROC_REF(/datum/action/cooldown/spell/touch, do_hand_hit), touch_weapon, attacker, attacker)
	return COMPONENT_NO_AFTERATTACK

/datum/martial_art/cqf/proc/check_streak(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(findtext(streak,PIN_COMBO))
		reset_streak()
		return Pin(A,D)
	if(findtext(streak,STROKE_COMBO))
		reset_streak()
		return Stroke(A,D)
	if(findtext(streak,SLOPPY_COMBO))
		reset_streak()
		return Sloppy(A,D)
	if(findtext(streak,MAKEOUT_COMBO))
		reset_streak()
		return Makeout(A,D)
	if(findtext(streak,LEGLOCK_COMBO))
		reset_streak()
		return Leglock(A,D)
	return FALSE

/datum/martial_art/cqf/proc/Pin(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(D.body_position == STANDING_UP)
		D.visible_message(span_danger("[A] pins [D], [A.p_their()] body pressing close to [D.p_them()]."), \
						span_userdanger("You're pinned to the ground by [A]!"), span_hear("You hear the rustling of cloth and the slick sound of flesh-on-flesh!"), null, A)
		to_chat(A, span_danger("You pin [D] to the ground, your thigh rising to lock him against the floor!"))
		playsound(get_turf(A), 'sound/weapons/slam.ogg', 25, TRUE, -1)
		D.Paralyze(12 SECONDS)
		log_combat(A, D, "pinned (CQF)")
		return TRUE
	if(D.body_position == LYING_DOWN && !get_location_accessible(A, list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)))
		D.visible_message(span_danger("[A] mounts [D]'s face, [A.p_their()] [pick("round", "phat", "voluminous", "pillowy", "impressive", "large", "squishy", "jiggly")] [pick("butt", "ass", "globes", "rump")] glomping [D.p_their()] face."), \
						span_userdanger("You feel [A]'s ass covering your mouth!"), span_hear("You hear the rustling of cloth and the slick sound of flesh-on-flesh!"), null, A)
		to_chat(A, span_danger("You mount [D]'s face!"))
		return TRUE
	if(D.body_position == LYING_DOWN && get_location_accessible(A, list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)))
		D.visible_message(span_danger("[A] mounts [D]'s face, [A.p_their()] bare [pick("round", "phat", "voluminous", "pillowy", "impressive", "large", "squishy", "jiggly")] [pick("butt", "ass", "globes", "rump")] glomping [D.p_their()] face."), \
						span_userdanger("You feel [A]'s bare ass covering your mouth! [A.p_their()] tight, puckered hole plants itself so very close to your mouth!"), span_hear("You hear the slick sound of flesh-on-flesh!"), null, A)
		D.add_mood_event("butt", /datum/mood_event/butt)
		to_chat(A, span_danger("You plant your beautiful bare ass on [D]'s face!"))
		return TRUE

/datum/martial_art/cqf/proc/Stroke(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		D.visible_message(span_warning("[A] grabs [D]'s cock, gently yet firmly stroking it!"), \
						span_userdanger("You watch helplessly as [A] fishes out your cock, [A.p_their()] hand grasping the thick, veiny shaft with a gentle, yet sultry grace. [A]'s thumb traces the crown of your drooling cockhead, before [A.p_their()] hand drops down to stroke you, up and down, a steady but effective rhythm."), span_hear("You hear shuffling and a muffled groan!"), null, A)
		to_chat(A, span_danger("You grasp [D]'s thick cock, stroking it, driving [D.p_them()] wild!"))
		D.Stun(10 SECONDS)
		D.emote("moan")
		return TRUE

/datum/martial_art/cqf/proc/Sloppy(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat && D.body_position == LYING_DOWN && A.body_position == LYING_DOWN)
		D.visible_message(span_warning("[A] slips [D]'s cock inside [A.p_their()] mouth, [A.p_their()] lips suctioning around [D]'s shaft."), \
						span_userdanger("You hold back a groan as [A]'s mouth closes around your cock, heat, warmth, and wetness surrounding your cock in a euphoric tunnel of bliss."), span_hear("You hear shuffling and a muffled groan!"), null, A)
		to_chat(A, span_danger("You give [D] some sloppy toppy!"))
		D.Stun(12 SECONDS)
		D.emote("moan")
		return TRUE

/datum/martial_art/cqf/proc/Makeout(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	D.visible_message(span_danger("[A] grabs [D] by the waist, pulling them in for a deep kiss!"), \
					span_userdanger("[A] pulls you in for a deep, passionate kiss!"), span_hear("You hear a sound very similar to mwah!"), COMBAT_MESSAGE_RANGE, A)
	to_chat(A, span_danger("You kiss [D] passionately!"))
	D.adjustStaminaLoss(75)
	playsound(get_turf(A), 'sound/effects/kiss.ogg', 50, TRUE, -1)
	return TRUE

/datum/martial_art/cqf/proc/Leglock(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	D.visible_message(span_danger("[D]'s cock is swallowed inside of [A]'s tight asshole as [A.p_their()] ass wiggles and gyrates on [D]'s lap!"), \
					span_userdanger("[A] slides their ass onto your throbbing cock!"), span_hear("You hear the slick sound of flesh entering flesh!"), COMBAT_MESSAGE_RANGE, A)
	to_chat(A, span_danger("You fuck [D] passionately!"))
	D.Stun(15 SECONDS)
	D.emote("moan")
	A.emote("moan")
	return TRUE

/datum/martial_art/cqf/harm_act(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	add_to_streak("H",D)
	if(check_streak(A,D))
		return TRUE
	var/picked_hit_type = pick("caress", "touch")
	D.visible_message(span_danger("[A] [picked_hit_type]ed [D]!"), \
					span_userdanger("You're [picked_hit_type]ed by [A]!"), span_hear("You hear a soft slide of flesh on flesh!"), COMBAT_MESSAGE_RANGE, A)
	to_chat(A, span_danger("You [picked_hit_type] [D]!"))
	return TRUE

/datum/martial_art/cqf/disarm_act(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	add_to_streak("D",D)
	if(check_streak(A,D))
		return TRUE
	return TRUE

/datum/martial_art/cqf/grab_act(mob/living/A, mob/living/D)
	if(A!=D && can_use(A)) // A!=D prevents grabbing yourself
		add_to_streak("G",D)
		if(check_streak(A,D)) //if a combo is made no grab upgrade is done
			return TRUE
		old_grab_state = A.grab_state
		D.grabbedby(A, 1)
		if(old_grab_state == GRAB_PASSIVE)
			A.setGrabState(GRAB_AGGRESSIVE)
			D.visible_message(span_warning("[A] fondly grabs [D]!"), \
							span_userdanger("You're grabbed fondly by [A]!"), span_hear("You hear sounds of aggressive fondling!"), COMBAT_MESSAGE_RANGE, A)
			to_chat(A, span_danger("You fondly grab [D]!"))
		return TRUE
	else
		return FALSE


/mob/living/proc/cqf_help()
	set name = "Remember the Basics"
	set desc = "You try to remember some of the basics of Close Quarters Femdom."
	set category = "CQF"
	to_chat(usr, "<b><i>You try to remember some of the basics of Close Quarters Femdom</i></b>")

	to_chat(usr, "[span_notice("Pin")]: Grab Punch. Pin a bottom to the ground. If they're already on the ground, plant ass on face.")
	to_chat(usr, "[span_notice("Stroke")]: Punch Punch. Stroke their cock, stuns.")
	to_chat(usr, "[span_notice("Sloppy")]: Grab Grab. Give their cock a little sloppy attention, stuns.")
	to_chat(usr, "[span_notice("Makeout")]: Shove Grab. Decent stamina damage. Mwah.")
	to_chat(usr, "[span_notice("Leglock")]: Shove Shove Punch. Fuck your bottom. Hard.")

	to_chat(usr, "<b><i>In addition, by having your throw mode on when being attacked, you enter an active defense mode where you have a chance to block and sometimes even counter attacks done to you.</i></b>")
