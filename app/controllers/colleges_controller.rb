class CollegesController < ApplicationController
  def find_all
    @colleges = CollegeService.find_all
  end

  def find
    @college = CollegeService.find(_find_params)
    @employees = @college.employees.order(first_name: :asc)
  end

  def search
    search_params = _search_params
    redirect_to :colleges and return if search_params.values.map(&:blank?).all?

    @query = search_params[:query]
    @latitude = search_params[:latitude]
    @longitude = search_params[:longitude]
    @zoom = search_params[:zoom]
    @colleges = CollegeService.search(search_params)
  end

  def _find_params
    params.require(:college_id)
    params.permit(:college_id)
  end

  def _search_params
    params.permit(:query, :latitude, :longitude, :zoom)
  end
end
