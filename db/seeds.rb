# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Book.create(title: 'Atlas Shrugged',
            author: 'Ayn Rand',
            cover_image_url: 'atlas_shrugged.jpg',
            slug:'atlas-shrugged')

Book.create(title: 'The Fountainhead',
            author: 'Ayn Rand',
            cover_image_url: 'fountainhead.jpg',
            slug:'fountainhead')

Book.create(title: 'Objectivism: The Philosophy of Ayn Rand',
            author: 'Leonard Peikoff',
            cover_image_url: 'opar.jpg',
            slug:'objectivism-the-philosophy-of-ayn-rand')
