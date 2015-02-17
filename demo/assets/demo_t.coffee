leafleg = L.leaflegend().color1("skyblue").color2("purple").steps(4).xsize(4).ysize(4).makeGrid()
getStyle = (feature) ->

  weight: 1
  opacity: 0.4
  color: "black"
  fillOpacity: 0.95
  fillColor: leafleg.getColorByRangeAndSize(feature.properties.per_capt,feature.properties.density).c
  className: "range-" + leafleg.getColorByRangeAndSize(feature.properties.per_capt,feature.properties.density).i
  id: "range-" + leafleg.getColorByRangeAndSize(feature.properties.per_capt,feature.properties.density).i

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
           .setContent(layer.feature.properties.name)
            .openOn(map)
mousemove = (e) ->
  layer = e.target
  # leafleg.highlightByFeature(e) if e.target
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
  37.8
  -96
], 4)
L.mapbox.tileLayer('arminavn.4o0plkma').addTo( map)
map.scrollWheelZoom.disable()
popup = new L.Popup(autoPan: false)
console.log statesData
statesLayer = L.geoJson(statesData,
  style: getStyle
  onEachFeature: onEachFeature
).addTo(map).bindPopup()
legend = L.control(position: "bottomright")

legend.onAdd = (map) ->
  leafleg = L.leaflegend().color1("skyblue").color2("purple").nameLegCols(['Educational attainment', 'Population density']).steps(4).xsize(4).ysize(4).makeGrid()
  # leafleg.nameLegCols('Educational attainment', 'Population density') # should be horizental then vertical, x then y
  div = undefined
  div = document.getElementById("leaflegend")
  leg_div = leafleg.getLegendHTML(map)
  div

legend.addTo map
closeTooltip = undefined


