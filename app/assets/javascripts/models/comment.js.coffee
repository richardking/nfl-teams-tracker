class @Comment extends Backbone.Model


class @Comments extends Backbone.Collection
  league = 1
  url: "/leagues/#{league}/comments"

  model: Comment
