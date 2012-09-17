class @Comment extends Backbone.Model


class @Comments extends Backbone.Collection
  league = 2
  url: "/leagues/#{league}/comments"

  model: Comment