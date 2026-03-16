
 Create the game implementing the rules and its tests
 Setup factories (hello world), hook up to view appear and initialise the game
 Setup the view. 
    - boxes are text fields? Input might be too slow
        - Feed input to presenter
    - add a submit button
        - feed into presenter
        - check game state
            - win, route to good result
            - lose, route to bad result
            - neutral
                - all 3 update view
            - router presents or replaces?
                - let's use replace rather than adding complexity with routing
    - add the time visualization
    - make a snapshot test
    - is it playable?
    - final touch ups?

Notes:
    - Using text fields was cumbersome
    - Skipping presenter test, too much time
    - Routing is not perfect but most of the way there
    

