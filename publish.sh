#!/bin/bash

git push origin master &&
git push heroku master &&
heroku run rails db:migrate
