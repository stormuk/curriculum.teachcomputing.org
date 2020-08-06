# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? || Rails.env.staging?
  puts 'Clearing existing records'
  Rating.delete_all
  AggregateRating.delete_all

  Download.delete_all
  AggregateDownload.delete_all

  State.delete_all

  Lesson.delete_all
  Unit.delete_all
  YearGroup.delete_all
  KeyStage.delete_all

  4.times do |i|
    puts '*' * 50
    puts "Creating KeyStage #{i}"
    key_stage = KeyStage.create(
      {
        description: 'This is a KeyStage',
        ages: "#{i}-#{i + 2}",
        years: "#{i}-#{i + 2}",
        level: i.to_s
      }
    )
    key_stage.published!

    download_record = AggregateDownload.create(
      count: i,
      downloadable: key_stage,
      attachment_type: 'zipped_contents'
    )
    i.times do
      download_record.downloads.create
    end

    puts 'Adding YearGroup'
    year_group = key_stage.year_groups.create({ year_number: i.to_s })
    year_group.published!

    puts 'Adding Unit'
    unit = year_group.units.create({ title: "Unit #{i}", description: 'This is a Unit' })
    unit.published!

    download_record = AggregateDownload.create(
      count: i,
      downloadable: unit,
      attachment_type: 'zipped_contents'
    )
    i.times do
      download_record.downloads.create
      unit.add_positive_rating
      unit.add_negative_rating
    end

    puts 'Adding Lesson'
    lesson = unit.lessons.create({ title: "Lesson #{i}", description: 'This is a Lesson' })
    lesson.published!

    download_record = AggregateDownload.create(
      count: i,
      downloadable: lesson,
      attachment_type: 'zipped_contents'
    )

    i.times do
      download_record.downloads.create
      lesson.add_positive_rating
      lesson.add_negative_rating
    end
  end
end
