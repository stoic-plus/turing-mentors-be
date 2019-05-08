User.destroy_all
Availability.destroy_all
ContactDetails.destroy_all
Identity.destroy_all
NonTechSkill.destroy_all
TechSkill.destroy_all
UserIdentity.destroy_all
UserNonTechSkill.destroy_all
UserTechSkill.destroy_all

i_1 = Identity.create(title: 'male')
i_2 = Identity.create(title: 'female')
i_3 = Identity.create(title: 'non-binary')

@t_1 = TechSkill.create(title: 'ruby')
@t_2 = TechSkill.create(title: 'javascript')
@t_3 = TechSkill.create(title: 'python')
@t_4 = TechSkill.create(title: 'java')
@t_5 = TechSkill.create(title: 'elixir')
@t_6 = TechSkill.create(title: 'c')
@t_7 = TechSkill.create(title: 'php')
@t_8 = TechSkill.create(title: 'swift')
@t_9 = TechSkill.create(title: 'sql')

@nt_1 = NonTechSkill.create(title: 'stress management')
@nt_2 = NonTechSkill.create(title: 'public speaking')
@nt_3 = NonTechSkill.create(title: 'resumes')
@nt_4 = NonTechSkill.create(title: 'technical interviews')
@nt_5 = NonTechSkill.create(title: 'parenting')
@nt_6 = NonTechSkill.create(title: 'wellness')

@u_1 = User.create(first_name: 'Travy', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
@u_2 = User.create(first_name: 'Bob', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, CO')
@u_3 = User.create(first_name: 'Jordan', last_name: 'Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'New York, NY')
@u_4 = User.create(first_name: 'J', last_name: 'J', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')

@u_5 = User.create(first_name: 'Fera', last_name: 'dabre', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: false, location: 'Denver, CO')
@u_6 = User.create(first_name: 'BoFerb', last_name: 'darla', cohort: 1803, program: 'FE', current_job: 'google', background: 'IT', mentor: false, location: 'New York, CO')
@u_7 = User.create(first_name: 'Jaja', last_name: 'dava', cohort: 1801, program: 'FE', current_job: 'google', background: 'IT', mentor: false, location: 'New York, NY')
@u_8 = User.create(first_name: 'Jeraul', last_name: 'Jameson', cohort: 1410, program: 'FE', current_job: 'google', background: 'IT', mentor: false, location: 'Denver, CO')

# mentors
UserIdentity.create(user: @u_1, identity_id: i_2.id)
UserIdentity.create(user: @u_2, identity_id: i_1.id)
UserIdentity.create(user: @u_3, identity_id: i_3.id)
UserIdentity.create(user: @u_4, identity_id: i_3.id)
# mentees
UserIdentity.create(user: @u_5, identity_id: i_2.id)
UserIdentity.create(user: @u_6, identity_id: i_1.id)
UserIdentity.create(user: @u_7, identity_id: i_3.id)
UserIdentity.create(user: @u_8, identity_id: i_3.id)

UserTechSkill.create(user_id: @u_1.id, tech_skill_id: @t_2.id)
UserTechSkill.create(user_id: @u_2.id, tech_skill_id: @t_2.id)
UserTechSkill.create(user_id: @u_3.id, tech_skill_id: @t_1.id)
UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_1.id)
UserTechSkill.create(user_id: @u_4.id, tech_skill_id: @t_3.id)

UserNonTechSkill.create(user_id: @u_1.id, non_tech_skill_id: @nt_1.id)
UserNonTechSkill.create(user_id: @u_2.id, non_tech_skill_id: @nt_2.id)
UserNonTechSkill.create(user_id: @u_3.id, non_tech_skill_id: @nt_3.id)
UserNonTechSkill.create(user_id: @u_4.id, non_tech_skill_id: @nt_1.id)
UserNonTechSkill.create(user_id: @u_4.id, non_tech_skill_id: @nt_3.id)

Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_1)
Availability.create(day_of_week: 1, morning: false, afternoon: false, evening: true, user: @u_1)
Availability.create(day_of_week: 3, morning: false, afternoon: false, evening: true, user: @u_1)
Availability.create(day_of_week: 4, morning: false, afternoon: false, evening: true, user: @u_1)
Availability.create(day_of_week: 6, morning: false, afternoon: false, evening: true, user: @u_1)

Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_2)
Availability.create(day_of_week: 1, morning: false, afternoon: false, evening: true, user: @u_2)
Availability.create(day_of_week: 3, morning: false, afternoon: false, evening: true, user: @u_2)
Availability.create(day_of_week: 5, morning: false, afternoon: false, evening: true, user: @u_2)

Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_3)
Availability.create(day_of_week: 2, morning: false, afternoon: false, evening: true, user: @u_3)
Availability.create(day_of_week: 4, morning: false, afternoon: false, evening: true, user: @u_3)
Availability.create(day_of_week: 6, morning: false, afternoon: false, evening: true, user: @u_3)

Availability.create(day_of_week: 0, morning: false, afternoon: false, evening: true, user: @u_4)
Availability.create(day_of_week: 1, morning: false, afternoon: false, evening: true, user: @u_4)
Availability.create(day_of_week: 2, morning: false, afternoon: false, evening: true, user: @u_4)
Availability.create(day_of_week: 3, morning: false, afternoon: false, evening: true, user: @u_4)
Availability.create(day_of_week: 4, morning: false, afternoon: false, evening: true, user: @u_4)
Availability.create(day_of_week: 5, morning: false, afternoon: false, evening: true, user: @u_4)
Availability.create(day_of_week: 6, morning: false, afternoon: false, evening: true, user: @u_4)


ContactDetails.create(email: 't@mail.com', slack: 's1', phone: 'p1', user: @u_1)
ContactDetails.create(email: 'tv@mail.com', slack: 's2', phone: 'p2', user: @u_2)
ContactDetails.create(email: 'jor@mail.com', slack: 's3', phone: 'p3', user: @u_3)
ContactDetails.create(email: 'j@mail.com', slack: 's4', phone: 'p4', user: @u_4)
