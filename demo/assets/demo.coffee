leafleg = L.leaflegend().color1("skyblue").color2("purple").steps(4).xsize(4).ysize(4).makeGrid()
getStyle = (feature) ->
  # console.log "tractsById", tractsById, "feature", feature
  # fill = (id) ->    
  # tract = tractsById.get(id)
  # if tract and tract[selected]
  #   color tract[selected]
  # else
  #   'none'

  weight: 1
  opacity: 0.4
  color: "black"
  fillOpacity: 0.95
  fillColor: leafleg.getColorByRangeAndSize(feature.properties.land_value,feature.properties.far).c
  className: "range-" + leafleg.getColorByRangeAndSize(feature.properties.land_value,feature.properties.far).i
  id: "range-" + leafleg.getColorByRangeAndSize(feature.properties.land_value,feature.properties.far).i

onEachFeature = (feature, layer) ->
  layer.on
    mousemove: mousemove
    mouseout: mouseout
    mouseover: mouseover
    click: zoomToFeature

  return
mouseover = (e) ->
  layer = e.target
  console.log "layer", layer
  # layerPopup = L.popup()
  #          .setLatLng(e.latlng)
  #          .setContent(layer.feature.properties.owner_name)
  #           .openOn(map)
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
  42.625183
  -70.678424
], 13)
cartoDataUrl = "http://arminavn.cartodb.com/api/v2/sql?format=geojson&q=SELECT * FROM glsterparcels WHERE land_value < 5500000 &api_key=9150413ca8fb81229459d0a5c2947620e42d0940"
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
# console.log statesData

# statesLayer = L.geoJson(statesData,
  # style: getStyle
  # onEachFeature: onEachFeature
# ).addTo(map).bindPopup()
tractsById = d3.map()
console.log tractsById
# Parse the rows of the CSV, coerce strings to nums

parse = (error, row) ->
  # newRows = []
  # each = (d) ->
  #   if d == '-0'
  #     null
  #   else if d == '50.0+'
  #     50
  #   else
  #     +d

  #   console.log "row",d
  #   parsedRow = 
  #     tract: +d['GEO.id2']
  #     punemployed: each(d['HC03_VC12'])
  #     medhhinc: each(d['HC01_VC85'])
  #     medgrossrent: each(d['HD01_VD01'])
  #     meancommute: each(d['HC01_VC36'])
  #     homeownership: each(d['HD01_VD02'])
  #     walked: each(d['HC03_VC31'])
  #     ptransport: each(d['HC03_VC30'])
  #     poverty: each(d['HC03_VC161'])
  #   newRows.push parsedRow
  # tractsById.set row['GEO.id2'], newRows
  # parsedRow
ready = (error, us) ->
  if error
    throw error
  console.log us
  return
# jsondata = omnivore.topojson('assets/tracts2010topo.json', {})
# jsondata.addTo map
statesLayer = L.geoJson(null,
  style: getStyle
  onEachFeature: onEachFeature
).addTo(map).bindPopup()
# queue().defer(d3.csv, 'assets/boston-data.csv', (d) ->
#   return d
# ).await parse
legend = L.control(position: "bottomright")
console.log statesLayer

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
  leafleg = L.leaflegend().color1("skyblue").color2("purple").nameLegCols(['land_value', 'far']).steps(4).xsize(4).ysize(4).xintervals([0,.75,.2,5, 10]).yintervals([0, 400000, 420000,440000, 5500000]).makeGrid()
  # leafleg.nameLegCols('Educational attainment', 'Population density') # should be horizental then vertical, x then y
  div = undefined
  div = document.getElementById("leaflegend")
  leg_div = leafleg.getLegendHTML(map)
  div

legend.addTo map
closeTooltip = undefined


