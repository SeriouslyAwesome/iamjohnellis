loadDataFromServer = (url)->
  req = new XMLHttpRequest()

  req.addEventListener 'readystatechange', ->
    if req.readyState is 4                        # ReadyState Complete
      successResultCodes = [200, 304]
      if req.status in successResultCodes
        data = JSON.parse req.response
        city = data.locations[0].properties.city
        state = data.locations[0].properties.state
        currentLocation.innerHTML = "#{city}, #{state}"
      else
        console.log 'Error loading data...'

  req.open 'GET', url, false
  req.send()


# Add some pizzazz
links = document.querySelectorAll('.pizzazz')
GifLinks links, { preload: true }

# Fetch current location from TheDemocraticTravelers.com
currentLocation = document.getElementById 'current-location'
if currentLocation
  url = 'http://www.thedemocratictravelers.com/api/v1/locations/current'
  currentLocation.addEventListener 'ready', loadDataFromServer(url), false
