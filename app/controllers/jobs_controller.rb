class JobsController < ApplicationController
  before_action :require_login
  before_action :load_job, only: [:show]
  before_action :load_objects, only: [:index, :collection]
  def index
  end

  def collection
  end

  private
  def load_job
    @job = JobsLog.find_by_id(params[:id].to_i)
    if !@job
      flash[:error] = 'Job not found'
      redirect_back(fallback_location: jobs_path)
    end
  end

  def load_objects
    per_page = (params[:per_page].present? ? params[:per_page] : 20)
    page = (params[:page].present? ? params[:page] : 1)
    paginate_params = {page: page, per_page: per_page}
    search_params = {}
    if params[:queue].present? && params[:queue] != 'all'
      search_params.merge!(queue: params[:queue])
    end
    @jobs = JobsLog.where(search_params).order('run_at desc').paginate(paginate_params).includes(:schedule, :event)
    @queues = JobsLog.find_by_sql("select distinct(queue) from jobs_logs").map(&:queue)
  end
end