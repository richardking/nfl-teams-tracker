class CommentsController < ApplicationController

  respond_to :json

  def index
    respond_with Comment.all
  end

  def create
    comment = League.find(params[:league_id]).comments.create(body: params[:comment][:body], user_id: params[:user_id])
    attributes = { first_name: User.find(params[:user_id]).first_name,
                    user_id: User.find(params[:user_id]).id,
                    time_ago: comment.created_at,
                    body: comment.body}

    respond_to do |format|
      format.json { render json: attributes }
    end
  end
end
