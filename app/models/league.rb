class League < ActiveRecord::Base
  attr_accessible :name

  has_many :users_leagues
  has_many :users, :through => :users_leagues
  has_many :comments, as: :commentable


  def self.find_active_week_id
    Week.where(:season => 2014).each_with_index do |w, index|
      diff = w.end_of_week - Time.now
      return w.id if diff > 0
    end
    return Week.where(:season => 2014, :num => 17).first.id
  end

end
