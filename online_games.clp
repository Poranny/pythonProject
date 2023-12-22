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
