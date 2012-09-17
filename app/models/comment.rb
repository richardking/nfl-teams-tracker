class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id
  belongs_to :commentable, polymorphic: true

  default_scope order('created_at ASC')

  def self.prepare_data(league_id)
    all_comments = []
    Comment.find_all_by_commentable_id(league_id).each do |comment|
      all_comments << { first_name: User.find(comment.user_id).first_name,
                    user_id: User.find(comment.user_id).id,
                    time_ago: comment.created_at,
                    body: comment.body}
    end

    return all_comments
  end
end
