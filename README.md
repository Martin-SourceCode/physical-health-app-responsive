Physical Health App Responsive
--------------------------------------

This contains the code developed by Interneuron CIC for NHS Digital and Janssen

Deployment Instructions
-----------------------

--Create database
Create a health_appstore database in PostgresSQL 9.6 or greater

--Run Database Object Creation Script
Run the health_appstore.sql file in the health_appstore directory


--Edit Web.Config
Update connection string in web.config to reflect your postgressql settings

--Deploy Website to IIS / Azure
Deploy Solution to IIS / Azure



--Update System Settings
------------------------
UPDATE public.systemsetup
SET 
siteurl = 'siteurl', 
emailhost = 'emailhost', 
emailuser = 'emailuser', -- must be valid email address or will site will crash
emailpassword = 'emailpassword',
emailport = 'emailport', 
emailusetls = false, 
emailfromaddress = 'emailfromaddress', 
emailfromname = 'emailfromname', 
cliniciantermsandconditions = 'cliniciantermsandconditions', 
patienttermsandconditions = 'patienttermsandconditions'
WHERE systemsetupid = 1


--Create Organisations
----------------------
INSERT INTO public.app_organisation(organisationname) VALUES ('My Organisation Name')


--Create Test Types
INSERT INTO public.app_testtype(testtypename, lowerreferencerange, upperreferencerange, unitstext) VALUES ('Fasting Glucose', 3.9 , 5.5, 'mg/dl');

--Register Super Users
----------------------

Access siteurl//RegisterAsSuperUser.aspx


Return to login page and register as a clinician

Confirm your account from the email you receive

Return to login page and login with the super user credentials you created

Select the Clinician you created from the  New User Requests work list and authorise the account

You can now log out and log back in as the clinician you created

You will now be able to register as a patient and authorise their request
