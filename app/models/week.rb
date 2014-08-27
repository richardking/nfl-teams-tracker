class Week < ActiveRecord::Base
  default_scope order('num ASC')

  class << self
    def create_season(year)
      beginning_of_season = DateTime.parse('04/09/2014 04:00')
      (1..17).each do |n|
        Week.create(num: n, season: year, end_of_week: (beginning_of_season + (n.weeks)))
      end
    end
  end
end
