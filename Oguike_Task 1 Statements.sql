--Creation of Database
USE master;
GO
CREATE DATABASE ChildMonitor;

--Creation of Schema's
CREATE SCHEMA ChildMonitor;

CREATE SCHEMA Ethiopia;

CREATE SCHEMA India;

CREATE SCHEMA Peru;

CREATE SCHEMA Vietnam;


--Data Processing and Creation of Tables

--Ethiopia Table Transformation

SELECT
childid 'ChildID',

iif(yc=0,'Older Cohort','Younger Cohort') 'Cohort',

[round] 'Round_of_Survey',

iif(inround=0,'No','Yes') 'Attended_Round',

iif(panel=0,'No','Yes') 'Attended_All_Rounds',

iif(deceased=1,'Yes','No') 'Deceased',

 cast(dint as date) 'Date of interview',

 commid 'CommunityID',

 clustid 'Sentinel_SiteID',

 	case
		when region=1 then replace(region, 1,'Tigray')
		when region=2 then replace(region, 2,'Afar')
		when region=3 then replace(region, 3,'Amhara')
		when region=4 then replace(region, 4,'Oromiya')
		when region=5 then replace(region, 5,'Somali')
		when region=6 then replace(region, 6,'Benshangul Gumz')
		when region=7 then replace(region, 7,'SNNP')
		when region=12 then replace(region, 12,'Gambela')
		when region=13 then replace(region, 13,'Harari')
		when region=14 then replace(region, 14,'Addis Ababa City Admin')
		when region=15 then replace(region, 15,'Dire Dawa City Admin')
		
	else
		null
	end		'Residential_Region',

iif(typesite=1,'Urban',iif(typesite=2,'Rural',null)) 'Residential_Area',

iif(childloc=0,'No',iif(childloc=1,'Yes',null)) 'Currently_Lives_in_Household',

iif(chsex=1,'Male', iif(chsex=2,'Female', cast(chsex as nvarchar))) 'Gender',

case
		when chlang = 1 then replace(chlang, 1, 'Afarigna')
		when chlang = 2 then replace(chlang, 2, 'Amarigna')
		when chlang = 3 then replace(chlang, 3, 'Agewigna')
		when chlang = 4 then replace(chlang, 4, 'Dawerogna')
		when chlang = 5 then replace(chlang, 5, 'Gedeogna')
		when chlang = 6 then replace(chlang, 6, 'Guraghigna')
		when chlang = 7 then replace(chlang, 7, 'Hadiyigna')
		when chlang = 8 then replace(chlang, 8, 'Harari')
		when chlang = 9 then replace(chlang, 9, 'Kefigna')
		when chlang = 10 then replace(chlang, 10, 'Kembategna')
		when chlang = 11 then replace(chlang, 11, 'Oromifa')
		when chlang = 12 then replace(chlang, 12, 'Sidamigna')
		when chlang = 13 then replace(chlang, 13, 'Siltigna')
		when chlang = 14 then replace(chlang, 14, 'Somaligna')
		when chlang = 15 then replace(chlang, 15, 'Tigrigna')
		when chlang = 16 then replace(chlang, 16, 'Welayitegna')
		when chlang = 17 then replace(chlang, 17, 'Zayigna')
		when chlang = 20 then replace(chlang, 20, 'Other')
		when chlang = 88 then replace(chlang, 88, 'N/A')
		when chlang = 79 then replace(chlang, 79, 'Refused to answer')
		when chlang = 99 then replace(chlang, 99, 'Missing')
		when chlang = 77 then replace(chlang, 77, 'NK')
	else
		cast(chlang as nvarchar)
	end
	as 'First_language',

case
		when chethnic = 99 then replace(chethnic, 99, 'NK')
		when chethnic = 10 then replace(chethnic, 10, 'Other')
		when chethnic = 11 then replace(chethnic, 11, 'Agew')
		when chethnic = 12 then replace(chethnic, 12, 'Amhara')
		when chethnic = 13 then replace(chethnic, 13, 'Gurage')
		when chethnic = 14 then replace(chethnic, 14, 'Hadiva')
		when chethnic = 15 then replace(chethnic, 15, 'Kambata')
		when chethnic = 16 then replace(chethnic, 16, 'Oromo')
		when chethnic = 17 then replace(chethnic, 17, 'Sidama')
		when chethnic = 18 then replace(chethnic, 18, 'Tigrian')
		when chethnic = 19 then replace(chethnic, 19, 'Wolavta')
	else
		null
	end
	 as 'Ethnic_Group',

case
	when chldrel = 1 then replace(chldrel, 1, 'Christian')
	when chldrel = 2 then replace(chldrel, 2, 'Muslim')
	when chldrel = 3 then replace(chldrel, 3, 'Buddhist')
	when chldrel = 4 then replace(chldrel, 4, 'Hindu')
	when chldrel = 5 then replace(chldrel, 5, 'Catholic')
	when chldrel = 6 then replace(chldrel, 6, 'Protestant')
	when chldrel = 7 then replace(chldrel, 7, 'Orthodox')
	when chldrel = 8 then replace(chldrel, 8, 'Sikh')
	when chldrel = 9 then replace(chldrel, 9, 'Evangelist')
	when chldrel = 10 then replace(chldrel, 10, 'Mormon')
	when chldrel = 11 then replace(chldrel, 11, 'Ancestor Worship')
	when chldrel = 12 then replace(chldrel, 12, 'Hao Hao')
	when chldrel = 13 then replace(chldrel, 13, 'Cao Dai')
	when chldrel = 14 then replace(chldrel, 14, 'None')
	when chldrel = 15 then replace(chldrel, 15, 'Other')
	when chldrel = 99 then replace(chldrel, 99, 'NK')

ELSE NULL
END
	AS 'Religion',

agemon 'Age',

iif(marrcohab=0, 'No', 'Yes') as 'Has_Ever_Married/Cohabited',

iif(marrcohab_age>1,marrcohab_age, null) 'Age at Marriage/Cohabitation',

iif(birth=0, 'No', 'Yes') as 'Has_a_Child',

iif(bcg=0, 'No', 'Yes') as 'BCG Vaccination',

iif(measles=0, 'No', 'Yes') as 'Measles Vaccination',

iif(dpt=0, 'No', 'Yes') as 'DPT Vaccination',

iif(polio=0, 'No', 'Yes') as 'Polio Vaccination',

iif(hib=0, 'No', 'Yes') as 'HIB Vaccination',

iif(chillness=0, 'No','Yes') 'Serious_Illness_Since_Last_round',

iif(chinjury=0, 'No','Yes') 'Serious_injury_since_last_round',

iif(chhprob=0, 'No','Yes') 'Long-term_Health_Problem',

iif(chdisability=0, 'No','Yes') 'Permanent_Disability',

case
	when chsmoke = 1 then replace(chsmoke, 1, 'Every day')
	when chsmoke = 2 then replace(chsmoke, 2, 'At least once a week')
	when chsmoke = 3 then replace(chsmoke, 3, 'At least once a month')
	when chsmoke = 4 then replace(chsmoke, 4, 'Hardly ever')
	when chsmoke = ' ' then replace(chsmoke,' ', 'None')
else
	replace(chsmoke, 5, 'None')
end as 'Frequency of Smoking',

iif(chalcohol=0, 'No','Yes') 'Consumes Alcohol Weekly',

case
	when chhrel=1 then replace(chhrel,1,'Same')
	when chhrel=2 then replace(chhrel,2,'Better')
	when chhrel=3 then replace(chhrel,3,'Worse')
else
	null
end as 'Health_vs_Peers',

case
	when chhealth=1 then replace(chhealth,1,'Very Poor')
	when chhealth=2 then replace(chhealth,2,'Poor')
	when chhealth=3 then replace(chhealth,3,'Average')
	when chhealth=4 then replace(chhealth,4,'Good')
	when chhealth=5 then replace(chhealth,5,'Very Good')
else
	null
end as 'Health_Condition',

iif(cladder>1,cladder,null) 'Well-being(9-step Ladder)',

hsleep 'Sleeping',

hcare 'Caring_for_family',

hchore 'Chores',

htask 'Domestic_Tasks',

hwork 'Paid_Activity',

hschool 'School',

hstudy 'Studying',

hplay 'Leisure_Activities',

iif(commwork>0,commwork,null) 'Work CommuteTo&Fro(in mins)',

iif(commsch>0,commsch,null) 'School CommuteTo&Fro(in mins)',

iif(preprim=0,'No',iif(preprim=1,'Yes', null)) 'Pre-primary_School',

agegr1 'Age_@Grade1',

case
	when enrol=0 then replace(enrol,0,'No')
	when enrol=1 then replace(enrol,1,'Yes')
	when enrol=99 then replace(enrol,99,'Missing')
	when enrol=77 then replace(enrol,77,'NK')
	when enrol=88 then replace(enrol,88,'N/A')
else
	null
end as 'Currently_Enrolled',

case
	when engrade=0 then replace(engrade,0,'None')
	when engrade=1 then replace(engrade,1,'Grade 01')
	when engrade=2 then replace(engrade,2,'Grade 02')
	when engrade=3 then replace(engrade,3,'Grade 03')
	when engrade=4 then replace(engrade,4,'Grade 04')
	when engrade=5 then replace(engrade,5,'Grade 05')
	when engrade=6 then replace(engrade,6,'Grade 06')
	when engrade=7 then replace(engrade,7,'Grade 07')
	when engrade=8 then replace(engrade,8,'Grade 08')
	when engrade=9 then replace(engrade,9,'Grade 09')
	when engrade=10 then replace(engrade,10,'Grade 10')
	when engrade=11 then replace(engrade,11,'Grade 11')
	when engrade=12 then replace(engrade,12,'Grade 12')
	when engrade=13 then replace(engrade,13,'First cycle primary teaching(1st Year)')
	when engrade=14 then replace(engrade,14,'First cycle primary teaching(2nd Year)')
	when engrade=16 then replace(engrade,16,'Second cycle of primary teaching(2nd Year)')
	when engrade=17 then replace(engrade,17,'Second cycle of primary teaching(1st Year)')
	when engrade=21 then replace(engrade,21,'TVET/1st year/level')
	when engrade=22 then replace(engrade,22,'TVET/2nd year/level')
	when engrade=23 then replace(engrade,23,'TVET/3rd year/level')
	when engrade=24 then replace(engrade,24,'TVET/4th year/level')
	when engrade=25 then replace(engrade,25,'Secondary Education Diploma 1')
	when engrade=26 then replace(engrade,26,'Secondary Education Diploma 2')
	when engrade=27 then replace(engrade,27,'Secondary Education Degree 1')
	when engrade=28 then replace(engrade,28,'Secondary Education Degree 2')
	when engrade=29 then replace(engrade,29,'Secondary Education Degree 3')
	when engrade=31 then replace(engrade,31,'Preschool Teacher Certificate')
	when engrade=32 then replace(engrade,32,'Undergraduate degree 1st year,R')
	when engrade=33 then replace(engrade,33,'Undergraduate degree 2nd year,R')
	when engrade=34 then replace(engrade,34,'Undergraduate degree 3rd year,R')
	when engrade=35 then replace(engrade,35,'Undergraduate degree 4th year,R')
	when engrade=36 then replace(engrade,36,'Undergraduate degree 1st year,NR')
	when engrade=37 then replace(engrade,37,'Undergraduate degree 2nd year,NR')
	when engrade=38 then replace(engrade,38,'Undergraduate degree 3rd year,NR')
	when engrade=39 then replace(engrade,39,'Undergraduate degree 4th year,NR')
	when engrade=40 then replace(engrade,40,'Masters or doctoral at university')
	when engrade=41 then replace(engrade,41,'Others')
	when engrade=77 then replace(engrade,77,'Not Known')
	when engrade=79 then replace(engrade,79,'Refused to answer')
	when engrade=88 then replace(engrade,88,'N/A')
	when engrade=100 then replace(engrade,100,'Pre-primary')
else
	null
end as 'Current_Grade',

case
	when entype=1 then replace(entype,1,'Private')
	when entype=2 then replace(entype,2,'Public(Partly Govt-Funded')
	when entype=3 then replace(entype,3,'Community(NGO/Charity/Religious)')
	when entype=4 then replace(entype,4,'Govt funded')
	when entype=5 then replace(entype,5,'Others')
	when entype=77 then replace(entype,77,'Not Known')
	when entype=79 then replace(entype,79,'Refused to answer')
	when entype=88 then replace(entype,88,'N/A')
