module Registries
	class Data < Grape::API
		resource :registries do
			desc "Lista de todos os cadastros"
			get do
				Registry.all
			end

			desc "Criando novo cadastro"
			params do
				requires :nome,				type: String
				requires :idade,			type: Integer
				requires :data,				type: String
				requires :sexo,				type: Integer
				requires :registro, 		type: Integer
				requires :tipoInsuficiencia, type: Integer
				requires :etiologia, 		type: Integer
				requires :classFuncional, 	type: Integer
				requires :FEVE, 			type: Integer
				requires :tempoUsado,		type: Integer
				requires :score, 			type: Integer
				requires :serial,			type: String
			end
			post do
				Registry.create!({
					nome:params[:nome],
					idade:params[:idade],
					data:params[:data],
					sexo:params[:sexo],
					registro:params[:registro],
					tipoInsuficiencia:params[:tipoInsuficiencia],
					etiologia:params[:etiologia],
					classFuncional:params[:classFuncional],
					feve:params[:FEVE],
					tempoUsado:params[:tempoUsado],
					score:params[:score],
					serial:params[:serial]
				})
				InfoMailer.backup_data.deliver if Registry.all.size % 10 == 0
			end
		end

		resource :questions do
			desc "Lista de todas as questões"
			get do
				Question.all
			end

			desc "Criando nova questão"
			params do
				requires :serial, type: String
				requires :numero, type: Integer
				requires :resposta,	type: String
			end
			post do
				Question.create!({
					serial: params[:serial],
					numero:	params[:numero],
					resposta: params[:resposta]
				})
			end
		end

		resource :remove_registry do
			desc "Exclui registros excluidos nos aparelhos"
			params do
				requires :serial, type: String
			end
			post do
				Registry.where(serial: params[:serial]).delete_all
				Question.where(serial: params[:serial]).delete_all
			end
		end

		resource :add_admin do
			desc "Torna o usuário um administrador do sistema"
			params do
				requires :email, type: String
			end
			post do
				user = User.where(email: params[:email])
				if not user.nil?
					user[0].update_attribute :admin, true
					user[0].save
				end
			end
		end
	end
end