import garth
import streamlit as st
import google.generativeai as genai
import os

from getpass import getpass


st.header("Test garmin auth")

with st.sidebar: 
    st.subheader("Garmin Connect Login information")
    email = st.text_input("Email")
    password = st.text_input("Password", type="password")
    st.subheader("Parameters date")
    date = st.date_input("Date")
    st.subheader("Google AI API Key")
    apikey = st.text_input("Key")
    st.write("API key should be obtained from https://aistudio.google.com/app/apikey")

# Lib source : https://github.com/matin/garth
garth.login(email, password)
garth.save("~/.garth")

# AI Tutorial : https://ai.google.dev/gemini-api/docs/quickstart?lang=python
os.environ['GOOGLE_API_KEY'] = apikey
genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
model = genai.GenerativeModel("gemini-1.5-flash")


# Garth requests
steps = garth.DailySteps.list(date,period=1)
dailyIntensity = garth.DailyIntensityMinutes.list(date, period=1)
weeklyIntensity = garth.WeeklyIntensityMinutes.list(date, period=1)
stress = garth.DailyStress.list(date,period=1)
sleep = garth.SleepData.list(date,1)

st.subheader("Google AI Day Summary")
requestText = "On the day " + str(date) + ", I walked a total of " + str(steps[0].total_steps) + ", so around " + str(steps[0].total_distance) + " meters, while my daily objective is to walk around " + str(steps[0].step_goal) + " steps." + "I also did " + str(dailyIntensity[0].moderate_value) + " minutes of intensive effort, and my weekly goal is " + str(dailyIntensity[0].weekly_goal) + " minutes of intensive effort. Please provide me with a small summary of how productive my day was. Your text should express distances in km."

response = model.generate_content(requestText)

st.write(response.text)

st.subheader("Daily Steps")
st.write(steps)
st.write("Isolation of the number of total steps that day: " + str(steps[0].total_steps))

st.subheader("Intensity Minutes")
st.write("Daily:")
st.write(dailyIntensity)
st.write("Weekly:")
st.write(weeklyIntensity)

st.subheader("Stress for selected date")
st.write(stress)

st.subheader("User information")
st.write("Connector provider does not work. Cannot access user name etc. See https://github.com/matin/garth/issues/69")

st.subheader("Sleep Data")
st.write(sleep)