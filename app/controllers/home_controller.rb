require 'csv'

class HomeController < ApplicationController
  before_action :authenticate_user!

  def search
  	@cadastros = []
  end

  def listarCadastros
    @cadastros = Registry.where(registro: params[:registro])
  end

  def admin
  	@users = User.all
  end

  def excluirUsuario
  	if current_user.id  != params[:id]
  	  User.find(params[:id]).destroy
  	end
  	@users = User.all
  end

  def relatorio
  	# Registros resgatados do banco
  	registros = Registry.all
  	questoes = Question.all.order(:numero)

  	# Montagem da estrututa da planilha
  	csv_string = CSV.generate do |csv|
      # Cabeçalho
      csv << ["N", "Data", "Nome", "RH", "ID", "Sexo", "Tipo de IC", "Etiologia", "CF", "FEVE", "FEVE(RI)", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "Score"]
	  
  	  # Construindo linha de registro
  	  registros.each do |cadastro|
  	  	line = []
  	  	line << cadastro.id
  	  	line << cadastro.data
  	  	line << cadastro.nome
  	  	line << cadastro.registro
  	  	line << cadastro.idade
  	  	line << cadastro.sexo
  	  	line << cadastro.tipoInsuficiencia
  	  	line << cadastro.etiologia
  	  	line << cadastro.classFuncional
  	  	line << cadastro.feve
  	  	line << "99"
  	  	questoes.each do |questao|
  	  	  if questao.serial == cadastro.serial
  	  	  	line << questao.resposta
  	  	  end
  	  	end
  	  	line << cadastro.score

  	  	# Escrevendo linha no arquivo
  	 	  csv << line
      end
    end

    # Mostrando arquivo para usuário
    send_data csv_string, :type => 'text/csv; header=present', :disposition => "attachment; filename=AMIIC.csv" 
  end
end
