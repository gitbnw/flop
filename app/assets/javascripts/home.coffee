# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
    
    console.log 'home.cofee loaded'
    
    x = document.getElementById('demo')
    
    saveCurrentLocation = (position) ->
        $.ajax
          url:  api_url
          type: "POST"
          data: {position}
          dataType: "json"
          error: (jqXHR, textStatus, errorThrown) ->
             console.log "AJAX Error: #{errorThrown}"
          success: (data, textStatus, jqXHR) ->

    showPosition = (position) ->
      x.innerHTML = 'Latitude: ' + position.coords.latitude + '<br>Longitude: ' + position.coords.longitude
      return
      
    @getLocation = ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition showPosition
        navigator.geolocation.getCurrentPosition saveCurrentLocation
      else
        x.innerHTML = 'Geolocation is not supported by this browser.'
      return
    
