class ModifyColumnQuestions < ActiveRecord::Migration
  def change
  	rename_column :questions, :cadastro, :serial
  	rename_column :registries, :FEVE, :feve
  end
end
