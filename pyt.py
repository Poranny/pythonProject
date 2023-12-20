import os

import clips


def addGames(env):
    env.assert_string('(Game (title "Gra1") (genre "RPG") (platform "XBOX") (multiplayer "multi"))')
    env.assert_string('(Game (title "Gra2") (genre "RPG") (platform "PS") (multiplayer "single"))')
    env.assert_string('(Game (title "Gra3") (genre "RPG") (platform "PC") (multiplayer "multi"))')
    env.assert_string('(Game (title "Gra4") (genre "FPS") (platform "XBOX") (multiplayer "single"))')


def main():
    environment = clips.Environment()
    environment.clear()

    print(os.path.abspath(os.getcwd()) + r"\clp.clp")

    environment.load(os.path.abspath(os.getcwd()) + r"\clp.clp")


    user_genre = input("Jaki gatunek gier preferujesz? (np. RPG, FPS): ")
    user_platform = input("Na jakiej platformie chciałbyś grać? (np. PC, XBOX, PS): ")
    user_multiplayer = input("Czy wolisz gry singleplayer czy multiplayer? (wpisz 'single' lub 'multi'): ")

    user_preferences = f'(UserPreferences (preferred_genre "{user_genre}") ' \
                       f'(preferred_platform "{user_platform}") ' \
                       f'(preferred_multiplayer "{user_multiplayer}"))'

    environment.assert_string(user_preferences)
    addGames(environment)

    environment.run()

   # for fact in environment.facts():
   #     print(fact)


if __name__ == "__main__":
    main()
