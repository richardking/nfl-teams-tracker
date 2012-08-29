class League < ActiveRecord::Base
  attr_accessible :name

  has_many :users_leagues
  has_many :users, :through => :users_leagues
end