else
	null
end as 'School_Type',

timesch 'Travel Time to School(in min)',

case
	when levlread=1 then replace(levlread,1,'cannot read anything')
	when levlread=2 then replace(levlread,2,'reads letters')
	when levlread=3 then replace(levlread,3,'reads words')
	when levlread=4 then replace(levlread,4,'reads sentences')
else
	null
end as 'Reading_Level',

case
	when levlwrit=1 then replace(levlwrit,1,'No')
	when levlwrit=2 then replace(levlwrit,2,'Yes with difficulty or errors')
	when levlwrit=3 then replace(levlwrit,3,'Yes without difficulty or errors')
else
	null
end as 'Writing_Level',

iif(literate=0,'No',iif(literate=1,'Yes',null)) 'Literate',

case
	when caredu=0 then replace(caredu,0,'None')
	when caredu=1 then replace(caredu,1,'Grade 1')
	when caredu=2 then replace(caredu,2,'Grade 2')
	when caredu=3 then replace(caredu,3,'Grade 3')
	when caredu=4 then replace(caredu,4,'Grade 4')
	when caredu=5 then replace(caredu,5,'Grade 5')
	when caredu=6 then replace(caredu,6,'Grade 6')
	when caredu=7 then replace(caredu,7,'Grade 7')
	when caredu=8 then replace(caredu,8,'Grade 8')
	when caredu=9 then replace(caredu,9,'Grade 9')
	when caredu=10 then replace(caredu,10,'Grade 10')
	when caredu=11 then replace(caredu,11,'Grade 11')
	when caredu=12 then replace(caredu,12,'Grade 12')
	when caredu=13 then replace(caredu,13,'Post-secondary, Vocational')
	when caredu=14 then replace(caredu,14,'University')
	when caredu=15 then replace(caredu,15,'Masters, Doctorate')
	when caredu=28 then replace(caredu,28,'Adult literacy')
	when caredu=29 then replace(caredu,29,'Religious Education')
	when caredu=30 then replace(caredu,30,'Other')
else
	null
end as 'Caregiver_Education',

case
	when carehead=1 then replace(carehead,1,'Caregiver is Household Head')
	when carehead=2 then replace(carehead,2,'Caregiver is Partner')
	when carehead=3 then replace(carehead,3,'Other')
else
	null
end as 'Caregiver-HH Head',

careage 'Caregiver_Age',

iif(caresex=1,'Male',iif(caresex=2,'Female',null)) 'Caregiver_Gender',

case
	when carerel=1 then replace(carerel,1,'Biological Parent')
	when carerel=2 then replace(carerel,2,'Non-Biological Parent')
	when carerel=3 then replace(carerel,3,'Grandparent')
	when carerel=4 then replace(carerel,4,'Uncle/Aunt')
	when carerel=5 then replace(carerel,5,'Sibling')
	when carerel=6 then replace(carerel,6,'Other-relative')
	when carerel=7 then replace(carerel,7,'Other-nonrelative')
	when carerel=8 then replace(carerel,8,'Partner/spouse of YL child')
	when carerel=9 then replace(carerel,9,'Father-in-law/Mother-in-law')
else
	null
end as 'Caregiver-Child Relationship',

