# Exhibition Platform

A web-based platform designed to manage and showcase exhibitions, developed as part of a university coursework project.

# Overview

The exhibition platform allows users to create, manage, and explore various exhibitions. It provides functionalities for organizers to set up exhibitions and for visitors to browse through them.
Application allows users to look up for ongoing or upcoming exhibitions, read the description, look at the exhibits online and decide whether they want to visit it offline.

# Features

* User authentication and authorization

* Exhibition creation and management

* Search and filter exhibitions

* Responsive design for various devices

* Mailer w/ cron job so the users will be notified if any exhibition from their favourites is going to start in 3 days

# Tech Stack

* Frontend: HTML, CSS, JavaScript

* Backend: Ruby on Rails

* Database: PostgreSQL

* Deployment: Docker

# Installation

1. Clone the repository:
```
git clone https://github.com/Setoju/exhibition_platform.git
cd exhibition_platform
```
2. Install dependencies:
```
bundle install
```
3. Set up the database:
```
rails db:create
rails db:migrate
rails db:seed
```
4. Set up .env variables
5. Run the server:
```
rails servers
```
