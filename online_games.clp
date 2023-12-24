(deftemplate message
    (slot name (type STRING))
    (slot question (type STRING))
    (multislot answers (type STRING))
)

(deftemplate online-game
    (slot name (type STRING))
)

; Start
(defrule genre
    =>
    (assert (message (name "genre") (question "What type of game are you looking for?") (answers "SHOOTERS" "RPGS" "STRATEGY" "VIRTUAL WORLDS")))
)


; RPGS
(defrule rpgs-genre
    ?f <- (genre "RPGS")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-genre") (question "What genre would you like? Swords and sorcery, starships, superheroes or something else?") (answers "Fantasy" "Science Fiction" "Superheroes" "Something different")))
)

; RPGS fantasy path
(defrule rpgs-wow
    ?f <- (rpgs-genre "Fantasy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-wow") (question "Have you played World of Warcraft?") (answers "Yes" "No")))
)

; RPGS fantasy wow yes
(defrule fantasy-casual-or-involved
    ?f <- (rpgs-wow "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-casual-or-involved") (question "Are you looking for something casual, or something more involved?") (answers "Casual" "Involved")))
)

; RPGS fantasy wow no
(defrule world-of-warcraft-no
    ?f <- (rpgs-wow "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "World of Warcraft")))
)

; RPGS fantasy casual
(defrule fantasy-intensity
    ?f <- (fantasy-casual-or-involved "Casual")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-intensity") (question "But would you still like the option for more intense play when you have the time for it?") (answers "Yes" "No")))
)

; RPGS fantasy involved
(defrule fantasy-age-digits
    ?f <- (fantasy-casual-or-involved "Involved")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-age-digits") (question "How many digits are in your age?") (answers "1 or not sure" "2 or more")))
)


; RPGS science fiction path
(defrule rpgs-ground-or-space
    ?f <- (rpgs-genre "Science Fiction")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-ground-or-space") (question "Would you like to go on ground-based missions or stick to your spaceship?") (answers "Ground" "Space")))
)

;RPGS sf ground
(defrule rpgs-ground
    ?f <- (rpgs-ground-or-space "Ground")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Star-Trek Online")))
)

; RPGS sf space
(defrule rpgs-space
    ?f <- (rpgs-ground-or-space "Space")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-space") (question "Would you like a game that's easy to pick up, or one that takes some getting used to but is huge, epic and involved?") (answers "Easy" "Epic")))
)

;RPGS sf space easy
(defrule rpgs-space-easy
    ?f <- (rpgs-space "Easy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "DarkOrbit")))
)

;RPGS sf space epic
(defrule rpgs-space-easy
    ?f <- (rpgs-space "Epic")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Eve Online")))
)



; RPGS superheroes
(defrule incredibles-old
    ?f <- (rpgs-genre "Superheroes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "incredibles-old") (question "Are you old enough to remember when The Incredibles came out?") (answers "Yes" "No")))
)

;RPGS superheroes old
(defrule superheroes-old-yes
    ?f <- (incredibles-old "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "DC Universe Online")))
)
;RPGS superheroes not old
(defrule superheroes-old-no
    ?f <- (incredibles-old "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Superhero Squad Online")))
)



; RPGS different
(defrule vampire-hunting-werewolf-strange
    ?f <- (rpgs-genre "Something different")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "vampire-hunting-werewolf-strange") (question "Is being a vampire-hunting werewolf strange enough for you?") (answers "Yes" "No")))
)

;RPGS vampire hunting strange
(defrule vampire-hunting-yes
    ?f <- (vampire-hunting-werewolf-strange "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Bitefight")))
)

;RPGS vampire hunting not strange
(defrule vampire-hunting-no
    ?f <- (vampire-hunting-werewolf-strange "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Glitch")))
)




; SHOOTERS
(defrule ground-or-space
    ?f <- (genre "SHOOTERS")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "ground-or-space") (question "Would you rather fight on the ground or while flying through space?") (answers "Ground" "Flying")))
)

; SHOOTERS FLYING
(defrule fight-place-space
    ?f <- (ground-or-space "Flying")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fight-place-space") (question "What would you choose: Big battles or precise control of your ship?") (answers "Precise control" "Big battles")))
)

(defrule precise-control
    ?f <- (fight-place-space "Precise control")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "BATTLESTAR GALACTICA")))
)

(defrule big-battles
    ?f <- (fight-place-space "Big battles")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "ACE ONLINE")))
)

; SHOOTERS GROUND
(defrule fight-place-ground
    ?f <- (ground-or-space "Ground")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fight-place-ground") (question "Who would you rather fight:") (answers "Monsters" "Military")))
)

; MILITARY PATH
(defrule monsters-or-military
    ?f <- (fight-place-ground "Military")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "monsters-or-military") (question "Would you see yourself in tank or as a soldier:") (answers "Tank" "Soldier")))
)


(defrule tank
    ?f <- (monsters-or-military "Tank")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "WORLD OF TANKS")))
)

(defrule soldier
    ?f <- (monsters-or-military "Soldier")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "LOST SAGA")))
)

; MONSTER PATH
(defrule monsters-or-military
    ?f <- (fight-place-ground "Monsters")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "monsters-or-military") (question "Mummies or Werewolves:") (answers "Mummies" "Werewolves")))
)

(defrule mummies
    ?f <- (monsters-or-military "Mummies")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "MISSION AGAINST TERROR")))
)

(defrule werewolves
    ?f <- (monsters-or-military "Werewolves")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "WOLF TEAM")))
)
