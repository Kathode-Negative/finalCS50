# This is an old Project

I made this for the GD50 game dev course in 2021. 
This explains the rather dry wording and inexperienced design choices i made ("^^)

# original readme:
Final Project
Down the rabbit hole

This game is my final project of CS50's course on Game development, a tower climb platformer.

The inspiration for the overall design comes from Alice in wonderland, except the evil part which for I chose a symbol for death, a dark skull.

The Experience:

When booting up the game you are greeted by the developer Logo and the title screen of the game.


A list of the controls is to be found under the opt (options) Tab, accessible either in the 
main menu or by pressing 'escape' in the play state.


You play as a small rabbit and have to fight against an evil magic skull with your magic attacks and with the help of your little friend Absolem.
               
As you try to jump from platform to platform, the evil minions of the evil skull are homing in on you, trying to hinder your ascension. 
When atop, you are faced by the evil skull itself. 
After defeating the skull you win.
Every time the player dies the map is reset and newly generated the next try, rouge-like style.
Even when winning the player only retains memories.

The game will not save anything!

Inner Workings:

The world is handled with an entity component system, inspired by previous assignments like Mario50 or Legend of Zelda. 

The code also includes the class library used in the other assignments, the knife library and push.

By using an entity component system, the main states contain relatively few lines of code. The bulk of game logic is handled by the entity class and its derivatives.

The main states used are:

the TitleState,
the PlayState,
and the Win and Loose States

other states:

more general game logic:
-OptionsState (containing control instructions and volume controls as well as a means of quitting the game)

-InstructionsState (just displays instructions)

-LoadState(actually useless logic wise as it is a design choice)

-LogoState (used when booting up, to show developer logo)

all of the entity states (too many to list)

As the main game system is modular, all entity information and types are stored in the
entity_def.lua file

Visual and auditory Design:

All assets, except the font (credited in the files), were created by me, the developer.

All image graphics were painted with Aseprite
The music used was made in Garage Band for IOS and Bosca ceoil.
The sounds were produced with Bfxr.


Why the project meets the assignment conditions:

The project is a game fully written in the Love 2D environment.

Presented is a cohesive start to finish experience.

It incorporates 5 main States and 20 entity and miscellaneous states.

The player controls an entity with limited health, which can be harmed by other entities in-game in turn causing the player to die and forcing them to retry.

A definite goal is given in the boss fight at the end of the game and in the monodirectional nature of a tower climb setting.

As stated before, all code, except the imported libraries, has not been copied.
Code which is subject of the course�s classes might bare similarities with code found 
in previous assignments.
