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
