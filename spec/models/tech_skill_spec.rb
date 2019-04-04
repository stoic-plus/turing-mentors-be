require 'rails_helper'

describe TechSkill, type: :model do
  it {should validate_presence_of(:title)}
end

# SELECT name, title FROM users INNER JOIN user_tech_skills ON user_tech_skills.user_id=users.id INNER JOIN tech_skills ON user_tech_skills.tech_skill_id=tech_skills.id;
