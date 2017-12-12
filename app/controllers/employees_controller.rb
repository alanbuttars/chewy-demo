class EmployeesController < ApplicationController
  def search
    search_params = _search_params
    @query = search_params[:query]
    redirect_to :college and return if @query.blank?

    @college = CollegeService.find(search_params)
    @employees = EmployeeService.search(search_params)
  end

  def _search_params
    params.require(:college_id)
    params.permit(:college_id, :query)
  end
end
