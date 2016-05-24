# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

console.log('home.coffee loaded')

$(document).on "page:change", ->
    x = document.getElementById('demo')
    
    showPosition = (position) ->
      x.innerHTML = 'Latitude: ' + position.coords.latitude + '<br>Longitude: ' + position.coords.longitude
      return
      
    @getLocation = ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition showPosition
      else
        x.innerHTML = 'Geolocation is not supported by this browser.'
      return    