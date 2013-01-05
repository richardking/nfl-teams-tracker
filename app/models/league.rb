class League < ActiveRecord::Base
  attr_accessible :name

  has_many :users_leagues
  has_many :users, :through => :users_leagues
  has_many :comments, as: :commentable


  def self.find_active_week
    Week.all.each_with_index do |w, index|
      diff = w.end_of_week - Time.now
      return (index+1) if diff > 0
    end
    return 17
  end

end
