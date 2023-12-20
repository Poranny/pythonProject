(deftemplate UserPreferences
    (slot preferred_genre)
    (slot preferred_platform)
    (slot preferred_multiplayer))

(deftemplate Game
    (slot title)
    (slot genre)
    (slot platform)
    (slot multiplayer))

(defrule recommend-game
   (UserPreferences (preferred_genre ?genre)
                    (preferred_platform ?platform)
                    (preferred_multiplayer ?multiplayer))
   (Game (title ?title) (genre ?genre) (platform ?platform) (multiplayer ?multiplayer))
   =>
   (printout t "Polecam grę: " ?title crlf))
