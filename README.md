Integrating video chat tool to your website or app is not nearly as hard as it used to be. 

WebRTC allows peer-to-peer in-browser video calls relatively easy for advanced developers. Luckily, there are other options for beginners and intermediate level developers.

In this tutorial, we will be using the Daily.co API to create a ‘tutoring website for devs’ that will work with embedded video chat sessions in our Rails app. We are building from the ground-up, if you already have an app, you might want to start in step 6.

1. Let’s create our rails app and cd in the folder

fig 1.1

$ rails _5.2.4.1_ new videochat
$ cd videochat

In this tutorial, we will focus on how to integrate video chat on a website. Check out my other tutorials where we create a website to host webinars. (with users, logins, events manager, attendances).

2. Generate scaffold for subjects (topics to teach)
We are going to need a form and a database to add and store the topics and teachers we have in our school, we’ll generate a rails scaffold to take care of that for us. This will create the views, the controller, routes, and migrations for our subjects.

fig 2.1
$ rails generate scaffold Subject title:string teacher:string
$ rails db:migrate
$ rails server

Once the server is running, let’s go to http://localhost:3000/subjects and add a few subjects and teachers.

fig 2.2. visit localhost:3000/subjects to add a few subjects and teachers

3. Create our controllers
Let’s create a controller ‘Welcome’ with the index method that will display our static landing page, and a controller ‘Sessions’ have the show method that will show the sessions that are currently available and include the video chat interface.

fig 3.1. Close the running server with ctrl+c and run the following commands
$ rails generate controller Welcome index
$ rails generate controller Sessions show
4. Define the routes
Open the app/config/routes.rb file and set the routes for the pages we just created.
fig 4.1

5. Let’s add some style
I like creating good looking projects. if you do too, let’s include bootstrap to beautify it. It’s recommended to include the gem, but for practicality, we will be using the CDN.
Let’s go to app/views/layout/application.html.erb and add these tags for stylesheets and scripts before the </head> closing tag. You can find the most recent version in getbootstrap.com.

fig 5.1


In the same file, we are going to render the navbar that will be created in the next step. Add this embedded ruby tag right after <body> tag.


fig 5.2. Add a class “bg-blue” to the body tag to turn the website blue. It must look like this
<body class="bg-blue">
<%= render 'layouts/navbar' %>
<%= yield %>
</body>


Now let’s create a navbar for decoration, create a file ‘_navbar.html.erb’ in the folder app/views/layouts/ with the following code (you can get other styles and colors from getbootstrap.com or even build your own).
fig 5.3

Next, we will fill out the app/views/welcome/index.html.erb with a couple of images and information to invite users to try our video chat website.

Don’t worry if you don’t understand what’s going on, most of the code is bootstrap default classes, it looks confusing at first glance, but it’s really simple to understand and use once you read the docs.
fig 5.4

And last, add a background image and a custom color to the app/assets/stylesheets/application.css file
fig 5.5

.bg-blue {
background-color: #6610f2
}
.bgbg {
background-image: url('https://github.com/mkezmkez/tech-me/blob/master/app/assets/images/banne.png?raw=true');
background-position: 100% 0;
background-repeat: no-repeat;
}


6. Embedding and styling the Daily.co video chat interface
We are now going to integrate the video into our project. You can use this account for testing (username: tutorial@tutorial.com, pass: tutorial123) or create your own for free at Daily.co
We are going to be using the Sessions controller show method, to display all the available subjects and teachers trough the variable @subjects and while we are there, let’s add a @clicked variable. We’ll need it later.
Fill your ‘show’ method in app/controllers/sessions_controller.rb


fig 6.1
def show
  @subjects = Subject.all
  @clicked = params[:subject]
end

Next, go to the app/views/sessions/show.html.erb to add the code for the calls.

First, we add some HTML and bootstrap classes to guide our visitors on what to do next. We are listing all the subjects we previously created. All of the sessions will use the same room, for now, to keep it simpler, but multiple rooms can be created with the click of a button with the RESTful API.

fig 6.2

Now, we include the script that will embed the Daily.co video chat right below the previous code. The video chat appears on the bottom-right side of the screen by default. This is the basic script to embed the call. You can leave it like that, or tweak it to fit your needs.

(Fig. 6.3)

<script crossorigin src="https://unpkg.com/@daily-co/daily-js"></script>
<script>
callFrame = window.DailyIframe.createFrame();
callFrame.join({ url: 'https://tutorial.daily.co/hello' })
</script>

Congratulations! You have a working video chat interface now.
Fire up the rails server to check it out!

7. Final touches & further customization
Right now the video starts automatically when hitting sessions. But I prefer to start it when clicking one of the subjects. This will join the room we defined in the callFrame.join({‘this room’}). You can define them manually for each link, or create them trough your sessions controller via the Daily.co API (which will be covered in another tutorial, this tutorial uses the tutorial URL for all rooms).

We can customize the script provided by Daily to match our needs. Change the code in fig 6.3 to the one in fig 7.1
We are adding the following customizations to the script:
When we selected a subject and clicked on it, it sends the subject to the controller and returns true, which gives the instruction to run the script with the <% if @clicked %>
We added a javascript conditional if the width of the window is less than 400px, we would return the fullscreen video, on a cellphone screen, for example.
If it is bigger than 400px, we will run the video chat script in 50% of the width, 100% height which will suit better for bigger horizontal screens.

Conclusion
In a few steps, we were able to build a beautiful working app for video, Your app is ready to be deployed, I recommend using Heroku, it’s free and it makes it easy to deploy, but that’s outside the scope of this tutorial.
If you want to take a look at my live demo with integrated API room creation, you can find it in https://tech-me.herokuapp.com/
Let’s connect, I’m on twitter as twitter.com/mkezmkez.
Images under freepik.com free license.
