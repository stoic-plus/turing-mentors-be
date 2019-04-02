class CreateUserTechSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tech_skills do |t|
      t.references :user, foreign_key: true
      t.references :tech_skill, foreign_key: true
    end
  end
end
