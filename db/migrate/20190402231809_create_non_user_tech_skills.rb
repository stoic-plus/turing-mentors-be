class CreateNonUserTechSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :non_user_tech_skills do |t|
      t.references :user, foreign_key: true
      t.references :non_tech_skill, foreign_key: true
    end
  end
end
