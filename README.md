# FastIT: Magic
Showcasing some Angular's magic!

## Set up
You'll need `nodejs`, `npm` and `git`.

    npm install

## Running the development server

    npm start

The app is live at http://localhost:8000.

## Steps

### 1. Hello world
    git co start

### 2. A new page
    git co routing
- A new route defined in [routes.coffee](config/routes.coffee)
- A new template: [deck.jade](views/deck.jade)

### 3. Links
    git co links
- A new link to go back home in the menu
- A new link to go to the deck

### 4. Controller and displaying data
    git co controller
- New [deckController](controllers/deck.coffee)
- Declaring the controller for the route in [routes.coffee](config/routes.coffee)
- Passing data to the view using `$scope`
- Displaying data in the view with `{{ }}`
- Prettifying the output with a filter ()`{{ some_var | filter}}`)

### 5. Using directives
    git co ng-repeat
- A directive is a specific Angular's HTML element or attribute
- Using `ng-repeat` to display a list in the [view](views/deck.jade)

### 6. Custom directive
    git co card-directive
- New `card` directive in [card.coffee](directives/card.coffee)
- New associated view in [card.jade](views/card.jade)
- Use of the directive in in the [deck view](views/deck.jade)

### 7. Two-way-binding
    git co card-count
- New `input` that dynamically changes the data in [card.jade](views/card.jade)
