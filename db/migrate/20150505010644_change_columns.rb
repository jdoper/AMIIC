class ChangeColumns < ActiveRecord::Migration
  def change
  	change_column :questions, :cadastro, :string
  end
end
