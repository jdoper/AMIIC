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
  	@registros = Registry.all
  	@questoes = Question.all.order(:numero)

    respond_to do |format|
      format.xls
    end
  end
end
