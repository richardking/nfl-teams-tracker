ActiveAdmin.register Score do

  form do |f|
    f.inputs "Details" do
      f.input :schedule_id
      f.input :home_team_score
      f.input :away_team_score
    end
    f.buttons
  end

end
