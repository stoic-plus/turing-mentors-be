User.destroy_all
Availability.destroy_all
ContactDetails.destroy_all
Identity.destroy_all
NonTechSkill.destroy_all
TechSkill.destroy_all
UserIdentity.destroy_all
UserNonTechSkill.destroy_all
UserTechSkill.destroy_all

User.create(first_name: 'Travis', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'student', background: 'IT', location: 'Denver, CO')
User.create(first_name: 'Robert', last_name: 'Ricardo', cohort: 1810, program: 'BE', current_job: 'student', background: 'CS', location: 'Denver, CO')
@t_1 = TechSkill.create(title: 'javascript')
@t_2 = TechSkill.create(title: 'ruby')

@u_1 = User.create(first_name: 'Travy', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
UserTechSkill.create(user_id: @u_1.id, tech_skill_id: @t_2.id)
@u_2 = User.create(first_name: 'Bob', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, CO')
UserTechSkill.create(user_id: @u_2.id, tech_skill_id: @t_2.id)

@u_3 = User.create(first_name: 'Jordan', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, NY')
UserTechSkill.create(user_id: @u_3.id, tech_skill_id: @t_1.id)

@u_4 = User.create(first_name: 'J', last_name: 'J', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_1.id)
UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_2.id)

i_1 = Identity.create(title: 'male')
i_2 = Identity.create(title: 'female')
i_3 = Identity.create(title: 'non-binary')

Availability.create!(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_1)
Availability.create(day_of_week: 0, morning: true, afternoon: false, evening: false, user: @u_2)
Availability.create(day_of_week: 0, morning: false, afternoon: true, evening: false, user: @u_3)
