# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


ApplicationRecord.transaction do
  # These `destroy_all` commands are not necessary--but will also not hurt--if
  # you use `rails db:seed:replant`.
  puts 'Destroying tables...'
  ArtworkShare.destroy_all
  Like.destroy_all
  Comment.destroy_all
  Artwork.destroy_all
  User.destroy_all

  # Reset the id (i.e., primary key) counters for each table to start at 1
  # (helpful for debugging)
  puts 'Resetting id sequences...'
  %w(users artworks artwork_shares comments likes).each do |table_name|
    ApplicationRecord.connection.reset_pk_sequence!(table_name)
  end
  
  # Create seed data
  puts 'Loading seed data...'
  u1 = User.create!(username: 'Dominic')
  u2 = User.create!(username: 'Stefan')
  u3 = User.create!(username: 'Darren')
  u4 = User.create!(username: 'Taylor')
  u5 = User.create!(username: 'Diego')
  u6 = User.create!(username: 'Abby')
  
  a1 = Artwork.create!(title: 'Mona Lisa', image_url: 'https://en.wikipedia.org/wiki/Mona_Lisa', artist_id: u1.id)
  a2 = Artwork.create!(title: 'The Starry Night', image_url: 'https://en.wikipedia.org/wiki/The_Starry_Night', artist_id: u2.id)
  a3 = Artwork.create!(title: 'Sunflowers', image_url: 'https://en.wikipedia.org/wiki/Sunflowers_(Van_Gogh_series)', artist_id: u1.id)
  a4 = Artwork.create!(title: 'The Kiss', image_url: 'https://en.wikipedia.org/wiki/The_Kiss_(Klimt)', artist_id: u4.id)
  a5 = Artwork.create!(title: 'The birth of Venus', image_url: 'https://en.wikipedia.org/wiki/The_Birth_of_Venus', artist_id: u3.id)
  a6 = Artwork.create!(title: 'The Last Supper', image_url: 'https://en.wikipedia.org/wiki/The_Last_Supper_(Leonardo)', artist_id: u2.id)
  a7 = Artwork.create!(title: 'American Gothic', image_url: 'https://en.wikipedia.org/wiki/American_Gothic', artist_id: u2.id)

  as1 = ArtworkShare.create!(artwork_id: a3.id, viewer_id: u1.id)
  as2 = ArtworkShare.create!(artwork_id: a7.id, viewer_id: u1.id)
  as3 = ArtworkShare.create!(artwork_id: a7.id, viewer_id: u3.id)
  as4 = ArtworkShare.create!(artwork_id: a4.id, viewer_id: u5.id)
  as5 = ArtworkShare.create!(artwork_id: a2.id, viewer_id: u6.id)
  as6 = ArtworkShare.create!(artwork_id: a1.id, viewer_id: u2.id)
  as7 = ArtworkShare.create!(artwork_id: a5.id, viewer_id: u3.id)

  c1 = Comment.create!(body: "I love the brush strokes!", commenter_id: u3.id, artwork_commented_id: a1.id)
  c2 = Comment.create!(body: "Looks fake.", commenter_id: u2.id, artwork_commented_id: a5.id)
  c3 = Comment.create!(body: "A little bit depressing.", commenter_id: u6.id, artwork_commented_id: a7.id)
  c4 = Comment.create!(body: "I could do better.", commenter_id: u1.id, artwork_commented_id: a3.id)
  c5 = Comment.create!(body: "How much would this cost to buy???", commenter_id: u5.id, artwork_commented_id: a4.id)

  l1 = Like.create!(user_id: u1.id, likeable_id: a4.id, likeable_type: 'Artwork')
  l2 = Like.create!(user_id: u2.id, likeable_id: c3.id, likeable_type: 'Comment')
  l3 = Like.create!(user_id: u2.id, likeable_id: a1.id, likeable_type: 'Artwork')
  l4 = Like.create!(user_id: u3.id, likeable_id: c1.id, likeable_type: 'Comment')
  l5 = Like.create!(user_id: u6.id, likeable_id: a7.id, likeable_type: 'Artwork')
  l6 = Like.create!(user_id: u5.id, likeable_id: c5.id, likeable_type: 'Comment')
  
  puts 'Done!'
end
