class CasesController < ApplicationController
  before_action :set_case, only: [:show, :update, :destroy]

  def index
    @cases = Case.all
    render json: @cases
  end

  def show
    render json: @case
  end

  def create
    @case = Case.new(case_params)
    if @case.save
      render json: @case, status: :created
    else
      render json: { errors: @case.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @case.update(case_params)
      render json: @case
    else
      render json: { errors: @case.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @case.destroy
    head :no_content
  end

  private

  def set_case
    @case = Case.find(params[:id])
  end

  def case_params
    params.require(:case).permit(:title, :description, :status, :client_name)
  end
end
