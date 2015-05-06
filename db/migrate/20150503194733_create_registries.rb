class CreateRegistries < ActiveRecord::Migration
  def change
    create_table :registries do |t|
      t.string :nome
      t.integer :idade
      t.string :data
      t.integer :sexo
      t.integer :registro
      t.integer :tipoInsuficiencia
      t.integer :etiologia
      t.integer :classFuncional
      t.integer :FEVE
      t.integer :tempoUsado
      t.integer :score
      t.string :serial

      t.timestamps null: false
    end
  end
end
