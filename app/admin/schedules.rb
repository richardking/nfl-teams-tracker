ActiveAdmin.register Schedule do

  config.sort_order = 'id_asc'

  index do
    column :id
    column :week_num do |s|
      Week.find(s.week_id).num
    end
    column :home_team do |s|
      Team.find(s.home_team_id).name
    end
    column :away_team do |s|
      Team.find(s.away_team_id).name
    end
    column :processed
    column :actions do |s|
      url = "/admin/schedules/#{s.id}"
      "#{link_to 'Enter Score', url}".html_safe
    end
  end

  controller do
    def show
      @schedule = Schedule.find(params[:id])
      @score = Score.find_or_initialize_by_schedule_id(params[:id])
    end
  end

  show do |s|
    render :partial => "/admin/schedules/show"
  end

  
end
