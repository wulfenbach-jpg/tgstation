// don't produce a comment if the dice has less than this many sides
// so you don't have d1's and d4's constantly producing comments
#define MIN_SIDES_ALERT 5

///holding bag for dice
/obj/item/storage/dice
	name = "bag of dice"
	desc = "Contains all the luck you'll ever need."
	icon = 'icons/obj/toys/dice.dmi'
	icon_state = "dicebag"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/dice/Initialize(mapload)
	. = ..()
	atom_storage.allow_quick_gather = TRUE
	atom_storage.set_holdable(list(/obj/item/dice))

/obj/item/storage/dice/PopulateContents()
	new /obj/item/dice/d4(src)
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d8(src)
	new /obj/item/dice/d10(src)
	new /obj/item/dice/d12(src)
	new /obj/item/dice/d20(src)
	var/picked = pick(list(
		/obj/item/dice/d1,
		/obj/item/dice/d2,
		/obj/item/dice/fudge,
		/obj/item/dice/d6/space,
		/obj/item/dice/d00,
		/obj/item/dice/eightbd20,
		/obj/item/dice/fourdd6,
		/obj/item/dice/d100,
	))
	new picked(src)

/obj/item/storage/dice/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is gambling with death! It looks like [user.p_theyre()] trying to commit suicide!"))
	return OXYLOSS

/obj/item/storage/dice/hazard

/obj/item/storage/dice/hazard/PopulateContents()
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d6(src)
	for(var/i in 1 to 2)
		if(prob(7))
			new /obj/item/dice/d6/ebony(src)
		else
			new /obj/item/dice/d6(src)

///this is a prototype for dice, for a real d6 use "/obj/item/dice/d6"
/obj/item/dice
	name = "die"
	desc = "A die with six sides. Basic and serviceable."
	icon = 'icons/obj/toys/dice.dmi'
	icon_state = "d6"
	w_class = WEIGHT_CLASS_TINY
	var/sides = 6
	var/result = null
	var/list/special_faces = list() //entries should match up to sides var if used
	var/microwave_riggable = TRUE

	var/rigged = DICE_NOT_RIGGED
	var/rigged_value

/obj/item/dice/Initialize(mapload)
	. = ..()
	if(!result)
		result = roll(sides)
	update_appearance()

/obj/item/dice/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is gambling with death! It looks like [user.p_theyre()] trying to commit suicide!"))
	return OXYLOSS

/obj/item/dice/d1
	name = "d1"
	desc = "A die with only one side. Deterministic!"
	icon_state = "d1"
	sides = 1

/obj/item/dice/d2
	name = "d2"
	desc = "A die with two sides. Coins are undignified!"
	icon_state = "d2"
	sides = 2

/obj/item/dice/d4
	name = "d4"
	desc = "A die with four sides. The nerd's caltrop."
	icon_state = "d4"
	sides = 4

/obj/item/dice/d4/Initialize(mapload)
	. = ..()
	// 1d4 damage
	AddComponent(/datum/component/caltrop, min_damage = 1, max_damage = 4)

/obj/item/dice/d6
	name = "d6"

/obj/item/dice/d6/ebony
	name = "ebony die"
	desc = "A die with six sides made of dense black wood. It feels cold and heavy in your hand."
	icon_state = "de6"
	microwave_riggable = FALSE // You can't melt wood in the microwave

/obj/item/dice/d6/space
	name = "space cube"
	desc = "A die with six sides. 6 TIMES 255 TIMES 255 TILE TOTAL EXISTENCE, SQUARE YOUR MIND OF EDUCATED STUPID: 2 DOES NOT EXIST."
	icon_state = "spaced6"

/obj/item/dice/d6/space/Initialize(mapload)
	. = ..()
	if(prob(10))
		name = "spess cube"

/obj/item/paper/guides/knucklebone
	name = "knucklebones rules"
	default_raw_text = "How to play knucklebones<br>\
	<ul>\
	<li>Make two 3x3 grids right next to eachother using anything you can find to mark the ground. I like using the bartenders hologram projector.</li>\
	<li>Take turns rolling the dice and moving the dice into one of the three rows on your 3x3 grid.</li>\
	<li>Your goal is to get the most points by putting die of the same number in the same row.</li>\
	<li>If you have two of the same die in the same row, you will add them together and then times the sum by two. Then add that to the rest of the die.</li>\
	<li>If you have three of the same die in the same row, you will do the same thing but times it by three.</li>\
	<li>But if your opponent places a die across from one of your rows, you must remove all die that are the same number.</li>\
	<li>For example, if you have two 5's and a 2 in a row and your opponent places a 5 in the same row you must remove the two 5's from that row.</li>\
	<li>Note that you do not multiply the die if they are in the same collum. Only if they are in the same row.</li>\
	<li>If you find it hard to tell whether it multiplies up and down or left and right, base it off the position of your opponents 3x3.</li>\
	<li>If their rows line up with your rows, those rows are the rows that will multiply your die</li>\
	<li>The game ends when one person fills up their 3x3. The other person does not get to roll the rest of their die.</li>\
	<li>The winner is decided by who gets the most points</li>\
	<li>Have fun!</li>\
	</ul>"
/obj/item/dice/fudge
	name = "fudge die"
	desc = "A die with six sides but only three results. Is this a plus or a minus? Your mind is drawing a blank..."
	sides = 3 //shhh
	icon_state = "fudge"
	special_faces = list("minus","blank" = "You aren't sure how to feel.","plus")

/obj/item/dice/d8
	name = "d8"
	desc = "A die with eight sides. It feels... lucky."
	icon_state = "d8"
	sides = 8

