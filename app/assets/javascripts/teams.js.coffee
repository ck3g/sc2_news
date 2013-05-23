# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Team
  constructor: (@name) ->

  slug: ->
    @name.toLowerCase().replace /\W/ig, '-'

  update: (selector) ->
    selector.val(@slug())

jQuery ->
  $teamSlug = $("#team_slug")

  $("#team_name").on 'keyup', (e) ->
    new Team($(this).val()).update($teamSlug)

  $teamSlug.on 'keyup', (e) ->
    new Team($(this).val()).update($teamSlug)
