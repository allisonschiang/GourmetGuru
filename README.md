# GourmetGuru

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
* Click this video to be directed to the voiced demo!

[<img src="https://github.com/allisonschiang/GourmetGuru/blob/main/youtubeScreenShot.png" width="50%">](https://www.youtube.com/watch?v=Kt487pmlbyo "Video Demo Walkthrough")

* Here is just a quick gif walkthrough as well

<img src='https://github.com/allisonschiang/GourmetGuru/blob/main/WalkthroughGif.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


### Description
This app sets out to allow allow users to throw away their cookbook! Users will open the app to all of their recipes displayed to them, and in a few easy clicks they can add any recipe their heart desires!

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Food and Drink
- **Mobile:** It involves REAL-TIME usage when someone is in the kitchen or going grocery shopping, which most people don't have their laptops during
- **Story:** A lot of people struggle with making new, exciting food, so we wanted to make an app to help people be inspired to make new foods.
- **Market:** The market is cooks and people wanting to cook more or digitally store their recipes. The market is pretty big because everyone needs to eat, and a lot of people want to improve their cooking.
- **Habit:** People use the app whenever they want to cook, which could be every couple of days, or even daily.
- **Scope:** First plan is just to make this a basic recipe app, future plans may envolve letting users take pictures of their ingredients and using an AI implemented through some type of api, to give recipe suggestions? 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users must be able to add recipes
* Users must be able to save recipes (peristant data)
* Users must be able to view said saved recipes

**Optional Nice-to-have Stories**

* Search saved recipes by title
* Search saved recipes by ingredient

### 2. Screen Archetypes

* Recipe Library Screen
   * Users should be able to see up to 100 recipes
   * Users should be able to scroll down
   * Users should be able to see preview of recipe with name and cooktime
   * Users should be able to click on recipe
* Recipe Content Screen
   * User should be able to see recipe name 
   * User should be able to see ingredients
   * User should be able to see directions
* Creation Screen
   * User should be able to type into textbox
   * User should be able to save text
   * User should be able to add personal photo's


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Recipe Library
* Recipe Creation
* Recipe Content

**Flow Navigation** (Screen to Screen)

* Recipe library
    => Recipe Content (of the recipe clicked)
    => Creation 
* Recipe Content
    => Recipe Library (after finishing reading)
* Creation
    => Recipe Library (after finishing creation)

## Wireframes
<img src="https://github.com/allisonschiang/GourmetGuru/blob/main/wireframeFIN.png" width=600>


## Schema 
### Models
<img src="https://github.com/allisonschiang/GourmetGuru/blob/main/models.png" width=600>

