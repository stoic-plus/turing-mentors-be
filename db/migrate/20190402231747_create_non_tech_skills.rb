class CreateNonTechSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :non_tech_skills do |t|
      t.string :title
    end
  end
end
