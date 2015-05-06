class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :cadastro
      t.integer :numero
      t.text :resposta

      t.timestamps null: false
    end
  end
end
