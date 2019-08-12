# frozen_string_literal: true

module SearchHelper
  def search_params
    s_params = {}
    s_params[:q] = params[:q] if params[:q].present?
    s_params[:limit] = params[:limit] if params[:limit].present?
    s_params
  end
end
