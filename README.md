# MySpot - User app
Our project helps people to find and book one spot for their vehicles on a parking lot. Our team members are Santiago Agudelo, and myself. As an engineering problem, we wanted to focus on 2 things: creating a cross-platform mobile solution, and also sourcing a reliable and sophisticated API. Santiago worked on the API and the landing page and I worked on the two mobile apps (one for the user and one for the parking lot admin) and DevOps.
---> This is the user App <---

## Installation
The app will be soon on the google playstore and app store.


#### Functionalities of this Admin app:
* Allows the user to find a parking lot without registration
* User login
* User signup
* If the user is loged, the user will be able to book one spot


## Story
I know you probably have been in this situation: There is one event (concert, football game, etc) you want to go to that event in your vehicle (car or motorcycle) but when you get there, you are not able to find one spot in any parking lot near to the event.\
Or this one: you need to go to a new place and you need a place for your vehicle, but in google maps, you don’t find one near to the place, then you arrive and find one just in front but is full.\
I choose this project because it would be awesome to have all the information before leaving home.

## Technical details
### Backend
Santiago was in charge of the back end, he is great with Node.js so that was an easy choice, but we needed something more, we choose Express.js to use it with Node because it is a really powerful framework and it has everything we need to build the API.\
So far so good but what about the user and parking lot info? we choose MongoDB to store it because to create the markers for the map we need the latitude and longitude and Mongo has support for geospatial data out of the box. But wait you should not store the user info in plain text, you are right for that we used Bcrypt and Mongoose to connect the DB and the node App.


### Mobile
I was in charge of mobile apps, but I never developed one before (to be honest before this project I hated the frontend development), the fact that I never developed mobile apps before was the hardest challenge for this project at least for me, it was hard technically and mentally because of the short amount of time to finish an MVP, and I had to learn one new language, develop two apps and take care of the DevOps.\
We choose flutter for mobile apps because the apps that are built with it look great on both platforms (IOS and Android) also run better than if we used React (the decision was made after a research and approved by one engineer).\
We had one week and a half to build the project, so after we pick flutter I expended the first six or seven days learning how to use flutter and Dart which is the language used in flutter (I finish one Udemy course and get the certification).\
Hands-on with the code, the app needs to display the map, a search box for the place with auto-complete suggestions, custom map markers with the information fetched of the API, login page with front and back end validation, logout, sign up with front validation and be able to book the spot.\
Just for the map, I’m using 6 google APIS.


## DevOps
For the database, we choose the Atlas compass which comes with one master and two slaves, an easy choice!\
We deployed the Backend and the landing page using one EC2 instance in AWS running Ubuntu with Nginx.\
The app was stopping from time to time, I solved this using PM2.


## Demo of the app running
(https://www.youtube.com/watch?v=x-54XFii-Fw&t=4s)

## More info 
(https://medium.com/@tomasmontoya123/my-spot-mvp-acfb24e47dac)

## My Spot App for the Admin
(https://github.com/thomasmontoya123/MySpot_Admin)

## Author
Thomas Montoya - [Github](https://github.com/thomasmontoya123) / [Linkedin](https://www.linkedin.com/in/thomas-montoya/)

## License
MIT