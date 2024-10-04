import garth
import streamlit as st
from getpass import getpass

st.header("Test garmin auth")

with st.sidebar: 
    st.subheader("Garmin Connect Login information")
    email = st.text_input("Email")
    password = st.text_input("Password", type="password")
    date = st.date_input("Choose date for parameters read")

# If there's MFA, you'll be prompted during the login
garth.login(email, password)
garth.save("~/.garth")

st.subheader("User information")
st.write("Connector provider does not work. Cannot access user name etc. See https://github.com/matin/garth/issues/69")

st.subheader("Daily Steps")
steps = garth.DailySteps.list(date,period=1)
st.write(steps)

st.subheader("Intensity Minutes")
st.write("Daily:")
st.write(garth.DailyIntensityMinutes.list(date, period=1))
st.write("Weekly:")
st.write(garth.WeeklyIntensityMinutes.list(date, period=1))

st.subheader("Stress for selected date")
stress = garth.DailyStress.list(date,period=1)
st.write(stress)

st.subheader("Sleep Data")
st.write(garth.SleepData.list(date,1))