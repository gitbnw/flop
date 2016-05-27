# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
    
    console.log 'home.cofee loaded'
    user_id = $('#user').data("user").id
    saveCurrentLocation = (user_position) ->
        position = user_position.coords.latitude + ", " + user_position.coords.longitude
        user_update_url = "../api/v1/users/" + user_id 
        google_locate_url = '../home/address'
        $.ajax
          url:  user_update_url
          type: 'PUT', 
          data: {"user": {"position": position}},
          error: (jqXHR, textStatus, errorThrown) ->
            console.log "AJAX Error: #{errorThrown}"
          success: (data, textStatus, jqXHR) ->
            console.log data
            $.ajax
              url:  google_locate_url
              type: 'PUT', 
              data: {"id": user_id},
              error: (jqXHR, textStatus, errorThrown) ->
                console.log "AJAX Error: #{errorThrown}"
              success: (data, textStatus, jqXHR) ->            

    getLocation = ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition saveCurrentLocation
      else
        x.innerHTML = 'Geolocation is not supported by this browser.'
      return
      
    $('#geo-link').click (event) ->
      getLocation()
      event.preventDefault()
      # Prevent link from following its href
      return     
