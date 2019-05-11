require "pry"
User.destroy_all
Availability.destroy_all
ContactDetails.destroy_all
Identity.destroy_all
NonTechSkill.destroy_all
TechSkill.destroy_all
UserIdentity.destroy_all
UserNonTechSkill.destroy_all
UserTechSkill.destroy_all


i_1 = Identity.create(title: 'Male')
i_2 = Identity.create(title: 'Female')
i_3 = Identity.create(title: 'Non-Binary')
i_4 = Identity.create(title: 'Parent')

in_1 = Interest.create(title: "3d Printing")
in_2 = Interest.create(title: "Anime")
in_3 = Interest.create(title: "Astronomy")
in_4 = Interest.create(title: "Automotive")
in_5 = Interest.create(title: "Blogging / Writing / Poetry")
in_6 = Interest.create(title: "Board Games")
in_7 = Interest.create(title: "Coding")
in_8 = Interest.create(title: "Collecting")
in_9 = Interest.create(title: "Cooking")
in_10 = Interest.create(title: "Crafts")
in_11 = Interest.create(title: "Cycling")
in_12 = Interest.create(title: "Dancing")
in_13 = Interest.create(title: "Drawing")
in_14 = Interest.create(title: "Drone")
in_15 = Interest.create(title: "Ecology")
in_16 = Interest.create(title: "Fishing")
in_17 = Interest.create(title: "Gardening")
in_18 = Interest.create(title: "Hiking")
in_19 = Interest.create(title: "Knitting")
in_20 = Interest.create(title: "Languages")
in_21 = Interest.create(title: "Martial Arts")
in_22 = Interest.create(title: "Mountain / Rock Climbing")
in_23 = Interest.create(title: "Movies / TV Shows")
in_24 = Interest.create(title: "Music / Podcast")
in_25 = Interest.create(title: "Musical Instruments")
in_26 = Interest.create(title: "Painting")
in_27 = Interest.create(title: "Philosophy")
in_28 = Interest.create(title: "Photography")
in_29 = Interest.create(title: "Psychology")
in_30 = Interest.create(title: "Reading")
in_31 = Interest.create(title: "Running")
in_32 = Interest.create(title: "Singing")
in_33 = Interest.create(title: "Skiiing / Snowboarding")
in_34 = Interest.create(title: "Sports")
in_35 = Interest.create(title: "Swimming")
in_36 = Interest.create(title: "Traveling")
in_37 = Interest.create(title: "Video Games")
in_38 = Interest.create(title: "Volunteering")
in_39 = Interest.create(title: "Working Out")
in_40 = Interest.create(title: "Yoga")

t_1 = TechSkill.create(title: 'Ruby')
t_2 = TechSkill.create(title: 'Javascript')
t_3 = TechSkill.create(title: 'Python')
t_4 = TechSkill.create(title: 'Java')
t_5 = TechSkill.create(title: 'Elixir')
t_6 = TechSkill.create(title: 'C')
t_7 = TechSkill.create(title: 'PHP')
t_8 = TechSkill.create(title: 'Swift')
t_9 = TechSkill.create(title: 'SQL')
t_10 = TechSkill.create(title: 'C++')

nt_1 = NonTechSkill.create(title: 'Stress Management')
nt_2 = NonTechSkill.create(title: 'Public Speaking')
nt_3 = NonTechSkill.create(title: 'Resumes')
nt_4 = NonTechSkill.create(title: 'Technical Interviews')
nt_5 = NonTechSkill.create(title: 'Parenting')
nt_6 = NonTechSkill.create(title: 'Wellness')


COHORTS = ("15".."19").each.reduce([]) do |cohorts, year|
  ("01".."11").each do |month|
    cohort = year + month
    cohorts.push cohort
  end
  cohorts
end
QUOTES = [Faker::TvShows::RickAndMorty, Faker::TvShows::SiliconValley, Faker::TvShows::DumbAndDumber]
STATE_ABBREVS = ["AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]

def get_first_name(gender)
  return Faker::Name.female_first_name if gender == 0
  return Faker::Name.male_first_name if gender == 1
  return Faker::Name.name.split(" ")[0] if gender == 2
end

def get_contact_info(first_name)
  slack = "@#{first_name}"
  email = Faker::Internet.email
  phone = Faker::PhoneNumber.cell_phone
  return slack, email, phone
end

def create_interests(user_id)
  (1..5).map{ rand(1..32) }.each do |interest_id|
    UserInterest.create(user_id: user_id, interest_id: interest_id)
  end
end

def create_availability(user_id)
  days_avail = []
  rand(1..5).times do
    day = rand(0..6)
    until !days_avail.include?(day) do day = rand(0..6) end
    days_avail.push day
  end
  days_avail.each do |day|
    avail = (1..3).map{ rand(0..1) == 0 ? true : false }
    Availability.create(day_of_week: day, morning: avail[0], afternoon: avail[1], evening: avail[2], user_id: user_id)
  end
end

def create_tech_skills(user_id)
  t_skills = []
  rand(1..5).times do
    t_skill = rand(3..10)
    until !t_skills.include?(t_skill) do t_skill = rand(3..10) end
    t_skills.push t_skill
  end
  t_skills.each {|skill_id| UserTechSkill.create(user_id: user_id, tech_skill_id: skill_id) }
end

def create_non_tech_skills(user_id)
  nt_skills = []
  rand(2..5).times do
    nt_skill = rand(1..6)
    until !nt_skills.include?(nt_skill) do nt_skill = rand(1..6) end
    nt_skills.push nt_skill
  end
  nt_skills.each {|skill_id| UserNonTechSkill.create(user_id: user_id, non_tech_skill_id: skill_id) }
end

def create_user(type, gender)
  first_name = get_first_name(gender)
  last_name = Faker::Name.last_name
  cohort = COHORTS[rand(0..COHORTS.length - 1)]
  program = rand(0..1) == 0 ? "FE" : "BE"
  current_job = type == :mentor ? Faker::Company.name : "student"
  background = QUOTES.sample.send(:quote)
  city = type == :mentor ? Faker::Address.city : nil
  state = type == :mentor ? STATE_ABBREVS.sample : nil
  mentor = type == :mentor ? true : false
  User.create!(
    first_name: first_name,
    last_name: last_name,
    cohort: cohort,
    program: program,
    current_job: current_job,
    background: background,
    mentor: mentor,
    city: city,
    state: state,
  )
end

def create_users(amount, type)
  amount.times do
    gender = rand(0..2)
    user = create_user(type, gender)
    user_id = user.id
    slack, email, phone = get_contact_info(user.first_name)
    ContactDetails.create(slack: slack, email: email, phone: phone, user: user)
    UserIdentity.create(user_id: user_id, identity_id: gender)
    create_interests(user_id)
    create_availability(user_id)

    if type == :mentor
      cohort = user.cohort
      UserTechSkill.create(user_id: user_id, tech_skill_id: 2) if cohort == "FE"
      UserTechSkill.create(user_id: user_id, tech_skill_id: 2) if cohort == "BE"
      create_tech_skills(user_id)
      create_non_tech_skills(user_id)
    end
  end
end

create_users(500, :mentor)
create_users(150, :mentee)
