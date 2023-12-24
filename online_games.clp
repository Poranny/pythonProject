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
    (assert (message (name "ground-or-space") (question "Fight on the ground or while flying through space?") (answers "Ground" "Flying")))
)

; SHOOTERS FLYING
(defrule fight-place-space
    ?f <- (ground-or-space "Flying")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fight-place-space") (question "Big battles or precise control of your ship?") (answers "Precise control" "Big battles")))
)

(defrule precise-control-result
    ?f <- (fight-place-space "Precise control")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "BATTLESTAR GALACTICA")))
)

(defrule big-battles-result
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
(defrule tank-or-soldiers
    ?f <- (fight-place-ground "Military")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "tank-or-soldiers") (question "Would you see yourself in tank or as a soldier:") (answers "Tank" "Soldier")))
)

(defrule tank-result
    ?f <- (tank-or-soldiers "Tank")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "WORLD OF TANKS")))
)

(defrule soldier-result
    ?f <- (tank-or-soldiers "Soldier")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "LOST SAGA")))
)

; MONSTER PATH
(defrule mummies-or-werewolves
    ?f <- (fight-place-ground "Monsters")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "mummies-or-werewolves") (question "Mummies or Werewolves:") (answers "Mummies" "Werewolves")))
)

(defrule mummies-result
    ?f <- (mummies-or-werewolves "Mummies")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "MISSION AGAINST TERROR")))
)

(defrule werewolves-result
    ?f <- (mummies-or-werewolves "Werewolves")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "WOLF TEAM")))
)




; STRATEGY

(defrule fantasy-historical-real
    ?f <- (genre "STRATEGY")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-historical-real") (question "Would you like fantasy, real world or 'the family'?") (answers "Fantasy" "Historical" "Mafia")))
)

; MAFIA
(defrule family-result
    ?f <- (fantasy-historical-real "Mafia")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "GODFATHER: FIVE FAMILIES")))
)

; FANTASY 
(defrule rpgs-strategy 
        ?f <- (fantasy-historical-real "Fantasy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-strategy") (question "Would you like a game with some RPGS or straight-up strategy?") (answers "RPG elements" "Just strategy")))
)

(defrule some-rpgs-result
    ?f <- (rpgs-strategy "RPG elements")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "CALL OF GODS")))
)

(defrule just-strategy-result
    ?f <- (rpgs-strategy "Just strategy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "GREPOLIS")))
)

; HISTORICAL
(defrule involved-casula 
    ?f <- (fantasy-historical-real "Historical")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "involved-casula") (question "Would you like a game for casual play or more involving?") (answers "Involving" "Casual")))
)

; INVOLVED HISTORICAL
(defrule single-multi 
    ?f <- (involved-casula "Involving")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "single-multi") (question "Would you like a game to play on your own or with friends?") (answers "Solo" "With friends")))
)

(defrule single-result
    ?f <- (single-multi "Solo")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "CASTLE EMPIRE")))
)

(defrule multi-result
    ?f <- (single-multi "With friends")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "TRAVIAN")))
)

; CASUAL HISTORICAL
(defrule realtime-strategic 
    ?f <- (involved-casula "Casual")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "realtime-strategic") (question "Game should be more strategic or real time tactics?") (answers "Real time tactics" "Strategic")))
)

(defrule real-time-tactics-result
    ?f <- (realtime-strategic "Real time tactics")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "1100 AD")))
)

(defrule strategic-result
    ?f <- (realtime-strategic "Strategic")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "TRIBAL WARS")))
)

;VIRTUAL  WORLDS
(defrule buildin-freedom
    ?f <- (genre "VIRTUAL WORLDS")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "buildin-freedom") (question "World with games build in or completely freedom experience?") (answers "Build in games" "Open-ended")))
)

(defrule blocks-legos
    ?f <- (buildin-freedom "Build in games")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "blocks-legos") (question "Which do you prefer to build with: blocks or legos?") (answers "Blocks" "Legos")))
)

(defrule blocks-result
    ?f <- (blocks-legos "Blocks")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "MINECRAFT CLASSIC")))
)

(defrule legos-result
    ?f <- (blocks-legos "Legos")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "ROBLOX")))
)

(defrule chat-create
    ?f <- (buildin-freedom "Open-ended")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "chat-create") (question "Chat and make new friends or do you want to create things?") (answers "Chat" "Create")))
)

(defrule chat-result
    ?f <- (chat-create "Chat")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "IMVU")))
)

(defrule create-result
    ?f <- (chat-create "Create")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "SECOND LIFE")))
)