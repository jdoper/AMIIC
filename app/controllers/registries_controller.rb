class RegistriesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_registry, only: [:show, :edit, :update, :destroy]

  # GET /registries
  # GET /registries.json
  def index
    @registries = Registry.last(10)
  end

  # GET /registries/1
  # GET /registries/1.json
  def show
    @questoes = Question.where(serial: @registry.serial).order(:numero)
    @etiologias = ["CMP Primária","CMP Isquêmica","CMP Hipertensiva","CMP Valvar","CMP Hipertrófica","CMP Alcoólica","CMP Congênita","Outras","Chagásica","Periparto"]

    # Caso o cadastro seja enviado antes de realizar o questionário
    # é necessário atualizar o valor do score do Cadastro(@registry)
    if @questoes.size > 0
      score = 0
      @questoes.each do |questao|
        score += questao.resposta.to_i if questao.numero != 22
      end
      @registry.score = score
      @registry.save
    end
  end

  # GET /registries/new
  def new
   # @registry = Registry.new
   redirect_to root_url
  end

  # GET /registries/1/edit
  def edit
    redirect_to root_url
  end

  # POST /registries
  # POST /registries.json
  def create
    @registry = Registry.new(registry_params)

    respond_to do |format|
      if @registry.save
        format.html { redirect_to @registry, notice: 'Cadastro criado com sucesso' }
        format.json { render :show, status: :created, location: @registry }
      else
        format.html { render :new }
        format.json { render json: @registry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registries/1
  # PATCH/PUT /registries/1.json
  def update
    respond_to do |format|
      if @registry.update(registry_params)
        format.html { redirect_to @registry, notice: 'Cadastro atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @registry }
      else
        format.html { render :edit }
        format.json { render json: @registry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registries/1
  # DELETE /registries/1.json
  def destroy
    Question.where(serial: @registry.serial).delete_all
    @registry.destroy
    respond_to do |format|
      format.html { redirect_to registries_url, notice: 'Cadastro excluido com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry
      @registry = Registry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registry_params
      params.require(:registry).permit(:nome, :idade, :data, :sexo, :registro, :tipoInsuficiencia, :etiologia, :classFuncional, :FEVE, :tempoUsado, :score, :serial)
    end
end
