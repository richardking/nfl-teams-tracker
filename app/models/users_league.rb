class UsersLeague < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  has_many :weekly_actives, :dependent => :destroy

  has_many :picks, :dependent => :destroy

  attr_accessible :wins, :losses
end
