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
  slack = "@#{first_n}"
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

def create_user(type)
  gender = rand(0..2)
  first_name = get_first_name(gender)
  last_name = Faker::Name.last_name
  cohort = COHORTS[rand(0..COHORTS.length - 1)]
  program = rand(0..1) == 0 ? "FE" : "BE"
  current_job = type == :mentor ? Faker::Company.name : nil
  background = QUOTES.sample.send(:quote)
  city = Faker::Address.city
  state = STATE_ABBREVS.sample
  mentor = type == :mentor ? true : false
  user = User.create(
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
  user.id
end

def create_users(amount, type)
  amount.times do
    user = create_user(type)
    user_id = user.id
    slack, email, phone = get_contact_info(user.first_name)
    ContactDetails.create(slack: slack, email: email, phone: phone, user: user)
    UserIdentity.create(user_id: user_id, identity_id: gender)
    create_interests(user_id)
    create_availability(user_id)

    if type == :mentor
      UserTechSkill.create(user_id: user_id, tech_skill_id: 2) if cohort == "FE"
      UserTechSkill.create(user_id: user_id, tech_skill_id: 2) if cohort == "BE"
      create_tech_skills(user_id)
      create_non_tech_skills(user_id)
    end
  end
end

create_users(2, :mentor)
create_users(1, :mentee)

binding.pry
# @u_1 = User.create(first_name: 'Travy', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
# @u_2 = User.create(first_name: 'Bob', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, CO')
# @u_3 = User.create(first_name: 'Jordan', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, NY')
# @u_4 = User.create(first_name: 'J', last_name: 'J', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
#
# @u_5 = User.create(first_name: 'Fera', last_name: 'dabre', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: false, location: 'Denver, CO')
# @u_6 = User.create(first_name: 'BoFerb', last_name: 'darla', cohort: 1803, program: 'FE', current_job: 'google', background: 'IT', mentor: false, location: 'New York, CO')
# @u_7 = User.create(first_name: 'Jaja', last_name: 'dava', cohort: 1801, program: 'FE', current_job: 'google', background: 'IT', mentor: false, location: 'New York, NY')
# @u_8 = User.create(first_name: 'Jeraul', last_name: 'Jameson', cohort: 1410, program: 'FE', current_job: 'google', background: 'IT', mentor: false, location: 'Denver, CO')

# # mentors
# UserIdentity.create(user: @u_1, identity_id: i_2.id)
# UserIdentity.create(user: @u_2, identity_id: i_1.id)
# UserIdentity.create(user: @u_3, identity_id: i_3.id)
# UserIdentity.create(user: @u_4, identity_id: i_3.id)
# # mentees
# UserIdentity.create(user: @u_5, identity_id: i_2.id)
# UserIdentity.create(user: @u_6, identity_id: i_1.id)
# UserIdentity.create(user: @u_7, identity_id: i_3.id)
# UserIdentity.create(user: @u_8, identity_id: i_3.id)
#
# UserTechSkill.create(user_id: @u_1.id, tech_skill_id: @t_2.id)
# UserTechSkill.create(user_id: @u_2.id, tech_skill_id: @t_2.id)
# UserTechSkill.create(user_id: @u_3.id, tech_skill_id: @t_1.id)
# UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_1.id)
# UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_3.id)
#
# UserNonTechSkill.create(user_id: @u_1.id, non_tech_skill_id: @nt_1.id)
# UserNonTechSkill.create(user_id: @u_2.id, non_tech_skill_id: @nt_2.id)
# UserNonTechSkill.create(user_id: @u_3.id, non_tech_skill_id: @nt_3.id)
# UserNonTechSkill.create(user_id: @u_4.id, non_tech_skill_id: @nt_1.id)
# UserNonTechSkill.create(user_id: @u_4.id, non_tech_skill_id: @nt_3.id)
#
# Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_1)
# Availability.create(day_of_week: 1, morning: false, afternoon: false, evening: true, user: @u_1)
# Availability.create(day_of_week: 3, morning: false, afternoon: false, evening: true, user: @u_1)
# Availability.create(day_of_week: 4, morning: false, afternoon: false, evening: true, user: @u_1)
# Availability.create(day_of_week: 6, morning: false, afternoon: false, evening: true, user: @u_1)
#
# Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_2)
# Availability.create(day_of_week: 1, morning: false, afternoon: false, evening: true, user: @u_2)
# Availability.create(day_of_week: 3, morning: false, afternoon: false, evening: true, user: @u_2)
# Availability.create(day_of_week: 5, morning: false, afternoon: false, evening: true, user: @u_2)
#
# Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_3)
# Availability.create(day_of_week: 2, morning: false, afternoon: false, evening: true, user: @u_3)
# Availability.create(day_of_week: 4, morning: false, afternoon: false, evening: true, user: @u_3)
# Availability.create(day_of_week: 6, morning: false, afternoon: false, evening: true, user: @u_3)
#
# Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_4)
# Availability.create(day_of_week: 1, morning: false, afternoon: false, evening: true, user: @u_4)
# Availability.create(day_of_week: 2, morning: false, afternoon: false, evening: true, user: @u_4)
# Availability.create(day_of_week: 3, morning: false, afternoon: false, evening: true, user: @u_4)
# Availability.create(day_of_week: 4, morning: false, afternoon: false, evening: true, user: @u_4)
# Availability.create(day_of_week: 5, morning: false, afternoon: false, evening: true, user: @u_4)
# Availability.create(day_of_week: 6, morning: false, afternoon: false, evening: true, user: @u_4)
#
#
# ContactDetails.create(email: 't@mail.com', slack: 's1', phone: 'p1', user: @u_1)
# ContactDetails.create(email: 'tv@mail.com', slack: 's2', phone: 'p2', user: @u_2)
# ContactDetails.create(email: 'jor@mail.com', slack: 's3', phone: 'p3', user: @u_3)
# ContactDetails.create(email: 'j@mail.com', slack: 's4', phone: 'p4', user: @u_4)
