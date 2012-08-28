class Team < ActiveRecord::Base
  def self.picked(group_id)
    Pick.all.select{|p| p.group_id == group_id}.map{|p| p.team}
  end
end
