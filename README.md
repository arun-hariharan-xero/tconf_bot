# tconf_bot

### What is this?
This is a slack bot, developed as a hackathon-type project in under 48 hours, targeted towards the attendees of the first Testing conference in Melbourne - the [Tconf](www.tconf.io).  The general idea is to let them ask questions to the bot regarding the conference, and bot will respond back with appropriate answer. 


### Where does the bot get its answers from?
If the answers can be found from the website, bot will scrape it and respond. Else it will do a keyword matching to find if any built in answers are suitable. If nothing works, it flies off to [Bing](www.bing.com) for answers and returns them the first search result. 


### What is being updated?
Currently the bot's capabilities are quite limited and the keyword searching can be vastly improved. That is what I am working on currently. The following is the approximate path of improvement for the bot.


1. Refactor the code with appropriate classes / data structures and Write Tests
2. Implement Machine Learning for the bot
   
   Currently I am testing this locally with Bayesian Classifiers and Madeleine, with the scarce libraries that are in Ruby. The idea is to slowly get rid of all custom string matching, stop words, stemmers, tokenizers and text similarity with available gems to make things easier. This will take some time to see the light, but I am currently aiming to hit mid-2017 for a decent bot that learns from the questions and responds appropriately. 

3. Take it outside of just Tconf and make it usable with *any* slack channel after enough training and testing. 


### What's the stack behind this?
The bot is developed using Ruby, hosted in Heroku. The tests are written using Rspec. 

### How do I run this? 
1. Clone the repo and bundle install
2. Create (or sign in to) a Heroku account. Follow [these](https://devcenter.heroku.com/articles/git) steps to push your repo to Heroku
3. Go to your slack channel's [Outgoing Webhook](https://slack.com/services/new/outgoing-webhook) and enter your uploaded app's heroku address (http://<APP-NAME>.herokuapp.com/gateway), along with other details.
4. Voila. Now go the the slack channel and ask any question to the bot. Make sure to enter the trigger words that you mentioned in the previous steps.


### Example - in the slack channel

* **Tconf, tell me a joke**

   *What is the stupidest animal in the jungle? A Polar bear*

* **Tconf, lol that was funny.**

   *In our world, we don't laugh for that.*

* **Huh, you are quite mean, aren't you?**

   *Haters gonna hate!!!*
