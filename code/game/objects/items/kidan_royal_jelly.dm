// A 70 tc, royal jelly that gives them some busted moves, but with some heavy drawbacks.
/obj/item/kidan_royal_jelly
	name = "Kidan Royal Jelly"
	desc = "This Jelly is viscous, and leaves you feeling uneasy. You get the sense that drinking this will create an irreversible change."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "kidan_royal_jelly"
	uses = 1


/obj/item/kidan_royal_jelly/proc/eatjelly
	if(..())
		return
	if(HAS_TRAIT(user, TRAIT_KIDAN_JELLY))
		to_chat(user, "<span class='warning'>You've already eaten Kidan Royal Jelly!</span>")
		return
	if(user.mind && (IS_CHANGELING(user) || user.mind.has_antag_datum(/datum/antagonist/vampire)) || user.dna?.species.name != "Kidan")
		to_chat(user, "<span class='warning'>The jelly is not compatable with your biology!</span>")
		return
	if(used)
		to_chat(user, "<span class='notice'>The jar is empty!</span>")
		return
	var/choice = tgui_alert(user, "There's jelly in the jar. Would you like to consume it?", "Kidan Royal Jelly", list("Yes", "No"))
	if(choice != "Yes")
		to_chat(user, "<span class='notice'>You decide against drinking [src].</span>")
		return
	if(used)
		to_chat(user, "<span class='warning'>The jar is empty!</span>")
		return
	used = TRUE
	to_chat(user, "<span class='notice'>You consume the Kidan Royal Jelly!</span>")
	mind.AddSpell (/datum/spell/kidan_rush, /datum/spell/overbearing_punch, /datum/spell/kidan_heatbutt, /datum/spell/go_all_out)

/datum/spell/kidan_rush




/datum/spell/overbearing_punch

/datum/spell/kidan_heatbutt

/datum/spell/go_all_out
