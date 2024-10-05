# mobileStratGodot
 Trying to create a Godot game. It would be fun to use Garmin metrics to determine resources available!


## First Godot base-building game draft

Tutorial used: https://gamedevacademy.org/godot-strategy-game-tutorial/
Tiles used: https://www.kenney.nl/assets/medieval-rts

## Garmin Data + Google AI
Can read Garmin data with python, pass it to Google AI to get summaries, and display everything in Streamlit - see below

But that is Python, and GDscript cannot use it...
https://forum.godotengine.org/t/use-python-librairies-to-create-a-godot-game/85663
https://www.reddit.com/r/godot/s/TCeHbTxUYe

![image](https://github.com/user-attachments/assets/b5164a09-4562-47ca-ad87-7bea91d58447)

Maybe by scheduling a python script to download data daily in a csv https://help.pythonanywhere.com/pages/ScheduledTasks/ and then read the csv https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html ? Dirtier and not scalable but for concept validation why not.

## Strava api doc
https://developers.strava.com/docs/

