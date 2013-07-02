class PrioritiesController < ApplicationController
  unloadable

  def update
    @project = Project.find_by_param(params[:project_id])
    priority = Priority.find_by_project_id(@project.id)
    if priority
      priority.update_attributes(params[:priority])
    else
      p = Priority.new(params[:priority])
      p.project_id = @project.id
      p.save
    end
    redirect_to settings_project_path(@project, :tab => 'priorities'), :notice => 'Update success'
  end

end
