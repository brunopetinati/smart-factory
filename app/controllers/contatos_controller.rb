class ContatosController < ApplicationController
  before_action :set_contato, only: [:show, :edit, :update, :destroy]

  # GET /contatos
  # GET /contatos.json
  def index
    @contatos = Contato.all
  end

  # GET /contatos/1
  # GET /contatos/1.json
  def show
  end

  # GET /contatos/new
  def new
    @contato = Contato.new
    @contato.cliente_id = params[:cliente_id]
    @contato.fornecedor_id = params[:fornecedor_id]
  end

  # GET /contatos/1/edit
  def edit
  end

  # POST /contatos
  # POST /contatos.json
  def create
    @contato = Contato.new(contato_params)

    respond_to do |format|
      if @contato.save
        format.html { redirect_to @contato.cliente || @contato.fornecedor, notice: 'Contato cadastrado' }
        format.json { render :show, status: :created, location: @contato }
      else
        format.html { render :new }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contatos/1
  # PATCH/PUT /contatos/1.json
  def update
    respond_to do |format|
      if @contato.update(contato_params)
        format.html { redirect_to @contato.cliente || @contato.fornecedor, notice: 'Contato atualizado.' }
        format.json { render :show, status: :ok, location: @contato }
      else
        format.html { render :edit }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contatos/1
  # DELETE /contatos/1.json
  def destroy
    @contato.destroy
    respond_to do |format|
      format.html { redirect_to @contato.cliente || @contato.fornecedor,  notice: 'Contato deletado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contato
      @contato = Contato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contato_params
      params.require(:contato).permit(
        {:enderecos_attributes => [:id, :logradouro, :numero, :complemento,
                                   :bairro, :cidade, :estado, :cep,
                                   :_destroy]},
        :nome, :cargo, :departamento, :telefone_fixo, :telefone_celular,
        :email, :observacoes, :cliente_id, :fornecedor_id
      )
    end
end
