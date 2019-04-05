User.destroy_all
Availability.destroy_all
ContactDetails.destroy_all
Identity.destroy_all
NonTechSkill.destroy_all
TechSkill.destroy_all
UserIdentity.destroy_all
UserNonTechSkill.destroy_all
UserTechSkill.destroy_all

User.create(name: 'Travis Gee', cohort: 1810, program: 'FE', current_job: 'student', background: 'IT', location: 'Denver, CO')
User.create(name: 'Ricardo', cohort: 1810, program: 'BE', current_job: 'student', background: 'CS', location: 'Denver, CO')
@t_1 = TechSkill.create(title: 'javascript')
@t_2 = TechSkill.create(title: 'ruby')

@u_1 = User.create(name: 'Travis Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
UserTechSkill.create(user_id: @u_1.id, tech_skill_id: @t_2.id)
@u_2 = User.create(name: 'Bob Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, CO')
UserTechSkill.create(user_id: @u_2.id, tech_skill_id: @t_2.id)

@u_3 = User.create(name: 'Jordan Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, NY')
UserTechSkill.create(user_id: @u_3.id, tech_skill_id: @t_1.id)

@u_4 = User.create(name: 'J J', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_1.id)
UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_2.id)
