# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Translation.delete_all
Language.delete_all
Book.delete_all

b1 = Book.create(title: 'Atlas Shrugged',
                 author: 'Ayn Rand',
                 cover_image_url: 'atlas_shrugged.jpg',
                 slug:'atlas-shrugged')
b2 = Book.create(title: 'The Fountainhead',
                 author: 'Ayn Rand',
                 cover_image_url: 'fountainhead.jpg',
                 slug:'fountainhead')
b3 = Book.create(title: 'Objectivism: The Philosophy of Ayn Rand',
                 author: 'Leonard Peikoff',
                 cover_image_url: 'opar.jpg',
                 slug:'objectivism-the-philosophy-of-ayn-rand')


l1 = Language.create(name: 'Italian',
                local_name: 'Italiano',
                slug: 'italian')
l2 = Language.create(name: 'Japanese',
                local_name: '日本語',
                slug: 'japanese')
l3 = Language.create(name: 'Czech',
                local_name: 'čeština',
                slug: 'czech')


Translation.create(book: b1,
                   language: l1,
                   title: 'La rivolta di Atlante: Il Tema',
                   cover_image_url: 'atlas_shrugged_italian.jpg',
                   publisher: 'Corbaccio',
                   isbn_13: '978-8867002177',
                   isbn_10: '8879728636',
                   translator: 'Grimaldi L. Milano')
Translation.create(book: b2,
                   language: l2,
                   title: '水源',
                   cover_image_url: 'fountainhead_jp.jpg',
                   publisher: 'business-sha-co.jp',
                   isbn_13: '9784828411323',
                   isbn_10: '4828411321')
Translation.create(book: b3,
                   language: l3,
                   title: 'Objektivismus: Filozo e Ayn Randové',
                   cover_image_url: 'opar_czech.gif',
                   publisher: 'Berlet',
                   isbn_10: '0-957-83991-X')

