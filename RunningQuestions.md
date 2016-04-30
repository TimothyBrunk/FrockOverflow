# Running Questions, Unresolved Issues, What we have so far
### Here's what we have so far guys:
* User can log in (as one of us three). If login fails, user will be logged on as "guest" of type "0" (no priviledges).
* Upon login, you go to the results.jsp page. Everything is on this page now, in totally unfancified html.
* A message at the top tells you who you are logged in as, shows you the questions you have asked to date, and presents some buttons.
* There are four buttons allowing you to view questions of different statuses. All, Posted (unanswered), Answered, and Resolved. The Resolved button doesn't work yet, because statuses aren't getting updated to resolved yet.
* When you press one of these, you get a list of questions that match the status.
* In the list of questions, you have different options depending on your user priviledges. You can answer a question if you are not 'guest'. You can also view all answers that have been posted for that question, if there are any.
* When an answer is posted for a question, the question's status changes to 'Answered'.
* If you are looking at a list of answers, and the question is one that you yourself wrote, you have the option to 'Accept' the answer. At that point the answer's status changes to 'Accepted'.

Yeah that's pretty much it for now.

### Here's some things we still need to do:
* We still need a new user form. Probably on the index page where we have the login option, pop in a form there. When it's submitted, they can be automatically logged in as that user at that point. It'd be nice to have some validation for that, but eh.
* We need to update Question status to 'Resolved' once an answer for that question has been accepted. At least, that's how I'm envisioning it would work.
* It'd be nice to have options for the user to view all their own questions, particularly questions that have been answered but not yet resolved.
* We should have the capability to sort questions by date. I think they're all being presented in id order right now.
* We should also have the capability to sort by user, like 'Show me all the questions written by Brenton' or 'Show me all the answers written by Tim'. There is a method in the DAO to get questions by user, so we could add a search form with a dropdown menu containing user names.
* Timestamps are of type DATE in the DB, initialized as java.util.Date in the ORM. When displayed, date is shown but not time. How do we add the time?
* We need to be able to add snippets. I know how to do this, so I will take care of it.
* It's super ugly right now. I added a couple lines to the bootstrap.css just to change the background color of the question blocks, but that is it. I'm not too too worried about looks right at this moment, more about flow. If you want to change anything about the flow of how questions and answers are presented, go right on ahead.
* One more thing, I changed a lot of files, including the database. So make sure you dump your dump!