iif(carecantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Caregiver_Literate',

careladder 'Caregiver_Ladder',

case
	when dadedu=0 then replace(dadedu,0,'None')
	when dadedu=1 then replace(dadedu,1,'Grade 1')
	when dadedu=2 then replace(dadedu,2,'Grade 2')
	when dadedu=3 then replace(dadedu,3,'Grade 3')
	when dadedu=4 then replace(dadedu,4,'Grade 4')
	when dadedu=5 then replace(dadedu,5,'Grade 5')
	when dadedu=6 then replace(dadedu,6,'Grade 6')
	when dadedu=7 then replace(dadedu,7,'Grade 7')
	when dadedu=8 then replace(dadedu,8,'Grade 8')
	when dadedu=9 then replace(dadedu,9,'Grade 9')
	when dadedu=10 then replace(dadedu,10,'Grade 10')
	when dadedu=11 then replace(dadedu,11,'Grade 11')
	when dadedu=12 then replace(dadedu,12,'Grade 12')
	when dadedu=13 then replace(dadedu,13,'Post-secondary, Vocational')
	when dadedu=14 then replace(dadedu,14,'University')
	when dadedu=15 then replace(dadedu,15,'Masters, Doctorate')
	when dadedu=28 then replace(dadedu,28,'Adult literacy')
	when dadedu=29 then replace(dadedu,29,'Religious Education')
	when dadedu=30 then replace(dadedu,30,'Other')
else
	null
end as 'Fathers_Education',

case
	when dadlive=1 then replace(dadlive,1,'Lives in the household')
	when dadlive=2 then replace(dadlive,2,'Does not live in household')
	when dadlive=3 then replace(dadlive,3,'Has died')
else
	null
end as 'Fathers_Location',

dadage 'Fathers_Age',

iif(dadcantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Father_Literate',

iif(dadyrdied>0,dadyrdied,null) 'Father_Death',

case
	when momedu=0 then replace(momedu,0,'None')
	when momedu=1 then replace(momedu,1,'Grade 1')
	when momedu=2 then replace(momedu,2,'Grade 2')
	when momedu=3 then replace(momedu,3,'Grade 3')
	when momedu=4 then replace(momedu,4,'Grade 4')
	when momedu=5 then replace(momedu,5,'Grade 5')
	when momedu=6 then replace(momedu,6,'Grade 6')
	when momedu=7 then replace(momedu,7,'Grade 7')
	when momedu=8 then replace(momedu,8,'Grade 8')
	when momedu=9 then replace(momedu,9,'Grade 9')
	when momedu=10 then replace(momedu,10,'Grade 10')
	when momedu=11 then replace(momedu,11,'Grade 11')
	when momedu=12 then replace(momedu,12,'Grade 12')
	when momedu=13 then replace(momedu,13,'Post-secondary, Vocational')
	when momedu=14 then replace(momedu,14,'University')
	when momedu=15 then replace(momedu,15,'Masters, Doctorate')
	when momedu=28 then replace(momedu,28,'Adult literacy')
	when momedu=29 then replace(momedu,29,'Religious Education')
	when momedu=30 then replace(momedu,30,'Other')
else
	null
end as 'Mothers_Education',

case
	when momlive=1 then replace(momlive,1,'Lives in the household')
	when momlive=2 then replace(momlive,2,'Does not live in household')
	when momlive=3 then replace(momlive,3,'Has died')
else
	null
end as 'Mothers_Location',

momage 'Mother_Age',

iif(momcantread=0,'No',iif(momcantread=1,'Yes',null)) 'Mother_Literate',

iif(momyrdied>0,momyrdied,null) 'Mother_Death',

case
	when headedu=0 then replace(headedu,0,'None')
	when headedu=1 then replace(headedu,1,'Grade 1')
	when headedu=2 then replace(headedu,2,'Grade 2')
	when headedu=3 then replace(headedu,3,'Grade 3')
	when headedu=4 then replace(headedu,4,'Grade 4')
	when headedu=5 then replace(headedu,5,'Grade 5')
	when headedu=6 then replace(headedu,6,'Grade 6')
	when headedu=7 then replace(headedu,7,'Grade 7')
	when headedu=8 then replace(headedu,8,'Grade 8')
	when headedu=9 then replace(headedu,9,'Grade 9')
	when headedu=10 then replace(headedu,10,'Grade 10')
	when headedu=11 then replace(headedu,11,'Grade 11')
	when headedu=12 then replace(headedu,12,'Grade 12')
	when headedu=13 then replace(headedu,13,'Post-secondary, Vocational')
	when headedu=14 then replace(headedu,14,'University')
	when headedu=15 then replace(headedu,15,'Masters, Doctorate')
	when headedu=28 then replace(headedu,28,'Adult Literacy')
	when headedu=29 then replace(headedu,29,'Religious Education')
	when headedu=30 then replace(headedu,30,'Other')
else
	null
end as 'HH_Head_Education',

headage 'HH_Head_Age',

iif(headsex=1,'Male',iif(headsex=2,'Female',null)) 'HH_Head_Gender',

case
	when headrel=0 then replace(headrel,1,'YL Child')
	when headrel=1 then replace(headrel,1,'Biological parent')
	when headrel=2 then replace(headrel,2,'Non-Biological parent')
	when headrel=3 then replace(headrel,3,'Grandparent')
	when headrel=4 then replace(headrel,4,'Uncle/aunt')
	when headrel=5 then replace(headrel,5,'Sibling')
	when headrel=6 then replace(headrel,6,'Other-relative')
	when headrel=7 then replace(headrel,7,'Other-nonrelative')
	when headrel=8 then replace(headrel,8,'Partner/spouse of YL child')
	when headrel=9 then replace(headrel,9,'Father-in-law/mother-in-law')
else
	null
end as 'HH_Head-Child_Relationship',

hhsize 'Household_Size',

wi_new 'Wealth_Index',

hq_new 'Housing_Quality_Index',

sv_new 'Access_to_Services_Index',

cd_new 'Consumer_Durables_Index',

iif(drwaterq_new=0,'No',iif(drwaterq_new=1,'Yes',null)) 'Safe_Drinking_Water_Access',

iif(elecq_new=0,'No',iif(elecq_new=1,'Yes',null)) 'Electricity_Access',

iif(toiletq_new=0,'No',iif(elecq_new=1,'Yes',null)) 'Sanitation_Access',

iif(cookingq_new=0,'No',iif(elecq_new=1,'Yes',null)) 'Cooking_Fuel_Access',

iif(aniany=0,'No',iif(aniany=1,'Yes',null)) 'HH_own_Livestock',

iif(ownlandhse=0,'No',iif(ownlandhse=1,'Yes',null)) 'HH_owns_Land',

iif(ownhouse=0,'No',iif(ownhouse=1,'Yes',null)) 'HH_own_House',

case
	when foodsec=1 then replace(foodsec,1,'we always eat enough of what we want')
	when foodsec=2 then replace(foodsec,2,'we eat enough but not always what we would like')
	when foodsec=3 then replace(foodsec,3,'we sometimes do not eat enough')
	when foodsec=4 then replace(foodsec,4,'we frequently do not eat enough')
else
	null
end as 'HH_Food_Situation_in_the_last_12_Months'

INTO Ethiopia.Dataset
FROM dbo.Ethiopia;


--India Table Transformation

SELECT
childid 'ChildID',

iif(yc=0,'Older Cohort','Younger Cohort') 'Cohort',

[round] 'Round_of_Survey',

iif(inround=0,'No','Yes') 'Attended_Round',


iif(panel12345=0,'No','Yes') 'Attended_All_Rounds',

iif(deceased=0,'No','Yes') 'Deceased',

 cast(dint as date) 'Date of interview',

 commid 'CommunityID',

 clustid 'Sentinel_SiteID',

 	case
		when region=24 then replace(region, 24,'Others')
		when region=23 then replace(region, 23,'Telangana')
		when region=77 then replace(region,77,'Not known')
		when region=22 then replace(region, 22,'Rayalaseema')
		when region=21 then replace(region, 21,'Coastal Andhra')
		
	else
		null
	end		'Residential_Region',

iif(typesite=1,'Urban',iif(typesite=2,'Rural',iif(typesite=77,'Not Known',null))) 'Residential_Area',

iif(childloc=0,'No',iif(childloc=1,'Yes',null)) 'Currently_Lives_in_Household',

iif(chsex=1,'Male', iif(chsex=2,'Female', cast(chsex as nvarchar))) 'Gender',

case
		when chlang = 99 then replace(chlang, 99, 'missing')
		when chlang = 10 then replace(chlang, 10, 'other')
		when chlang = 77 then replace(chlang, 77, 'nk')
		when chlang = 79 then replace(chlang, 79, 'refused to answer')
		when chlang = 24 then replace(chlang, 24, 'oria')
		when chlang = 21 then replace(chlang, 21, 'telugu')
		when chlang = 22 then replace(chlang, 22, 'hindi')
		when chlang = 23 then replace(chlang, 23, 'urdu')
		when chlang = 88 then replace(chlang, 88, 'n/a')
		when chlang = 25 then replace(chlang, 25, 'kannada')
		when chlang = 26 then replace(chlang, 26, 'marati')
		when chlang = 27 then replace(chlang, 27, 'tamil')
		when chlang = 28 then replace(chlang, 28, 'local dialect')
	else
		cast(chlang as nvarchar)
	end
	as 'First_language',

case
		when chethnic = 99 then replace(chethnic, 99, 'NK')
		when chethnic = 100 then replace(chethnic, 100, 'Other, Hindu')
		when chethnic = 101 then replace(chethnic, 101, 'Other, Muslim')
		when chethnic = 102 then replace(chethnic, 102, 'Other, Buddhist')
		when chethnic = 104 then replace(chethnic, 104, 'Other, Christian')
		when chethnic = 14 then replace(chethnic, 14, 'None')
		when chethnic = 21 then replace(chethnic, 21, 'SC')
		when chethnic = 22 then replace(chethnic, 22, 'ST')
		when chethnic = 23 then replace(chethnic, 23, 'BC')
		when chethnic = 24 then replace(chethnic, 24, 'Other')
	else
		null
	end
	 as 'Ethnic_Group',

case
	when chldrel = 1 then replace(chldrel, 1, 'Christian')
	when chldrel = 2 then replace(chldrel, 2, 'Muslim')
	when chldrel = 3 then replace(chldrel, 3, 'Buddhist')
	when chldrel = 4 then replace(chldrel, 4, 'Hindu')
	when chldrel = 5 then replace(chldrel, 5, 'Catholic')
	when chldrel = 6 then replace(chldrel, 6, 'Protestant')
	when chldrel = 7 then replace(chldrel, 7, 'Orthodox')
	when chldrel = 8 then replace(chldrel, 8, 'Sikh')
	when chldrel = 9 then replace(chldrel, 9, 'Evangelist')
	when chldrel = 10 then replace(chldrel, 10, 'Mormon')
	when chldrel = 11 then replace(chldrel, 11, 'Ancestor worship')
	when chldrel = 12 then replace(chldrel, 12, 'Hao Hao')
	when chldrel = 13 then replace(chldrel, 13, 'Cao Dai')
	when chldrel = 14 then replace(chldrel, 14, 'None')
	when chldrel = 15 then replace(chldrel, 15, 'Other')
	when chldrel = 99 then replace(chldrel, 99, 'NK')

ELSE NULL
END
	AS 'Religion',

agemon 'Age',

iif(marrcohab=0, 'No', 'Yes') as 'Has_Ever_Married/Cohabited',

iif(marrcohab_age>1,marrcohab_age, null) 'Age at Marriage/Cohabitation',

iif(birth=0, 'No', 'Yes') as 'Has_a_Child',

iif(bcg=0, 'No', 'Yes') as 'BCG Vaccination',

iif(measles=0, 'No', 'Yes') as 'Measles Vaccination',

iif(dpt=0, 'No', 'Yes') as 'DPT Vaccination',

iif(polio=0, 'No', 'Yes') as 'Polio Vaccination',

iif(hib=0, 'No', 'Yes') as 'HIB Vaccination',

iif(chillness=0, 'No','Yes') 'Serious_Illness_Since_Last_round',

iif(chinjury=0, 'No','Yes') 'Serious_injury_since_last_round',

iif(chhprob=0, 'No','Yes') 'Long-term_Health_Problem',

iif(chdisability=0, 'No','Yes') 'Permanent_Disability',

case
	when chsmoke = 1 then replace(chsmoke, 1, 'Every day')
	when chsmoke = 2 then replace(chsmoke, 2, 'At least once a week')
	when chsmoke = 3 then replace(chsmoke, 3, 'At least once a month')
	when chsmoke = 4 then replace(chsmoke, 4, 'Hardly ever')
	when chsmoke = ' ' then replace(chsmoke,' ', 'None')
else
	replace(chsmoke, 5, 'None')
end as 'Frequency of Smoking',

iif(chalcohol=0, 'No','Yes') 'Consumes Alcohol Weekly',

case
	when chhrel=1 then replace(chhrel,1,'Same')
	when chhrel=2 then replace(chhrel,2,'Better')
	when chhrel=3 then replace(chhrel,3,'Worse')
else
	null
end as 'Health_vs_Peers',

case
	when chhealth=1 then replace(chhealth,1,'Very Poor')
	when chhealth=2 then replace(chhealth,2,'Poor')
	when chhealth=3 then replace(chhealth,3,'Average')
	when chhealth=4 then replace(chhealth,4,'Good')
	when chhealth=5 then replace(chhealth,5,'Very Good')
else
	null
end as 'Health_Condition',

iif(cladder>1,cladder,null) 'Well-being(9-step Ladder)',

hsleep 'Sleeping',

hcare 'Caring_for_family',

hchore 'Chores',

htask 'Domestic_Tasks',

hwork 'Paid_Activity',

hschool 'School',

hstudy 'Studying',

hplay 'Leisure_Activities',

iif(commwork>0,commwork,null) 'Work CommuteTo&Fro(in mins)',

iif(commsch>0,commsch,null) 'School CommuteTo&Fro(in mins)',

iif(preprim=0,'No',iif(preprim=1,'Yes', null)) 'Pre-primary_School',

agegr1 'Age_@Grade1',

case
	when enrol=0 then replace(enrol,0,'No')
	when enrol=1 then replace(enrol,1,'Yes')
	when enrol=99 then replace(enrol,99,'Missing')
	when enrol=77 then replace(enrol,77,'NK')
	when enrol=88 then replace(enrol,88,'N/A')
else
	null
end as 'Currently_Enrolled',

case
	when engrade=0 then replace(engrade,0,'None')
	when engrade=1 then replace(engrade,1,'Grade 01')
	when engrade=2 then replace(engrade,2,'Grade 02')
	when engrade=3 then replace(engrade,3,'Grade 03')
	when engrade=4 then replace(engrade,4,'Grade 04')
	when engrade=5 then replace(engrade,5,'Grade 05')
	when engrade=6 then replace(engrade,6,'Grade 06')
	when engrade=7 then replace(engrade,7,'Grade 07')
	when engrade=8 then replace(engrade,8,'Grade 08')
	when engrade=9 then replace(engrade,9,'Grade 09')
	when engrade=10 then replace(engrade,10,'Grade 10')
	when engrade=11 then replace(engrade,11,'Grade 11')
	when engrade=12 then replace(engrade,12,'Grade 12')
	when engrade=13 then replace(engrade,13,'Post-secondary/technological institute')
	when engrade=14 then replace(engrade,14,'Vocational')
	when engrade=15 then replace(engrade,15,'University degree(graduate)')
	when engrade=16 then replace(engrade,16,'University degree(postgraduate)')
	when engrade=100 then replace(engrade,100,'Pre-primary')
	when engrade=28 then replace(engrade,28,'Adult literacy')
	when engrade=29 then replace(engrade,29,'Religious education')
	when engrade=77 then replace(engrade,77,'Not Known')
else
	null
end as 'Current_Grade',

case
	when entype=1 then replace(entype,1,'Private')
	when entype=2 then replace(entype,2,'NGO/Charity/Religious(not-for-profit)')
	when entype=3 then replace(entype,3,'Public(Government)')
	when entype=4 then replace(entype,4,'Informal/non-formal community(e.g. mothers cooperative)')
	when entype=5 then replace(entype,5,'Vocational school')
	when entype=6 then replace(entype,6,'Charitable trust')
	when entype=7 then replace(entype,7,'India=bridge school')
	when entype=8 then replace(entype,8,'Mix of public and pirvate')
	when entype=9 then replace(entype,9,'vn=branch school')
	when entype=10 then replace(entype,10,'vn=main school')
	when entype=11 then replace(entype,11,'Others')
	when entype=77 then replace(entype,77,'Not Known')
	when entype=99 then replace(entype,99,'Missing')
	when entype=88 then replace(entype,88,'N/A')
else
	null
end as 'School_Type',

timesch 'Travel Time to School(in min)',

case
	when levlread=1 then replace(levlread,1,'cannot read anything')
	when levlread=2 then replace(levlread,2,'reads letters')
	when levlread=3 then replace(levlread,3,'reads words')
	when levlread=4 then replace(levlread,4,'reads sentences')
else
	null
end as 'Reading_Level',

case
	when levlwrit=1 then replace(levlwrit,1,'no')
	when levlwrit=2 then replace(levlwrit,2,'yes with difficulty or errors')
	when levlwrit=3 then replace(levlwrit,3,'yes without difficulty or errors')
else
	null
end as 'Writing_Level',

iif(literate=0,'No',iif(literate=1,'Yes',null)) 'Literate',

case
	when caredu=0 then replace(caredu,0,'None')
	when caredu=1 then replace(caredu,1,'Grade 1')
	when caredu=2 then replace(caredu,2,'Grade 2')
	when caredu=3 then replace(caredu,3,'Grade 3')
	when caredu=4 then replace(caredu,4,'Grade 4')
	when caredu=5 then replace(caredu,5,'Grade 5')
	when caredu=6 then replace(caredu,6,'Grade 6')
	when caredu=7 then replace(caredu,7,'Grade 7')
	when caredu=8 then replace(caredu,8,'Grade 8')
	when caredu=9 then replace(caredu,9,'Grade 9')
	when caredu=10 then replace(caredu,10,'Grade 10')
	when caredu=11 then replace(caredu,11,'Grade 11')
	when caredu=12 then replace(caredu,12,'Grade 12')
	when caredu=13 then replace(caredu,13,'Vocational, technical college')
	when caredu=14 then replace(caredu,14,'University')
	when caredu=15 then replace(caredu,15,'Masters, doctorate')
	when caredu=28 then replace(caredu,28,'Adult literacy')
	when caredu=29 then replace(caredu,29,'Religious education')
	when caredu=30 then replace(caredu,30,'Other')
else
	null
end as 'Caregiver_Education',

case
	when carehead=1 then replace(carehead,1,'Caregiver is household head')
	when carehead=2 then replace(carehead,2,'Caregiver is partner')
	when carehead=3 then replace(carehead,3,'Other')
else
	null
end as 'Caregiver-HH Head',

careage 'Caregiver_Age',

iif(caresex=1,'Male',iif(caresex=2,'Female',null)) 'Caregiver_Gender',

case
	when carerel=1 then replace(carerel,1,'Biological parent')
	when carerel=2 then replace(carerel,2,'Non-Biological parent')
	when carerel=3 then replace(carerel,3,'Grandparent')
	when carerel=4 then replace(carerel,4,'Uncle/aunt')
	when carerel=5 then replace(carerel,5,'Sibling')
	when carerel=6 then replace(carerel,6,'Other-relative')
	when carerel=7 then replace(carerel,7,'Other-nonrelative')
	when carerel=8 then replace(carerel,8,'Partner/spouse of YL child')
	when carerel=9 then replace(carerel,9,'Father-in-law/mother-in-law')
else
	null
end as 'Caregiver-Child Relationship',

iif(carecantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Caregiver_Literate',

careladder 'Caregiver_Ladder',

case
	when dadedu=0 then replace(dadedu,0,'None')
	when dadedu=1 then replace(dadedu,1,'Grade 1')
	when dadedu=2 then replace(dadedu,2,'Grade 2')
	when dadedu=3 then replace(dadedu,3,'Grade 3')
	when dadedu=4 then replace(dadedu,4,'Grade 4')
	when dadedu=5 then replace(dadedu,5,'Grade 5')
	when dadedu=6 then replace(dadedu,6,'Grade 6')
	when dadedu=7 then replace(dadedu,7,'Grade 7')
	when dadedu=8 then replace(dadedu,8,'Grade 8')
	when dadedu=9 then replace(dadedu,9,'Grade 9')
	when dadedu=10 then replace(dadedu,10,'Grade 10')
	when dadedu=11 then replace(dadedu,11,'Grade 11')
	when dadedu=12 then replace(dadedu,12,'Grade 12')
	when dadedu=13 then replace(dadedu,13,'Vocational, technical college')
	when dadedu=14 then replace(dadedu,14,'University')
	when dadedu=15 then replace(dadedu,15,'Masters, doctorate')
	when dadedu=28 then replace(dadedu,28,'Adult literacy')
	when dadedu=29 then replace(dadedu,29,'Religious education')
	when dadedu=30 then replace(dadedu,30,'Other')
else
	null
end as 'Fathers_Education',

case
	when dadlive=1 then replace(dadlive,1,'Lives in the household')
	when dadlive=2 then replace(dadlive,2,'Does not live in household')
	when dadlive=3 then replace(dadlive,3,'Has died')
else
	null
end as 'Fathers_Location',

dadage 'Fathers_Age',

iif(dadcantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Father_Literate',

iif(dadyrdied>0,dadyrdied,null) 'Father_Death',

case
	when momedu=0 then replace(momedu,0,'None')
	when momedu=1 then replace(momedu,1,'Grade 1')
	when momedu=2 then replace(momedu,2,'Grade 2')
	when momedu=3 then replace(momedu,3,'Grade 3')
	when momedu=4 then replace(momedu,4,'Grade 4')
	when momedu=5 then replace(momedu,5,'Grade 5')
	when momedu=6 then replace(momedu,6,'Grade 6')
	when momedu=7 then replace(momedu,7,'Grade 7')
	when momedu=8 then replace(momedu,8,'Grade 8')
	when momedu=9 then replace(momedu,9,'Grade 9')
	when momedu=10 then replace(momedu,10,'Grade 10')
	when momedu=11 then replace(momedu,11,'Grade 11')
	when momedu=12 then replace(momedu,12,'Grade 12')
	when momedu=13 then replace(momedu,13,'Vocational, technical college')
	when momedu=14 then replace(momedu,14,'University')
	when momedu=15 then replace(momedu,15,'Masters, doctorate')
	when momedu=28 then replace(momedu,28,'Adult literacy')
	when momedu=29 then replace(momedu,29,'Religious education')
	when momedu=30 then replace(momedu,30,'Other')
else
	null
end as 'Mothers_Education',

case
	when momlive=1 then replace(momlive,1,'Lives in the household')
	when momlive=2 then replace(momlive,2,'Does not live in household')
	when momlive=3 then replace(momlive,3,'Has died')
else
	null
end as 'Mothers_Location',

momage 'Mother_Age',

iif(momcantread=0,'No',iif(momcantread=1,'Yes',null)) 'Mother_Literate',

iif(momyrdied>0,momyrdied,null) 'Mother_Death',

case
	when headedu=0 then replace(headedu,0,'None')
	when headedu=1 then replace(headedu,1,'Grade 1')
	when headedu=2 then replace(headedu,2,'Grade 2')
	when headedu=3 then replace(headedu,3,'Grade 3')
	when headedu=4 then replace(headedu,4,'Grade 4')
	when headedu=5 then replace(headedu,5,'Grade 5')
	when headedu=6 then replace(headedu,6,'Grade 6')
	when headedu=7 then replace(headedu,7,'Grade 7')
	when headedu=8 then replace(headedu,8,'Grade 8')
	when headedu=9 then replace(headedu,9,'Grade 9')
	when headedu=10 then replace(headedu,10,'Grade 10')
	when headedu=11 then replace(headedu,11,'Grade 11')
	when headedu=12 then replace(headedu,12,'Grade 12')
	when headedu=13 then replace(headedu,13,'Vocational, technical college')
	when headedu=14 then replace(headedu,14,'University')
	when headedu=15 then replace(headedu,15,'Masters, doctorate')
	when headedu=28 then replace(headedu,28,'Adult literacy')
	when headedu=29 then replace(headedu,29,'Religious education')
	when headedu=30 then replace(headedu,30,'Other')
else
	null
end as 'HH_Head_Education',

headage 'HH_Head_Age',

iif(headsex=1,'Male',iif(headsex=2,'Female',null)) 'HH_Head_Gender',

case
	when headrel=1 then replace(headrel,1,'Biological parent')
	when headrel=2 then replace(headrel,2,'Non-Biological parent')
	when headrel=3 then replace(headrel,3,'Grandparent')
	when headrel=4 then replace(headrel,4,'Uncle/aunt')
	when headrel=5 then replace(headrel,5,'Sibling')
	when headrel=6 then replace(headrel,6,'Other-relative')
	when headrel=7 then replace(headrel,7,'Other-nonrelative')
	when headrel=8 then replace(headrel,8,'Partner/spouse of YL child')
	when headrel=9 then replace(headrel,9,'Father-in-law/mother-in-law')
else
	null
end as 'HH_Head-Child_Relationship',

hhsize 'Household_Size',

wi 'Wealth_Index',

hq 'Housing_Quality_Index',

sv 'Access_to_Services_Index',

cd 'Consumer_Durables_Index',

iif(drwaterq=0,'No',iif(drwaterq=1,'Yes',null)) 'Safe_Drinking_Water_Access',

iif(elecq=0,'No',iif(elecq=1,'Yes',null)) 'Electricity_Access',

iif(toiletq=0,'No',iif(toiletq=1,'Yes',null)) 'Sanitation_Access',

iif(cookingq=0,'No',iif(cookingq=1,'Yes',null)) 'Cooking_Fuel_Access',

iif(aniany=0,'No',iif(aniany=1,'Yes',null)) 'HH_own_Livestock',

iif(ownlandhse=0,'No',iif(ownlandhse=1,'Yes',null)) 'HH_owns_Land',

iif(ownhouse=0,'No',iif(ownhouse=1,'Yes',null)) 'HH_own_House',

case
	when foodsec=1 then replace(foodsec,1,'we always eat enough of what we want')
	when foodsec=2 then replace(foodsec,2,'we eat enough but not always what we would like')
	when foodsec=3 then replace(foodsec,3,'we sometimes do not eat enough')
	when foodsec=4 then replace(foodsec,4,'we frequently do not eat enough')
else
	null
end as 'HH_Food_Situation_in_the_last_12_Months'

INTO India.Dataset
FROM dbo.India;



--Peru Table Transformation

SELECT
childid 'ChildID',

iif(yc=0,'Older Cohort','Younger Cohort') 'Cohort',

[round] 'Round_of_Survey',

iif(inround=0,'No','Yes') 'Attended_Round',

iif(panel12345=0,'No','Yes') 'Attended_All_Rounds',

iif(deceased=1,'Yes','No') 'Deceased',

 cast(dint as date) 'Date of interview',

 placeid 'CommunityID',

 clustid 'Sentinel_SiteID',

 	case
		when region=32 then replace(region, 32,'Sierra')
		when region=33 then replace(region, 33,'Selva')
		when region=88 then replace(region, 88,'N/A')
		when region=31 then replace(region, 31,'Costa')
		
	else
		null
	end		'Residential_Region',

iif(typesite=1,'Urban',iif(typesite=2,'Rural',null)) 'Residential_Area',

iif(childloc=0,'No',iif(childloc=1,'Yes',null)) 'Currently_Lives_in_Household',

iif(chsex=1,'Male', iif(chsex=2,'Female', cast(chsex as nvarchar))) 'Gender',

case
		when chlang = 32 then replace(chlang, 32, 'Quechua')
		when chlang = 33 then replace(chlang, 2, 'Aymara')
		when chlang = 34 then replace(chlang, 34, 'Native from Jungle')
		when chlang = 35 then replace(chlang, 35, 'Spanish & Quechua')
		when chlang = 36 then replace(chlang, 36, 'Spanish & Aymara')
		when chlang = 37 then replace(chlang, 37, 'Nomatsiguenga')
		when chlang = 10 then replace(chlang, 10, 'Other')
		when chlang = 77 then replace(chlang, 77, 'NK')
		when chlang = 79 then replace(chlang, 79, 'Refused to answer')
		when chlang = 50 then replace(chlang, 50, 'Mute or difficulty speaking')
		when chlang = 99 then replace(chlang, 99, 'Missing')
		when chlang = 88 then replace(chlang, 88, 'N/A')
		when chlang = 31 then replace(chlang, 31, 'Spanish')

	else
		cast(chlang as nvarchar)
	end
	as 'First_language',

case
		when chethnic = 32 then replace(chethnic, 32, 'Mestizo')
		when chethnic = 33 then replace(chethnic, 33, 'Native of the Amazon')
		when chethnic = 34 then replace(chethnic, 34, 'Negro')
		when chethnic = 35 then replace(chethnic, 12, 'Asiatic')
		when chethnic = 31 then replace(chethnic, 13, 'White')

	else
		null
	end
	 as 'Ethnic_Group',

case
	when chldrel = 1 then replace(chldrel, 1, 'Christian')
	when chldrel = 2 then replace(chldrel, 2, 'Muslim')
	when chldrel = 3 then replace(chldrel, 3, 'Buddhist')
	when chldrel = 4 then replace(chldrel, 4, 'Hindu')
	when chldrel = 5 then replace(chldrel, 5, 'Catholic')
	when chldrel = 6 then replace(chldrel, 6, 'Protestant')
	when chldrel = 7 then replace(chldrel, 7, 'Orthodox')
	when chldrel = 8 then replace(chldrel, 8, 'Sikh')
	when chldrel = 9 then replace(chldrel, 9, 'Evangelist')
	when chldrel = 10 then replace(chldrel, 10, 'Mormon')
	when chldrel = 11 then replace(chldrel, 11, 'Ancestor Worship')
	when chldrel = 12 then replace(chldrel, 12, 'Hao Hao')
	when chldrel = 13 then replace(chldrel, 13, 'Cao Dai')
	when chldrel = 14 then replace(chldrel, 14, 'None')
	when chldrel = 15 then replace(chldrel, 15, 'Other')
	when chldrel = 99 then replace(chldrel, 99, 'NK')

ELSE NULL
END
	AS 'Religion',

agemon 'Age',

iif(marrcohab=0, 'No', 'Yes') as 'Has_Ever_Married/Cohabited',

iif(marrcohab_age>1,marrcohab_age, null) 'Age at Marriage/Cohabitation',

iif(birth=0, 'No', 'Yes') as 'Has_a_Child',

iif(bcg=0, 'No', 'Yes') as 'BCG Vaccination',

iif(measles=0, 'No', 'Yes') as 'Measles Vaccination',

iif(dpt=0, 'No', 'Yes') as 'DPT Vaccination',

iif(polio=0, 'No', 'Yes') as 'Polio Vaccination',

iif(hib=0, 'No', 'Yes') as 'HIB Vaccination',

iif(chillness=0, 'No','Yes') 'Serious_Illness_Since_Last_round',

iif(chinjury=0, 'No','Yes') 'Serious_injury_since_last_round',

iif(chhprob=0, 'No','Yes') 'Long-term_Health_Problem',

iif(chdisability=0, 'No','Yes') 'Permanent_Disability',

case
	when chsmoke = 1 then replace(chsmoke, 1, 'Every day')
	when chsmoke = 2 then replace(chsmoke, 2, 'At least once a week')
	when chsmoke = 3 then replace(chsmoke, 3, 'At least once a month')
	when chsmoke = 4 then replace(chsmoke, 4, 'Hardly ever')
	when chsmoke = ' ' then replace(chsmoke,' ', 'None')
else
	replace(chsmoke, 5, 'None')
end as 'Frequency of Smoking',

iif(chalcohol=0, 'No','Yes') 'Consumes Alcohol Weekly',

case
	when chhrel=1 then replace(chhrel,1,'Same')
	when chhrel=2 then replace(chhrel,2,'Better')
	when chhrel=3 then replace(chhrel,3,'Worse')
else
	null
end as 'Health_vs_Peers',

case
	when chhealth=1 then replace(chhealth,1,'Very Poor')
	when chhealth=2 then replace(chhealth,2,'Poor')
	when chhealth=3 then replace(chhealth,3,'Average')
	when chhealth=4 then replace(chhealth,4,'Good')
	when chhealth=5 then replace(chhealth,5,'Very Good')
else
	null
end as 'Health_Condition',

iif(cladder>1,cladder,null) 'Well-being(9-step Ladder)',

hsleep 'Sleeping',

hcare 'Caring_for_family',

hchore 'Chores',

htask 'Domestic_Tasks',

hwork 'Paid_Activity',

hschool 'School',

hstudy 'Studying',

hplay 'Leisure_Activities',

iif(commwork>0,commwork,null) 'Work CommuteTo&Fro(in mins)',

iif(commsch>0,commsch,null) 'School CommuteTo&Fro(in mins)',

iif(preprim=0,'No',iif(preprim=1,'Yes', null)) 'Pre-primary_School',

agegr1 'Age_@Grade1',

case
	when enrol=0 then replace(enrol,0,'No')
	when enrol=1 then replace(enrol,1,'Yes')
	when enrol=99 then replace(enrol,99,'Missing')
	when enrol=77 then replace(enrol,77,'NK')
	when enrol=88 then replace(enrol,88,'N/A')
else
	null
end as 'Currently_Enrolled',

case
	when engrade=0 then replace(engrade,0,'None')
	when engrade=1 then replace(engrade,1,'Grade 01')
	when engrade=2 then replace(engrade,2,'Grade 02')
	when engrade=3 then replace(engrade,3,'Grade 03')
	when engrade=4 then replace(engrade,4,'Grade 04')
	when engrade=5 then replace(engrade,5,'Grade 05')
	when engrade=6 then replace(engrade,6,'Grade 06')
	when engrade=7 then replace(engrade,7,'Grade 07')
	when engrade=8 then replace(engrade,8,'Grade 08')
	when engrade=9 then replace(engrade,9,'Grade 09')
	when engrade=10 then replace(engrade,10,'Grade 10')
	when engrade=11 then replace(engrade,11,'Grade 11')
	when engrade=13 then replace(engrade,13,'Incomplete technical or pedagogical institute')
	when engrade=14 then replace(engrade,14,'Complete technical or pedagogical institute')
	when engrade=15 then replace(engrade,15,'Incomplete University')
	when engrade=16 then replace(engrade,16,'Complete University')
	when engrade=17 then replace(engrade,17,'Adult literacy program')
	when engrade=18 then replace(engrade,18,'Other')
	when engrade=19 then replace(engrade,19,'Masters or Doctoral at University')
	when engrade=20 then replace(engrade,20,'Some form of formal or informal preshool')
	when engrade=21 then replace(engrade,21,'Incomplete Cent. Tecnico Productivo CETPRO/ Cent. Edu. Ocupacional CEO')
	when engrade=22 then replace(engrade,22,'Complete Cent. Tecnico Productivo CETPRO/ Cent. Edu. Ocupacional CEO')
	when engrade=88 then replace(engrade,88,'Missing')
	when engrade=100 then replace(engrade,100,'Pre-primary')
	when engrade=79 then replace(engrade,79,'N/A')
	when engrade=77 then replace(engrade,77,'NK')
else
	null
end as 'Current_Grade',

case
	when entype=1 then replace(entype,1,'Private')
	when entype=2 then replace(entype,2,'Public(Partly Govt-Funded')
	when entype=3 then replace(entype,3,'Half public/half private')
	when entype=4 then replace(entype,4,'Other')
	when entype=88 then replace(entype,88,'N/A')
else
	null
end as 'School_Type',

timesch 'Travel Time to School(in min)',

case
	when levlread=1 then replace(levlread,1,'cannot read anything')
	when levlread=2 then replace(levlread,2,'reads letters')
	when levlread=3 then replace(levlread,3,'reads words')
	when levlread=4 then replace(levlread,4,'reads sentences')
	when levlread=79 then replace(levlread,79,'refused to answer')
else
	null
end as 'Reading_Level',

case
	when levlwrit=1 then replace(levlwrit,1,'No')
	when levlwrit=2 then replace(levlwrit,2,'Yes with difficulty or errors')
	when levlwrit=3 then replace(levlwrit,3,'Yes without difficulty or errors')
	when levlwrit=79 then replace(levlwrit,79,'Refused to answer')
else
	null
end as 'Writing_Level',

iif(literate=0,'No',iif(literate=1,'Yes',null)) 'Literate',

case
	when caredu=0 then replace(caredu,0,'None')
	when caredu=1 then replace(caredu,1,'Grade 1')
	when caredu=2 then replace(caredu,2,'Grade 2')
	when caredu=3 then replace(caredu,3,'Grade 3')
	when caredu=4 then replace(caredu,4,'Grade 4')
	when caredu=5 then replace(caredu,5,'Grade 5')
	when caredu=6 then replace(caredu,6,'Grade 6')
	when caredu=7 then replace(caredu,7,'Grade 7')
	when caredu=8 then replace(caredu,8,'Grade 8')
	when caredu=9 then replace(caredu,9,'Grade 9')
	when caredu=10 then replace(caredu,10,'Grade 10')
	when caredu=11 then replace(caredu,11,'Grade 11')
	when caredu=13 then replace(caredu,13,'Technical, pedagogical, CETPRO (incomplete)')
	when caredu=14 then replace(caredu,14,'Technical, pedagogical, CETPRO (complete)')
	when caredu=15 then replace(caredu,15,'University(incomplete)')
	when caredu=16 then replace(caredu,16,'University(complete)')
	when caredu=28 then replace(caredu,28,'Adult literacy')
	when caredu=30 then replace(caredu,30,'Other')
else
	null
end as 'Caregiver_Education',

case
	when carehead=1 then replace(carehead,1,'Caregiver is Household Head')
	when carehead=2 then replace(carehead,2,'Caregiver is Partner')
	when carehead=3 then replace(carehead,3,'Other')
else
	null
end as 'Caregiver-HH Head',

careage 'Caregiver_Age',

iif(caresex=1,'Male',iif(caresex=2,'Female',null)) 'Caregiver_Gender',

case
	when carerel=1 then replace(carerel,1,'Biological Parent')
	when carerel=2 then replace(carerel,2,'Non-Biological Parent')
	when carerel=3 then replace(carerel,3,'Grandparent')
	when carerel=4 then replace(carerel,4,'Uncle/Aunt')
	when carerel=5 then replace(carerel,5,'Sibling')
	when carerel=6 then replace(carerel,6,'Other-relative')
	when carerel=7 then replace(carerel,7,'Other-nonrelative')
	when carerel=8 then replace(carerel,8,'Partner/spouse of YL child')
	when carerel=9 then replace(carerel,9,'Father-in-law/Mother-in-law')
else
	null
end as 'Caregiver-Child Relationship',

iif(carecantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Caregiver_Literate',

careladder 'Caregiver_Ladder',

case
	when dadedu=0 then replace(dadedu,0,'None')
	when dadedu=1 then replace(dadedu,1,'Grade 1')
	when dadedu=2 then replace(dadedu,2,'Grade 2')
	when dadedu=3 then replace(dadedu,3,'Grade 3')
	when dadedu=4 then replace(dadedu,4,'Grade 4')
	when dadedu=5 then replace(dadedu,5,'Grade 5')
	when dadedu=6 then replace(dadedu,6,'Grade 6')
	when dadedu=7 then replace(dadedu,7,'Grade 7')
	when dadedu=8 then replace(dadedu,8,'Grade 8')
	when dadedu=9 then replace(dadedu,9,'Grade 9')
	when dadedu=10 then replace(dadedu,10,'Grade 10')
	when dadedu=11 then replace(dadedu,11,'Grade 11')
	when dadedu=13 then replace(dadedu,13,'Technical, pedagogical, CETPRO (incomplete)')
	when dadedu=14 then replace(dadedu,14,'Technical, pedagogical, CETPRO (complete)')
	when dadedu=15 then replace(dadedu,15,'University (incomplete)')
	when dadedu=16 then replace(dadedu,16,'University (complete)')
	when dadedu=28 then replace(dadedu,28,'Adult literacy')
	when dadedu=30 then replace(dadedu,30,'Other')
else
	null
end as 'Fathers_Education',

case
	when dadlive=1 then replace(dadlive,1,'Lives in the household')
	when dadlive=2 then replace(dadlive,2,'Does not live in household')
	when dadlive=3 then replace(dadlive,3,'Has died')
else
	null
end as 'Fathers_Location',

dadage 'Fathers_Age',

iif(dadcantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Father_Literate',

iif(dadyrdied>0,dadyrdied,null) 'Father_Death',

case
	when momedu=0 then replace(momedu,0,'None')
	when momedu=1 then replace(momedu,1,'Grade 1')
	when momedu=2 then replace(momedu,2,'Grade 2')
	when momedu=3 then replace(momedu,3,'Grade 3')
	when momedu=4 then replace(momedu,4,'Grade 4')
	when momedu=5 then replace(momedu,5,'Grade 5')
	when momedu=6 then replace(momedu,6,'Grade 6')
	when momedu=7 then replace(momedu,7,'Grade 7')
	when momedu=8 then replace(momedu,8,'Grade 8')
	when momedu=9 then replace(momedu,9,'Grade 9')
	when momedu=10 then replace(momedu,10,'Grade 10')
	when momedu=11 then replace(momedu,11,'Grade 11')
	when momedu=13 then replace(momedu,13,'Technical, pedagogical, CETPRO (incomplete)')
	when momedu=14 then replace(momedu,14,'Technical, pedagogical, CETPRO (complete)')
	when momedu=15 then replace(momedu,15,'University (incomplete)')
	when momedu=16 then replace(momedu,16,'University (complete)')
	when momedu=28 then replace(momedu,28,'Adult literacy')
	when momedu=30 then replace(momedu,30,'Other')
else
	null
end as 'Mothers_Education',

case
	when momlive=1 then replace(momlive,1,'Lives in the household')
	when momlive=2 then replace(momlive,2,'Does not live in household')
	when momlive=3 then replace(momlive,3,'Has died')
else
	null
end as 'Mothers_Location',

momage 'Mother_Age',

iif(momcantread=0,'No',iif(momcantread=1,'Yes',null)) 'Mother_Literate',

iif(momyrdied>0,momyrdied,null) 'Mother_Death',

case
	when headedudu=0 then replace(headedudu,0,'None')
	when headedudu=1 then replace(headedudu,1,'Grade 1')
	when headedudu=2 then replace(headedudu,2,'Grade 2')
	when headedudu=3 then replace(headedudu,3,'Grade 3')
	when headedudu=4 then replace(headedudu,4,'Grade 4')
	when headedudu=5 then replace(headedudu,5,'Grade 5')
	when headedudu=6 then replace(headedudu,6,'Grade 6')
	when headedudu=7 then replace(headedudu,7,'Grade 7')
	when headedudu=8 then replace(headedudu,8,'Grade 8')
	when headedudu=9 then replace(headedudu,9,'Grade 9')
	when headedudu=10 then replace(headedudu,10,'Grade 10')
	when headedudu=11 then replace(headedudu,11,'Grade 11')
	when headedudu=12 then replace(headedudu,12,'Grade 12')
	when headedudu=13 then replace(headedudu,13,'Technical, pedagogical, CETPRO (incomplete)')
	when headedudu=14 then replace(headedudu,14,'Technical, pedagogical, CETPRO (complete)')
	when headedudu=15 then replace(headedudu,15,'University (incomplete)')
	when headedudu=16 then replace(headedudu,16,'University (complete)')
	when headedudu=28 then replace(headedudu,28,'Adult Literacy')
	when headedudu=30 then replace(headedudu,30,'Other')
else
	null
end as 'HH_Head_Education',

headage 'HH_Head_Age',

iif(headsex=1,'Male',iif(headsex=2,'Female',null)) 'HH_Head_Gender',

case
	when headrel=0 then replace(headrel,1,'YL Child')
	when headrel=1 then replace(headrel,1,'Biological parent')
	when headrel=2 then replace(headrel,2,'Non-Biological parent')
	when headrel=3 then replace(headrel,3,'Grandparent')
	when headrel=4 then replace(headrel,4,'Uncle/aunt')
	when headrel=5 then replace(headrel,5,'Sibling')
	when headrel=6 then replace(headrel,6,'Other-relative')
	when headrel=7 then replace(headrel,7,'Other-nonrelative')
	when headrel=8 then replace(headrel,8,'Partner/spouse of YL child')
	when headrel=9 then replace(headrel,9,'Father-in-law/mother-in-law')
else
	null
end as 'HH_Head-Child_Relationship',

hhsize 'Household_Size',

wi 'Wealth_Index',

hq 'Housing_Quality_Index',

sv 'Access_to_Services_Index',

cd 'Consumer_Durables_Index',

iif(drwaterq=0,'No',iif(drwaterq=1,'Yes',null)) 'Safe_Drinking_Water_Access',

iif(elecq=0,'No',iif(elecq=1,'Yes',null)) 'Electricity_Access',

iif(toiletq=0,'No',iif(toiletq=1,'Yes',null)) 'Sanitation_Access',

iif(cookingq=0,'No',iif(cookingq=1,'Yes',null)) 'Cooking_Fuel_Access',

iif(aniany=0,'No',iif(aniany=1,'Yes',null)) 'HH_own_Livestock',

iif(ownlandhse=0,'No',iif(ownlandhse=1,'Yes',null)) 'HH_owns_Land',

iif(ownhouse=0,'No',iif(ownhouse=1,'Yes',null)) 'HH_own_House',

case
	when foodsec=1 then replace(foodsec,1,'we always eat enough of what we want')
	when foodsec=2 then replace(foodsec,2,'we eat enough but not always what we would like')
	when foodsec=3 then replace(foodsec,3,'we sometimes do not eat enough')
	when foodsec=4 then replace(foodsec,4,'we frequently do not eat enough')
else
	null
end as 'HH_Food_Situation_in_the_last_12_Months'

INTO Peru.Dataset
FROM dbo.Peru;


--Vietnam Table Transformation

SELECT
childid 'ChildID',

iif(yc=0,'Older Cohort','Younger Cohort') 'Cohort',

[round] 'Round_of_Survey',

iif(inround=0,'No','Yes') 'Attended_Round',

iif(panel12345=0,'No','Yes') 'Attended_All_Rounds',

iif(deceased=1,'Yes','No') 'Deceased',

 cast(dint as date) 'Date of interview',

 commid 'CommunityID',

 clustid 'Sentinel_SiteID',

 	case
		when region=51 then replace(region, 51,'Northern Uplands')
		when region=52 then replace(region, 52,'Red River Delta')
		when region=53 then replace(region, 53,'Phu Yen')
		when region=54 then replace(region, 54,'Da Nang')
		when region=55 then replace(region, 55,'Highlands')
		when region=56 then replace(region, 56,'South Eastern')
		when region=57 then replace(region, 57,'Mekong River Delta')
		when region=58 then replace(region, 58,'Other')
		
	else
		null
	end		'Residential_Region',

iif(typesite=1,'Urban',iif(typesite=2,'Rural',null)) 'Residential_Area',

iif(childloc=0,'No',iif(childloc=1,'Yes',null)) 'Currently_Lives_in_Household',

iif(chsex=1,'Male', iif(chsex=2,'Female', cast(chsex as nvarchar))) 'Gender',

case
		when chlang = 41 then replace(chlang, 41, 'Vietnamese')
		when chlang = 43 then replace(chlang, 43, 'Tay')
		when chlang = 44 then replace(chlang, 44, 'HMong')
		when chlang = 46 then replace(chlang, 46, 'Ede')
		when chlang = 45 then replace(chlang, 45, 'Nung')
		when chlang = 48 then replace(chlang, 48, 'Dao')
		when chlang = 49 then replace(chlang, 49, 'Giay')
		when chlang = 47 then replace(chlang, 47, 'Thai')
		when chlang = 42 then replace(chlang, 42, 'Chinese')
		when chlang = 10 then replace(chlang, 10, 'Other')
		when chlang = 88 then replace(chlang, 88, 'N/A')
		when chlang = 79 then replace(chlang, 79, 'Refused to answer')
		when chlang = 99 then replace(chlang, 99, 'Missing')
		when chlang = 77 then replace(chlang, 77, 'NK')
	else
		cast(chlang as nvarchar)
	end
	as 'First_language',

case
		when chethnic = 99 then replace(chethnic, 99, 'NK')
		when chethnic = 10 then replace(chethnic, 10, 'Other')
		when chethnic = 41 then replace(chethnic, 41, 'Kinh')
		when chethnic = 43 then replace(chethnic, 43, 'Cham')
		when chethnic = 44 then replace(chethnic, 44, 'Ede')
		when chethnic = 45 then replace(chethnic, 45, 'Bana')
		when chethnic = 46 then replace(chethnic, 46, 'Nung')
		when chethnic = 47 then replace(chethnic, 47, 'Tay')
		when chethnic = 48 then replace(chethnic, 48, 'Dao')
		when chethnic = 42 then replace(chethnic, 42, 'HMong')
	else
		null
	end
	 as 'Ethnic_Group',

case
	when chldrel = 1 then replace(chldrel, 1, 'Christian')
	when chldrel = 2 then replace(chldrel, 2, 'Muslim')
	when chldrel = 3 then replace(chldrel, 3, 'Buddhist')
	when chldrel = 4 then replace(chldrel, 4, 'Hindu')
	when chldrel = 5 then replace(chldrel, 5, 'Catholic')
	when chldrel = 6 then replace(chldrel, 6, 'Protestant')
	when chldrel = 7 then replace(chldrel, 7, 'Orthodox')
	when chldrel = 8 then replace(chldrel, 8, 'Sikh')
	when chldrel = 9 then replace(chldrel, 9, 'Evangelist')
	when chldrel = 10 then replace(chldrel, 10, 'Mormon')
	when chldrel = 11 then replace(chldrel, 11, 'Ancestor Worship')
	when chldrel = 12 then replace(chldrel, 12, 'Hao Hao')
	when chldrel = 13 then replace(chldrel, 13, 'Cao Dai')
	when chldrel = 14 then replace(chldrel, 14, 'None')
	when chldrel = 15 then replace(chldrel, 15, 'Other')
	when chldrel = 99 then replace(chldrel, 99, 'NK')

ELSE NULL
END
	AS 'Religion',

agemon 'Age',

iif(marrcohab=0, 'No', 'Yes') as 'Has_Ever_Married/Cohabited',

iif(marrcohab_age>1,marrcohab_age, null) 'Age at Marriage/Cohabitation',

iif(birth=0, 'No', 'Yes') as 'Has_a_Child',

iif(bcg=0, 'No', 'Yes') as 'BCG Vaccination',

iif(measles=0, 'No', 'Yes') as 'Measles Vaccination',

iif(dpt=0, 'No', 'Yes') as 'DPT Vaccination',

iif(polio=0, 'No', 'Yes') as 'Polio Vaccination',

iif(hib=0, 'No', 'Yes') as 'HIB Vaccination',

iif(chillness=0, 'No','Yes') 'Serious_Illness_Since_Last_round',

iif(chinjury=0, 'No','Yes') 'Serious_injury_since_last_round',

iif(chhprob=0, 'No','Yes') 'Long-term_Health_Problem',

iif(chdisability=0, 'No','Yes') 'Permanent_Disability',

case
	when chsmoke = 1 then replace(chsmoke, 1, 'Every day')
	when chsmoke = 2 then replace(chsmoke, 2, 'At least once a week')
	when chsmoke = 3 then replace(chsmoke, 3, 'At least once a month')
	when chsmoke = 4 then replace(chsmoke, 4, 'Hardly ever')
	when chsmoke = ' ' then replace(chsmoke,' ', 'None')
else
	replace(chsmoke, 5, 'None')
end as 'Frequency of Smoking',

iif(chalcohol=0, 'No','Yes') 'Consumes Alcohol Weekly',

case
	when chhrel=1 then replace(chhrel,1,'Same')
	when chhrel=2 then replace(chhrel,2,'Better')
	when chhrel=3 then replace(chhrel,3,'Worse')
else
	null
end as 'Health_vs_Peers',

case
	when chhealth=1 then replace(chhealth,1,'Very Poor')
	when chhealth=2 then replace(chhealth,2,'Poor')
	when chhealth=3 then replace(chhealth,3,'Average')
	when chhealth=4 then replace(chhealth,4,'Good')
	when chhealth=5 then replace(chhealth,5,'Very Good')
else
	null
end as 'Health_Condition',

iif(cladder>1,cladder,null) 'Well-being(9-step Ladder)',

hsleep 'Sleeping',

hcare 'Caring_for_family',

hchore 'Chores',

htask 'Domestic_Tasks',

hwork 'Paid_Activity',

hschool 'School',

hstudy 'Studying',

hplay 'Leisure_Activities',

iif(commwork>0,commwork,null) 'Work CommuteTo&Fro(in mins)',

iif(commsch>0,commsch,null) 'School CommuteTo&Fro(in mins)',

iif(preprim=0,'No',iif(preprim=1,'Yes', null)) 'Pre-primary_School',

agegr1 'Age_@Grade1',

case
	when enrol=0 then replace(enrol,0,'No')
	when enrol=1 then replace(enrol,1,'Yes')
	when enrol=99 then replace(enrol,99,'Missing')
	when enrol=77 then replace(enrol,77,'NK')
	when enrol=88 then replace(enrol,88,'N/A')
else
	null
end as 'Currently_Enrolled',

case
	when engrade=0 then replace(engrade,0,'None')
	when engrade=1 then replace(engrade,1,'Grade 01')
	when engrade=2 then replace(engrade,2,'Grade 02')
	when engrade=3 then replace(engrade,3,'Grade 03')
	when engrade=4 then replace(engrade,4,'Grade 04')
	when engrade=5 then replace(engrade,5,'Grade 05')
	when engrade=6 then replace(engrade,6,'Grade 06')
	when engrade=7 then replace(engrade,7,'Grade 07')
	when engrade=8 then replace(engrade,8,'Grade 08')
	when engrade=9 then replace(engrade,9,'Grade 09')
	when engrade=10 then replace(engrade,10,'Grade 10')
	when engrade=11 then replace(engrade,11,'Grade 11')
	when engrade=12 then replace(engrade,12,'Grade 12')
	when engrade=13 then replace(engrade,13,'Short term Vocational Training')
	when engrade=14 then replace(engrade,14,'Vocational Secondary School (1st year)')
	when engrade=15 then replace(engrade,15,'Vocational Secondary School (2nd year)')
	when engrade=16 then replace(engrade,16,'Vocational Secondary School completion')
	when engrade=17 then replace(engrade,17,'Professional Secondary (1st years)')
	when engrade=18 then replace(engrade,18,'Professional Secondary (2nd years)')
	when engrade=19 then replace(engrade,19,'Professional Secondary (3rd years)')
	when engrade=20 then replace(engrade,20,'Professional Secondary completion')
	when engrade=21 then replace(engrade,21,'Vocational College (1st year)')
	when engrade=22 then replace(engrade,22,'Vocational College (2nd year)')
	when engrade=23 then replace(engrade,23,'Vocational college completion')
	when engrade=24 then replace(engrade,24,'College education (1st year)')
	when engrade=25 then replace(engrade,25,'College education (2nd year)')
	when engrade=26 then replace(engrade,26,'College education completion')
	when engrade=27 then replace(engrade,27,'In the job, evening/weekend college education')
	when engrade=28 then replace(engrade,28,'In the job, evening/weekend undergraduate in university')
	when engrade=29 then replace(engrade,29,'University education (undergraduate 1st year)')
	when engrade=30 then replace(engrade,30,'University education (undergraduate 2nd year)')
	when engrade=31 then replace(engrade,31,'University education (undergraduate 3rd year)')
	when engrade=32 then replace(engrade,32,'University education (undergraduate 4th year)')
	when engrade=33 then replace(engrade,33,'University education (undergraduate 5th year)')
	when engrade=34 then replace(engrade,34,'University education completion')
	when engrade=35 then replace(engrade,35,'Post-graduate education')
	when engrade=36 then replace(engrade,36,'Post-graduate completion')
	when engrade=37 then replace(engrade,37,'Centre for continued education (non-formal student)')
	when engrade=38 then replace(engrade,38,'Other, (specify)')
	when engrade=50 then replace(engrade,50,'Any pre-primary grade')
	when engrade=77 then replace(engrade,77,'NK')
else
	null
end as 'Current_Grade',

case
	when entype=1 then replace(entype,1,'Private')
	when entype=2 then replace(entype,2,'NGO/Charity/Religious')
	when entype=3 then replace(entype,3,'Public')
	when entype=5 then replace(entype,5,'Others, specify')
	when entype=6 then replace(entype,6,'Informal')
	when entype=7 then replace(entype,7,'Half public/Half Private')
	when entype=8 then replace(entype,8,'Centre for contiuing education')
	when entype=77 then replace(entype,77,'NK')
	when entype=88 then replace(entype,88,'N/A')
else
	null
end as 'School_Type',

timesch 'Travel Time to School(in min)',

case
	when levlread=1 then replace(levlread,1,'cannot read anything')
	when levlread=2 then replace(levlread,2,'reads letters')
	when levlread=3 then replace(levlread,3,'reads words')
	when levlread=4 then replace(levlread,4,'reads sentences')
else
	null
end as 'Reading_Level',

case
	when levlwrit=1 then replace(levlwrit,1,'No')
	when levlwrit=2 then replace(levlwrit,2,'Yes with difficulty or errors')
	when levlwrit=3 then replace(levlwrit,3,'Yes without difficulty or errors')
else
	null
end as 'Writing_Level',

iif(literate=0,'No',iif(literate=1,'Yes',null)) 'Literate',

case
	when caredu=0 then replace(caredu,0,'None')
	when caredu=1 then replace(caredu,1,'Grade 1')
	when caredu=2 then replace(caredu,2,'Grade 2')
	when caredu=3 then replace(caredu,3,'Grade 3')
	when caredu=4 then replace(caredu,4,'Grade 4')
	when caredu=5 then replace(caredu,5,'Grade 5')
	when caredu=6 then replace(caredu,6,'Grade 6')
	when caredu=7 then replace(caredu,7,'Grade 7')
	when caredu=8 then replace(caredu,8,'Grade 8')
	when caredu=9 then replace(caredu,9,'Grade 9')
	when caredu=10 then replace(caredu,10,'Grade 10')
	when caredu=11 then replace(caredu,11,'Grade 11')
	when caredu=12 then replace(caredu,12,'Grade 12')
	when caredu=13 then replace(caredu,13,'Post-secondary, Vocational')
	when caredu=14 then replace(caredu,14,'University')
	when caredu=15 then replace(caredu,15,'Masters, Doctorate')
	when caredu=28 then replace(caredu,28,'Adult literacy')
	when caredu=29 then replace(caredu,29,'Religious Education')
	when caredu=30 then replace(caredu,30,'Other')
else
	null
end as 'Caregiver_Education',

case
	when carehead=1 then replace(carehead,1,'Caregiver is Household Head')
	when carehead=2 then replace(carehead,2,'Caregiver is Partner')
	when carehead=3 then replace(carehead,3,'Other')
else
	null
end as 'Caregiver-HH Head',

careage 'Caregiver_Age',

iif(caresex=1,'Male',iif(caresex=2,'Female',null)) 'Caregiver_Gender',

case
	when carerel=1 then replace(carerel,1,'Biological Parent')
	when carerel=2 then replace(carerel,2,'Non-Biological Parent')
	when carerel=3 then replace(carerel,3,'Grandparent')
	when carerel=4 then replace(carerel,4,'Uncle/Aunt')
	when carerel=5 then replace(carerel,5,'Sibling')
	when carerel=6 then replace(carerel,6,'Other-relative')
	when carerel=7 then replace(carerel,7,'Other-nonrelative')
	when carerel=8 then replace(carerel,8,'Partner/spouse of YL child')
	when carerel=9 then replace(carerel,9,'Father-in-law/Mother-in-law')
else
	null
end as 'Caregiver-Child Relationship',

iif(carecantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Caregiver_Literate',

careladder 'Caregiver_Ladder',

case
	when dadedu=0 then replace(dadedu,0,'None')
	when dadedu=1 then replace(dadedu,1,'Grade 1')
	when dadedu=2 then replace(dadedu,2,'Grade 2')
	when dadedu=3 then replace(dadedu,3,'Grade 3')
	when dadedu=4 then replace(dadedu,4,'Grade 4')
	when dadedu=5 then replace(dadedu,5,'Grade 5')
	when dadedu=6 then replace(dadedu,6,'Grade 6')
	when dadedu=7 then replace(dadedu,7,'Grade 7')
	when dadedu=8 then replace(dadedu,8,'Grade 8')
	when dadedu=9 then replace(dadedu,9,'Grade 9')
	when dadedu=10 then replace(dadedu,10,'Grade 10')
	when dadedu=11 then replace(dadedu,11,'Grade 11')
	when dadedu=12 then replace(dadedu,12,'Grade 12')
	when dadedu=13 then replace(dadedu,13,'Post-secondary, Vocational')
	when dadedu=14 then replace(dadedu,14,'University')
	when dadedu=15 then replace(dadedu,15,'Masters, Doctorate')
	when dadedu=28 then replace(dadedu,28,'Adult literacy')
	when dadedu=29 then replace(dadedu,29,'Religious Education')
	when dadedu=30 then replace(dadedu,30,'Other')
else
	null
end as 'Fathers_Education',

case
	when dadlive=1 then replace(dadlive,1,'Lives in the household')
	when dadlive=2 then replace(dadlive,2,'Does not live in household')
	when dadlive=3 then replace(dadlive,3,'Has died')
else
	null
end as 'Fathers_Location',

dadage 'Fathers_Age',

iif(dadcantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Father_Literate',

iif(dadyrdied>0,dadyrdied,null) 'Father_Death',

case
	when momedu=0 then replace(momedu,0,'None')
	when momedu=1 then replace(momedu,1,'Grade 1')
	when momedu=2 then replace(momedu,2,'Grade 2')
	when momedu=3 then replace(momedu,3,'Grade 3')
	when momedu=4 then replace(momedu,4,'Grade 4')
	when momedu=5 then replace(momedu,5,'Grade 5')
	when momedu=6 then replace(momedu,6,'Grade 6')
	when momedu=7 then replace(momedu,7,'Grade 7')
	when momedu=8 then replace(momedu,8,'Grade 8')
	when momedu=9 then replace(momedu,9,'Grade 9')
	when momedu=10 then replace(momedu,10,'Grade 10')
	when momedu=11 then replace(momedu,11,'Grade 11')
	when momedu=12 then replace(momedu,12,'Grade 12')
	when momedu=13 then replace(momedu,13,'Post-secondary, Vocational')
	when momedu=14 then replace(momedu,14,'University')
	when momedu=15 then replace(momedu,15,'Masters, Doctorate')
	when momedu=28 then replace(momedu,28,'Adult literacy')
	when momedu=29 then replace(momedu,29,'Religious Education')
	when momedu=30 then replace(momedu,30,'Other')
else
	null
end as 'Mothers_Education',

case
	when momlive=1 then replace(momlive,1,'Lives in the household')
	when momlive=2 then replace(momlive,2,'Does not live in household')
	when momlive=3 then replace(momlive,3,'Has died')
else
	null
end as 'Mothers_Location',

momage 'Mother_Age',

iif(momcantread=0,'No',iif(momcantread=1,'Yes',null)) 'Mother_Literate',

iif(momyrdied>0,momyrdied,null) 'Mother_Death',

case
	when headedu=0 then replace(headedu,0,'None')
	when headedu=1 then replace(headedu,1,'Grade 1')
	when headedu=2 then replace(headedu,2,'Grade 2')
	when headedu=3 then replace(headedu,3,'Grade 3')
	when headedu=4 then replace(headedu,4,'Grade 4')
	when headedu=5 then replace(headedu,5,'Grade 5')
	when headedu=6 then replace(headedu,6,'Grade 6')
	when headedu=7 then replace(headedu,7,'Grade 7')
	when headedu=8 then replace(headedu,8,'Grade 8')
	when headedu=9 then replace(headedu,9,'Grade 9')
	when headedu=10 then replace(headedu,10,'Grade 10')
	when headedu=11 then replace(headedu,11,'Grade 11')
	when headedu=12 then replace(headedu,12,'Grade 12')
	when headedu=13 then replace(headedu,13,'Post-secondary, Vocational')
	when headedu=14 then replace(headedu,14,'University')
	when headedu=15 then replace(headedu,15,'Masters, Doctorate')
	when headedu=28 then replace(headedu,28,'Adult Literacy')
	when headedu=29 then replace(headedu,29,'Religious Education')
	when headedu=30 then replace(headedu,30,'Other')
else
	null
end as 'HH_Head_Education',

headage 'HH_Head_Age',

iif(headsex=1,'Male',iif(headsex=2,'Female',null)) 'HH_Head_Gender',

case
	when headrel=0 then replace(headrel,1,'YL Child')
	when headrel=1 then replace(headrel,1,'Biological parent')
	when headrel=2 then replace(headrel,2,'Non-Biological parent')
	when headrel=3 then replace(headrel,3,'Grandparent')
	when headrel=4 then replace(headrel,4,'Uncle/aunt')
	when headrel=5 then replace(headrel,5,'Sibling')
	when headrel=6 then replace(headrel,6,'Other-relative')
	when headrel=7 then replace(headrel,7,'Other-nonrelative')
	when headrel=8 then replace(headrel,8,'Partner/spouse of YL child')
	when headrel=9 then replace(headrel,9,'Father-in-law/mother-in-law')
else
	null
end as 'HH_Head-Child_Relationship',

hhsize 'Household_Size',

wi_new 'Wealth_Index',

hq_new 'Housing_Quality_Index',

sv_new 'Access_to_Services_Index',

cd_new 'Consumer_Durables_Index',

iif(drwaterq_new=0,'No',iif(drwaterq_new=1,'Yes',null)) 'Safe_Drinking_Water_Access',

iif(elecq_new=0,'No',iif(elecq_new=1,'Yes',null)) 'Electricity_Access',

iif(toiletq_new=0,'No',iif(elecq_new=1,'Yes',null)) 'Sanitation_Access',

iif(cookingq_new=0,'No',iif(elecq_new=1,'Yes',null)) 'Cooking_Fuel_Access',

iif(aniany=0,'No',iif(aniany=1,'Yes',null)) 'HH_own_Livestock',

iif(ownlandhse=0,'No',iif(ownlandhse=1,'Yes',null)) 'HH_owns_Land',

iif(ownhouse=0,'No',iif(ownhouse=1,'Yes',null)) 'HH_own_House',

case
	when foodsec=1 then replace(foodsec,1,'we always eat enough of what we want')
	when foodsec=2 then replace(foodsec,2,'we eat enough but not always what we would like')
	when foodsec=3 then replace(foodsec,3,'we sometimes do not eat enough')
	when foodsec=4 then replace(foodsec,4,'we frequently do not eat enough')
else
	null
end as 'HH_Food_Situation_in_the_last_12_Months'

INTO Vietnam.Dataset
FROM dbo.Vietnam;


--Modification of Tables to add their respective country as a column for ease of analysis

ALTER TABLE Ethiopia.Dataset
ADD Country VARCHAR(200);
UPDATE Ethiopia.Dataset SET Country = 'Ethiopia'

ALTER TABLE India.Dataset
ADD Country VARCHAR(200);
UPDATE India.Dataset SET Country = 'India'

ALTER TABLE Peru.Dataset
ADD Country VARCHAR(200);
UPDATE Peru.Dataset SET Country = 'Peru'


ALTER TABLE Vietnam.Dataset
ADD Country VARCHAR(200);
UPDATE Vietnam.Dataset SET Country = 'Vietnam'


--Creation of ChildMonitor Consolidated Table from Ethiopia, India, Peru & Vietnam Tables using Union All

SELECT *
INTO ChildMonitor.ConsolidatedTable
FROM (SELECT * FROM Ethiopia.Dataset UNION ALL SELECT * FROM India.Dataset UNION ALL SELECT * FROM Peru.Dataset UNION ALL
 SELECT * FROM Vietnam.Dataset) as Tmp
 WHERE ChildID <> 'childid'

 
-- Viewing the created ChildMonitor.ConsolidatedTable
SELECT * FROM ChildMonitor.ConsolidatedTable

--Table Analysis

--1. Basic Information: Basic details concerning the child's background in the most recent round, 5

SELECT ChildID,[Cohort],[Sentinel_SiteID],[Residential_Area],[Residential_Region],[Attended_All_Rounds],Attended_Round,Gender,[First_language],[Ethnic_Group],Religion,[Age],[Has_Ever_Married/Cohabited],[Age at Marriage/Cohabitation],[Has_a_Child],Deceased,[Date of interview],Country

INTO [ChildMonitor].[ChildInfo]
FROM [ChildMonitor].[ConsolidatedTable]
WHERE [Round_of_Survey] = 5
ORDER BY ChildID



 --2. Health: The child's health and well-being situation
 
SELECT ChildID,[Cohort],[Round_of_Survey],[Gender],[Age],[BCG Vaccination],[Measles Vaccination],[Polio Vaccination],[DPT Vaccination],[HIB Vaccination],[Serious_Illness_Since_Last_round],[Serious_injury_since_last_round],[Long-term_Health_Problem],[Permanent_Disability],[Health_vs_Peers],[Health_Condition],[Well-being(9-step Ladder)],[Frequency of Smoking],[Consumes Alcohol Weekly],Country

INTO [ChildMonitor].[Health]
FROM [ChildMonitor].[ConsolidatedTable]
ORDER BY Round_of_Survey



 --3. --Daily Schedule: A summary of the events in a normal day in the life of a child.

 SELECT ChildID,Cohort,[Round_of_Survey],Sleeping,[Caring_for_family],Chores,[Paid_Activity],School,Studying,[Leisure_Activities],[Work CommuteTo&Fro(in mins)],[School CommuteTo&Fro(in mins)],Country

 INTO [ChildMonitor].[DailySchedule]
 FROM [ChildMonitor].[ConsolidatedTable]
 ORDER BY Round_of_Survey


  --4.Education and Skills: Information regarding the child's education and skills

 SELECT ChildID,Cohort,[Round_of_Survey],[School CommuteTo&Fro(in mins)],[Pre-primary_School],[Age_@Grade1],[Currently_Enrolled],[Current_Grade],[School_Type],[Travel Time to School(in min)],[Reading_Level],[Writing_Level],Literate,Country

 INTO [ChildMonitor].[EducationandSkills]
 FROM [ChildMonitor].[ConsolidatedTable]
 ORDER BY Round_of_Survey
 

   --5.Family Members and Background: Details on the child's family members

 SELECT ChildID,Cohort,[Round_of_Survey],[Sentinel_SiteID],CommunityID,[Residential_Area],[Residential_Region],[First_language],[Ethnic_Group],Religion,[Household_Size],[Fathers_Location],[Fathers_Age],[Father_Death],[Father_Literate],[Fathers_Education],[Mother_Age],[Mother_Death],[Mother_Literate],[Mothers_Education],[Caregiver_Age],[Caregiver_Gender],[Caregiver-HH Head],[Caregiver_Literate],[Caregiver_Education],[Caregiver-Child Relationship],[Caregiver_Ladder],[HH_Head_Age],[HH_Head_Gender],[HH_Head_Education],[HH_Food_Situation_in_the_last_12_Months],[HH_Head-Child_Relationship],[HH_owns_Land],[HH_own_House],[HH_own_Livestock],Country

 INTO [ChildMonitor].[FamilyBackground]
 FROM [ChildMonitor].[ConsolidatedTable]
 ORDER BY Round_of_Survey


--6. Wealth index:
SELECT ChildID,Cohort,[Round_of_Survey],[Wealth_Index],[Electricity_Access],[Safe_Drinking_Water_Access],[Cooking_Fuel_Access],[Sanitation_Access],[Housing_Quality_Index],[Access_to_Services_Index],[Consumer_Durables_Index],Country

INTO [ChildMonitor].[WealthIndex]
FROM [ChildMonitor].[ConsolidatedTable]
ORDER BY Round_of_Survey


 --Creating Primary Key, ChildID on all tables

--First the ChildInfo table was altered to make the ChildID column not null

ALTER TABLE [ChildMonitor].[ChildInfo] ALTER COLUMN [ChildID] varchar(50) NOT NULL

ALTER TABLE [ChildMonitor].[ChildInfo] ADD CONSTRAINT PK_Info PRIMARY KEY ([ChildID]);

ALTER TABLE [ChildMonitor].[Health] ADD CONSTRAINT FK_HealthInfo FOREIGN KEY ([ChildID]) REFERENCES [ChildMonitor].[ChildInfo]([ChildID]);

ALTER TABLE [ChildMonitor].[DailySchedule] ADD CONSTRAINT FK_DailyInfo FOREIGN KEY ([ChildID]) REFERENCES [ChildMonitor].[ChildInfo]([ChildID]);

ALTER TABLE [ChildMonitor].[EducationandSkills] ADD CONSTRAINT FK_EduInfo FOREIGN KEY ([ChildID]) REFERENCES [ChildMonitor].[ChildInfo]([ChildID]);

ALTER TABLE [ChildMonitor].[FamilyBackground] ADD CONSTRAINT FK_FamilyInfo FOREIGN KEY ([ChildID]) REFERENCES [ChildMonitor].[ChildInfo]([ChildID]);

ALTER TABLE [ChildMonitor].[WealthIndex] ADD CONSTRAINT FK_WealthInfo FOREIGN KEY ([ChildID]) REFERENCES [ChildMonitor].[ChildInfo]([ChildID]);





 --Report Creation with the use of Views

--1. A report on children in Round 5 who are not enrolled in school and whose Household heads have not passed Grade 12

CREATE VIEW ChildMonitor.CompareHH_Head_Education
AS
SELECT HH_Head_Education AS [Household`s Head Level of Education], COUNT(CASE E.Country WHEN 'Ethiopia' THEN 1 END) AS 'Ethiopia', COUNT(CASE E.Country WHEN 'India' THEN 2 END) AS 'India', COUNT(CASE E.Country WHEN 'Peru' THEN 3 END) AS 'Peru', COUNT(CASE E.Country WHEN 'Vietnam' THEN 1 END) AS 'Vietnam'
FROM [ChildMonitor].[FamilyBackground] AS F
LEFT JOIN [ChildMonitor].[EducationandSkills] AS E ON F.ChildID=E.ChildID
WHERE HH_Head_Education != '' AND HH_Head_Education != 'None' AND HH_Head_Education LIKE 'Grade%' AND F.Round_of_Survey = '5' AND E.Round_of_Survey = '5' AND E.Currently_Enrolled = 'No'
GROUP BY HH_Head_Education

--2. A report on the health condition of children in round 5 who has atleast one health issue

CREATE VIEW ChildMonitor.CompareHealth_Conditions
AS
SELECT Health_Condition AS [Health Condition], COUNT(CASE Country WHEN 'Ethiopia' THEN 1 END) AS 'Ethiopia', COUNT(CASE Country WHEN 'India' THEN 2 END) AS 'India', COUNT(CASE Country WHEN 'Peru' THEN 3 END) AS 'Peru', COUNT(CASE Country WHEN 'Vietnam' THEN 1 END) AS 'Vietnam'
FROM [ChildMonitor].[Health]
WHERE Health_Condition <> 'NULL' AND Round_of_Survey = '5' AND (Serious_Illness_Since_Last_round = 'Yes' or Serious_injury_since_last_round = 'Yes' or [Long-term_Health_Problem] = 'Yes' or Permanent_Disability = 'Yes')
GROUP BY Health_Condition

--3. A report on the distribution of children in round 5 with a minimum household size of 4 and lack access to at least one essential amenity grouped by Cohort

CREATE VIEW ChildMonitor.CompareLack_Amenities
AS
SELECT F.Cohort, COUNT(CASE F.Country WHEN 'Ethiopia' THEN 1 END) AS 'Ethiopia', COUNT(CASE F.Country WHEN 'India' THEN 2 END) AS 'India', COUNT(CASE F.Country WHEN 'Peru' THEN 3 END) AS 'Peru', COUNT(CASE F.Country WHEN 'Vietnam' THEN 1 END) AS 'Vietnam'
FROM ChildMonitor.[FamilyBackground] F LEFT JOIN [ChildMonitor].[WealthIndex] W
ON F.ChildID = W.[ChildID] 
WHERE Household_Size >= '4' AND F.Round_of_Survey = '5' AND W.Round_of_Survey = '5' AND (Electricity_Access = 'No' OR Safe_Drinking_Water_Access = 'No' OR Cooking_Fuel_Access = 'No' or Sanitation_Access = 'No')
GROUP BY F.Cohort

--4. A Report on children not currently enrolled in school but spend at least an hour per day in a paid work 

CREATE VIEW ChildMonitor.ComparePaidWork
AS 
SELECT E.Cohort, COUNT(CASE E.Country WHEN 'Ethiopia' THEN 1 END) AS 'Ethiopia', COUNT(CASE E.Country WHEN 'India' THEN 2 END) AS 'India', COUNT(CASE E.Country WHEN 'Peru' THEN 3 END) AS 'Peru', COUNT(CASE E.Country WHEN 'Vietnam' THEN 1 END) AS 'Vietnam'
FROM ChildMonitor.[EducationandSkills] E
LEFT JOIN [ChildMonitor].[DailySchedule] D
ON E.ChildID = D.[ChildID]
WHERE Paid_Activity >= '1' AND E.Round_of_Survey = '5' AND D.Round_of_Survey = '5' AND E.Currently_Enrolled = 'No'
GROUP BY E.Cohort

--5. A report on children currently enrolled in schools without any government funding grouped by Cohort

CREATE VIEW [ChildMonitor].CompareNoGovtFunding
AS
SELECT Cohort, COUNT(CASE Country WHEN 'Ethiopia' THEN 1 END) AS 'Ethiopia', COUNT(CASE Country WHEN 'India' THEN 2 END) AS 'India', COUNT(CASE Country WHEN 'Peru' THEN 3 END) AS 'Peru', COUNT(CASE Country WHEN 'Vietnam' THEN 1 END) AS 'Vietnam'
FROM [ChildMonitor].[EducationandSkills]
WHERE Round_of_Survey = '5' AND [Currently_Enrolled] = 'Yes' AND [School_Type] != 'NK' AND [School_Type] != 'N/A' AND [School_Type] != 'Govt funded' AND [School_Type] != 'Public(Partly Govt-Funded' AND [School_Type] != 'public(government)'
GROUP BY Cohort


--6. A report that shows the Household's food situation for children in round 5 and their respective countries

CREATE VIEW [ChildMonitor].CompareHHFoodSituation
AS
SELECT [HH_Food_Situation_in_the_last_12_Months] AS [Household Food Situation], COUNT(CASE Country WHEN 'Ethiopia' THEN 1 END) AS 'Ethiopia', COUNT(CASE Country WHEN 'India' THEN 2 END) AS 'India', COUNT(CASE Country WHEN 'Peru' THEN 3 END) AS 'Peru', COUNT(CASE Country WHEN 'Vietnam' THEN 1 END) AS 'Vietnam'
FROM [ChildMonitor].[FamilyBackground]
WHERE Round_of_Survey = '5' AND [HH_Food_Situation_in_the_last_12_Months] != '' AND [HH_Food_Situation_in_the_last_12_Months] != 'None'
GROUP BY [HH_Food_Situation_in_the_last_12_Months]



--Creating a stored procedure that searches for children according to their gender, FindGender

Create Proc FindGender 
(@Gender VARCHAR(MAX))
As
Begin 
Select Childid, Gender 
From ChildMonitor.ChildInfo
Where Gender LIKE @Gender+ '%'  
END

--Executing the above FindGender stored procedure to find children that are male
EXEC FindGender male


--TRIGGER

--Making a Trigger that prevents deletion of row from the Primary Key Table
CREATE TRIGGER ChildMonitor.Prevent_Delete ON ChildMonitor.ChildInfo
INSTEAD OF DELETE
AS
IF EXISTS (SELECT * FROM ChildMonitor.ChildInfo)
DECLARE @ErrorMessage NVARCHAR(200)
SELECT	@ErrorMessage = 'A primary key is in this table'
BEGIN
RAISERROR( @ErrorMessage, 16, 1 )
ROLLBACK TRANSACTION
END;
GO


--Checking the created Trigger by trying to delete Ethiopia records from ChildMonitor.ChildInfo

DELETE ChildMonitor.ChildInfo WHERE ChildID LIKE 'ET%'


 --Creating Functions


 --****A Scalar Function that gives a brief text about a child when Child ID and Country are specified
CREATE FUNCTION [ChildMonitor].[ChildDetailsPerCountry] 
(@childid NVARCHAR(50), 
@country NVARCHAR(200))
RETURNS NVARCHAR (250)
AS
BEGIN
RETURN( SELECT ([ChildID]+ iif([Attended_All_Rounds]='yes','attended all rounds','did not attend all rounds')+' and is a child from '+[Ethnic_Group]+', '+' in '+[Residential_Area]+' '+Residential_Region+'. '+iif([Gender]='male','He','She')+
+iif([Currently_Lives_in_Household]='yes','lives','does not live')+' with family and '
+iif([Pre-primary_School]='yes','has attended pre-primary school','has not attended pre-primary school')+' and '+iif([Currently_Enrolled]='Yes','is currently enrolled in a school','is not currently enrolled in a school'))
FROM ChildMonitor.ConsolidatedTable
WHERE [Country] = @country
and [ChildID]= @childid)
END;


--FUNCTIONS

--A Table Valued Function that for each round specified, shows the different cohorts and the number of children in each cohort.
CREATE FUNCTION ChildMonitor.Cohort
(
@round INT
)
RETURNS TABLE
AS
RETURN (SELECT Cohort, COUNT([ChildID]) 'Number of children'
FROM [ChildMonitor].[EducationandSkills]
WHERE [Round_of_Survey] = @round
GROUP BY Cohort)

 -- A function that converts the child age from months to years
CREATE FUNCTION AgeConverter (@Age VARCHAR)
RETURNS INT
AS
BEGIN
RETURN @Age/12
END











