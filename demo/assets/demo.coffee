leafleg = L.leaflegend().color1("skyblue").color2("purple").steps(4).xsize(4).ysize(4).makeGrid()
getStyle = (feature) ->

  weight: 1
  opacity: 0.4
  color: "black"
  fillOpacity: 0.95
  fillColor: leafleg.getColorByRangeAndSize(feature.properties.total_valu,feature.properties.lot_areaft).c
  className: "range-" + leafleg.getColorByRangeAndSize(feature.properties.total_valu,feature.properties.lot_areaft).i
  id: "range-" + leafleg.getColorByRangeAndSize(feature.properties.total_valu,feature.properties.lot_areaft).i

onEachFeature = (feature, layer) ->
  layer.on
    mousemove: mousemove
    mouseout: mouseout
    mouseover: mouseover
    click: zoomToFeature

  return
mouseover = (e) ->
  layer = e.target
  layerPopup = L.popup()
           .setLatLng(e.latlng)
           .setContent(layer.feature.properties.owner_name)
            .openOn(map)
mousemove = (e) ->
  layer = e.target
  leafleg.highlightByFeature(e) if e.target
  # highlight feature
  layer.setStyle
    color: "white"
    weight: 3
    opacity: 0.8
    fillOpacity: 0.9

  layer.bringToFront()  if not L.Browser.ie and not L.Browser.opera
  return
mouseout = (e) ->
  statesLayer.resetStyle e.target
  layer = e.target
  colorIndex = leafleg.getIndexByColor e
  legendElement = document.getElementById(colorIndex)
  leafleg.resetHighlightByFeature(e) # if e.target
  # slowReset = window.setTimeout(-> 
  #   leafleg.resetHighlightByFeature(e) if e.target
  #   return
  # , 100)  
  # closeTooltip = window.setTimeout(->
  #   map.closePopup()
  #   return
  # , 100)
  return
zoomToFeature = (e) ->
  map.fitBounds e.target.getBounds()
  return

L.mapbox.accessToken = "pk.eyJ1IjoiYXJtaW5hdm4iLCJhIjoiSTFteE9EOCJ9.iDzgmNaITa0-q-H_jw1lJw"
map = L.mapbox.map("map").setView([
  42.62
  -70.69
], 12)
cartoDataUrl = "http://arminavn.cartodb.com/api/v2/sql?format=geojson&q=SELECT * FROM glsterparcels&api_key=9150413ca8fb81229459d0a5c2947620e42d0940"
L.mapbox.tileLayer('arminavn.4o0plkma').addTo( map)
$.ajax cartoDataUrl,
  type: 'GET'
  dataType: 'json'
  error: (jqXHR, textStatus, errorThrown) ->
    console.log "error"
  success: (data, textStatus, jqXHR) =>
    console.log data
    statesLayer = L.geoJson(data,
      style: getStyle
      onEachFeature: onEachFeature
    ).addTo(map).bindPopup()
    map.scrollWheelZoom.disable()
    popup = new L.Popup(autoPan: false)
#     # console.log statesData
#     # statesLayer = L.geoJson(data,
#     #   style: getStyle
#     #   onEachFeature: onEachFeature
#     # ).addTo(map).bindPopup()
#     # statesLayer = L.geoJson(statesData,
#     #   style: getStyle
#     #   onEachFeature: onEachFeature
#     # ).addTo(map).bindPopup()
    legend = L.control(position: "bottomright")


# cartodb.createVis("map2", 'https://arminavn.cartodb.com/api/v2/viz/f74d9b48-19e5-11e5-9b07-0e4fddd5de28/viz.json').on('done', (viz, layers) ->
#   console.log layers, layers[0], layers[1]
#   tiles_loader: false
#   # center_lat: 50,
#   # center_lon: 20,
#   # zoom: 3
#   layers[1].setInteraction true
#   # layer.on 'featureOver', (e, latlng, pos, data) ->
#   #   cartodb.log.log e, latlng, pos, data
#   #   return
#   # layer.on 'error', (err) ->
#   #   cartodb.log.log 'error: ' + err
#   #   return
#   return
# ).on 'error', ->
#   cartodb.log.log 'some error occurred'
#   return

    legend.onAdd = (map) ->
      leafleg = L.leaflegend().color1("skyblue").color2("purple").nameLegCols(['Educational attainment', 'Population density']).steps(4).xsize(4).ysize(4).makeGrid()
      # leafleg.nameLegCols('Educational attainment', 'Population density') # should be horizental then vertical, x then y
      div = undefined
      div = document.getElementById("leaflegend")
      leg_div = leafleg.getLegendHTML(map)
      div

    legend.addTo map
    closeTooltip = undefined