/obj/item/dice/d10
	name = "d10"
	desc = "A die with ten sides. Useful for percentages."
	icon_state = "d10"
	sides = 10

/obj/item/dice/d00
	name = "d00"
	desc = "A die with ten sides. Works better for d100 rolls than a golf ball."
	icon_state = "d00"
	sides = 10

/obj/item/dice/d00/manipulate_result(original)
	return (original - 1)*10  // 10, 20, 30, etc

/obj/item/dice/d12
	name = "d12"
	desc = "A die with twelve sides. There's an air of neglect about it."
	icon_state = "d12"
	sides = 12

/obj/item/dice/d20
	name = "d20"
	desc = "A die with twenty sides. The preferred die to throw at the GM."
	icon_state = "d20"
	sides = 20

/obj/item/dice/d100
	name = "d100"
	desc = "A die with one hundred sides! Probably not fairly weighted..."
	icon_state = "d100"
	w_class = WEIGHT_CLASS_SMALL
	sides = 100

/obj/item/dice/d100/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/dice/eightbd20
	name = "strange d20"
	desc = "A weird die with raised text printed on the faces. Everything's white on white so reading it is a struggle. What poor design!"
	icon_state = "8bd20"
	sides = 20
	special_faces = list("It is certain","It is decidedly so","Without a doubt","Yes, definitely","You may rely on it","As I see it, yes","Most likely","Outlook good","Yes","Signs point to yes","Reply hazy try again","Ask again later","Better not tell you now","Cannot predict now","Concentrate and ask again","Don't count on it","My reply is no","My sources say no","Outlook not so good","Very doubtful")

/obj/item/dice/eightbd20/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/dice/fourdd6
	name = "4d d6"
	desc = "A die that exists in four dimensional space. Properly interpreting them can only be done with the help of a mathematician, a physicist, and a priest."
	icon_state = "4dd6"
	sides = 48
	special_faces = list("Cube-Side: 1-1","Cube-Side: 1-2","Cube-Side: 1-3","Cube-Side: 1-4","Cube-Side: 1-5","Cube-Side: 1-6","Cube-Side: 2-1","Cube-Side: 2-2","Cube-Side: 2-3","Cube-Side: 2-4","Cube-Side: 2-5","Cube-Side: 2-6","Cube-Side: 3-1","Cube-Side: 3-2","Cube-Side: 3-3","Cube-Side: 3-4","Cube-Side: 3-5","Cube-Side: 3-6","Cube-Side: 4-1","Cube-Side: 4-2","Cube-Side: 4-3","Cube-Side: 4-4","Cube-Side: 4-5","Cube-Side: 4-6","Cube-Side: 5-1","Cube-Side: 5-2","Cube-Side: 5-3","Cube-Side: 5-4","Cube-Side: 5-5","Cube-Side: 5-6","Cube-Side: 6-1","Cube-Side: 6-2","Cube-Side: 6-3","Cube-Side: 6-4","Cube-Side: 6-5","Cube-Side: 6-6","Cube-Side: 7-1","Cube-Side: 7-2","Cube-Side: 7-3","Cube-Side: 7-4","Cube-Side: 7-5","Cube-Side: 7-6","Cube-Side: 8-1","Cube-Side: 8-2","Cube-Side: 8-3","Cube-Side: 8-4","Cube-Side: 8-5","Cube-Side: 8-6")

/obj/item/dice/fourdd6/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/dice/attack_self(mob/user)
	diceroll(user)

/obj/item/dice/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/mob/thrown_by = thrownby?.resolve()
	if(thrown_by)
		diceroll(thrown_by)
	return ..()

/obj/item/dice/proc/diceroll(mob/user)
	result = roll(sides)
	if(rigged != DICE_NOT_RIGGED && result != rigged_value)
		if(rigged == DICE_BASICALLY_RIGGED && prob(clamp(1/(sides - 1) * 100, 25, 80)))
			result = rigged_value
		else if(rigged == DICE_TOTALLY_RIGGED)
			result = rigged_value

	. = result

	var/fake_result = roll(sides)//Daredevil isn't as good as he used to be
	var/comment = ""
	if(sides > MIN_SIDES_ALERT && result == 1)  // less comment spam
		comment = "Ouch, bad luck."
	if(sides == 20 && result == 20)
		comment = "NAT 20!"  // maint wanted this hardcoded to nat20 don't blame me
	update_appearance()
	result = manipulate_result(result)
	if(special_faces.len == sides)
		comment = ""  // its not a number
		result = special_faces[result]
		if(!ISINTEGER(result))
			comment = special_faces[result]  // should be a str now

	if(user != null) //Dice was rolled in someone's hand
		user.visible_message(span_notice("[user] throws [src]. It lands on [result]. [comment]"), \
			span_notice("You throw [src]. It lands on [result]. [comment]"), \
			span_hear("You hear [src] rolling, it sounds like a [fake_result]."))
	else if(!src.throwing) //Dice was thrown and is coming to rest
		visible_message(span_notice("[src] rolls to a stop, landing on [result]. [comment]"))

/obj/item/dice/update_overlays()
	. = ..()
	. += "[icon_state]-[result]"

/obj/item/dice/microwave_act(obj/machinery/microwave/microwave_source, mob/microwaver, randomize_pixel_offset)
	if(microwave_riggable)
		rigged = DICE_BASICALLY_RIGGED
		rigged_value = result

	return ..() | COMPONENT_MICROWAVE_SUCCESS

/// A proc to modify the displayed result. (Does not affect what the icon_state is passed.)
/obj/item/dice/proc/manipulate_result(original)
	return original
