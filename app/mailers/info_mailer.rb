class InfoMailer < ApplicationMailer
  default :from => 'AMIIC - HUOL'

  def backup_data
  	@registros = Registry.all
  	@questoes = Question.all
  	mail(:to => 'jp_12c@hotmail.com', :subject => 'Backup AMIIC')
  end 
end
