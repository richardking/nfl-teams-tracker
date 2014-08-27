class @Comment extends Backbone.Model


class @Comments extends Backbone.Collection
  league = 4
  url: "/leagues/#{league}/comments"

  model: Comment
