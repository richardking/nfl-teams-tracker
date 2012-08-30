class League < ActiveRecord::Base
  attr_accessible :name

  has_many :users_leagues
  has_many :users, :through => :users_leagues


  def self.find_active_week
    Week.all.each_with_index do |w, index|
      diff = w.early_deadline - Time.now
      return (index+1) if diff > 0
    end
  end

end
