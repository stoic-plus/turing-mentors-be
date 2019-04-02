class CreateTechSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :tech_skills do |t|
      t.string :title
    end
  end
end
