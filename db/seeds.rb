# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all

Category.create!([{
    name: "Laptop",
},
{
    name: "Phone",
},
{
    name: "Tablet",
},
{
    name: "Watch",
},
{
    name: "Power Bank",
},
{
    name: "Earphone",
}
])
  
p "Created #{Category.count} categories"

User.destroy_all

User.create!([{
    name: "Ko Ko",
    email: "koko@gmail.com",
    password: "12345",
    password_confirmation: "12345",
    bio: "lorem ipsum",
},
{
    name: "Ma Ma",
    email: "mama@gmail.com",
    password: "12345",
    password_confirmation: "12345",
    bio: "lorem ipsum",
},
{
    name: "Mg Mg",
    email: "mgmg@gmail.com",
    password: "12345",
    password_confirmation: "12345",
    bio: "lorem ipsum",
},
])
  
p "Created #{User.count} users"

Post.destroy_all

Post.create!([{
    title: "Beach Globe Paradise",
    category_id: 1,
    user_id: 1,
    description: "Amber's glow spans skies — write us some place nice, she said I plop chairs on a beach somewhere — one hand grips a frosty margarita and the other well, the other flips off life violently forbidden contestants on..."
},
{
    title: "The Complete Guide to Poetry on Medium",
    category_id: 2,
    user_id: 2,
    description: "“She's mad but she's magic; there's no lie in her fire.” — Dear Mama, I love you. Throughout our 27 years together on this Earth, I’ve never once told you this one, simple fact — but here it is, out in the open, o..."
},
{
    title: "How to Use .each_with_object in Ruby",
    category_id: 3,
    user_id: 3,
    description: "A quick overview of the method .each_with_object in Ruby. — Have you ever created an empty hash for use with an each function? You might have thought to yourself “there must be an easier way to do this.” Your instincts are correct — there is! Let's say we have an array: array..."
},
{
    title: "Don't Just Set Goals. Build Systems",
    category_id: 4,
    user_id: 3,
    description: "The Secret To Happiness And Achieving More — · The problem with setting goals ∘ #1 The positive fantasy ∘ #2 The outcomes first trap ∘ #3 The failure state trap · What are systems? · Why you need systems"
},
{
    title: "52 things I learned in 2022",
    category_id: 5,
    user_id: 2,
    description: "This year I worked on fascinating projects in energy, media and health* at Magnetic, and learned many learnings. A bolt of lightning contains about ¼ of a kilowatt-hour of power. Even with recent energy price..."
}
])

p "Created #{Post.count} posts"