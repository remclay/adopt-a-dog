# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) --> Models: User class, Dog class, Breed class and DogBreed class

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts) --> A user has_many dogs and has_many breeds, through dogs. A dog has_many dog_breeds and has_many breeds, through dog_breeds. A breed has_many dog_breeds, has_many dogs, through dog_breeds and
has_many users, through dog_breeds.

- [x] Include user accounts
- [x] Ensure that users can't modify content created by other users --> Helper methods (logged_in? and current_user) utilized in Controllers and Views ensure only the user who posted the dog can modify it.

- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying --> DogsController includes routes for CRUD.

- [x] Include user input validations --> User class validates_presence_of username, email and password and validates that username is unique.

- [x] Display validation failures to user with error message (example form URL e.g. /posts/new) -->

- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
