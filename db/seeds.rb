# Seed the database with `rake db:seed`

# Users
peter = User.create({username: "Peter D", email: "peter@gmail.com", password: "enter58"})
kate = User.create({username: "Kate Greenburgh", email: "kate_dog_lover@gmail.com", password: "adoptdontshop"})
lou = User.create({username: "Miss Lou", email: "louise_grant@yahoo.com", password: "931passw0rd"})
john = User.create({username: "john@example.com", email: "john@example.com", password: "testing"})

# Breeds
maltese = Breed.create(name: "Maltese")
retriever = Breed.create(name: "Golden retriever")
husky = Breed.create(name: "Husky")

# Dogs
Dog.create({name: "Rover", age: "8", user_id: "#{peter.id}", breed_ids: ["#{husky.id}"], description: "Rover loves playing fetch and requires a lot of attention. He is a medium-high energy dog. He is available for adoption right away."})
Dog.create({name: "Fido", age: "2.5", user_id: "#{peter.id}", breed_ids: ["#{retriever.id}"], description: "Comfortable around other dogs and most cats. Fido is still being trained, but can already sit, fetch and stay! Please email me for pictures or to arrange a time to meet this charming boy."})
Dog.create({name: "Prinny", age: "6", user_id: "#{kate.id}", breed_ids: ["#{maltese.id}"], description: "She simply loves attention, will sit at your feet all day and does not require a lot of exercise."})
