# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#comment_comment").live "keyup", ->
    $this = $(this)
    $submit = $this.closest("form").children("input[type=submit]")

    if $this.val() is ""
      $submit.addClass("disabled").attr("disabled", true)
    else
      $submit.removeClass("disabled").attr("disabled", false)
