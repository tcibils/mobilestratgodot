# mobileStratGodot
 Trying to create a Godot game. It would be fun to use Garmin metrics to determine resources available!


## First Godot base-building game draft

Tutorial used: https://gamedevacademy.org/godot-strategy-game-tutorial/
Tiles used: https://www.kenney.nl/assets/medieval-rts

## Garmin Data + Google AI
Can read Garmin data with python, pass it to Google AI to get summaries, and display everything in Streamlit - see below

![image](https://github.com/user-attachments/assets/b5164a09-4562-47ca-ad87-7bea91d58447)

But that is Python, and GDscript cannot use it...
https://forum.godotengine.org/t/use-python-librairies-to-create-a-godot-game/85663
https://www.reddit.com/r/godot/s/TCeHbTxUYe

An option could be to use the python library to read data, and self-create and host a REST API by hosting the code on pyhtonanywhere.org or on Raspberry Pi ? That seems possible, quite technical to learn, but building APIs could be a useful skill. For the game demo it will be quicker to use the Strava existing API. https://m.youtube.com/watch?v=iWS9ogMPOI0

## Strava API + Google AI
For the prototype, I will use the Strava API, as it is quite valuable, existing, free and documented. Just get activities between two dates, get ID of activities, and then get that activity type and details.

Google AI is also available with a REST API of course so we are good.

https://developers.strava.com/docs/

