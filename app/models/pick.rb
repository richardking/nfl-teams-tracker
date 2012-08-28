class Pick < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :team_id

  belongs_to :team
  belongs_to :user

end
