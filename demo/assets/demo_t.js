(function() {
  var closeTooltip, getStyle, leafleg, legend, map, mousemove, mouseout, mouseover, onEachFeature, popup, statesLayer, zoomToFeature;

  leafleg = L.leaflegend().color1("skyblue").color2("purple").steps(4).xsize(4).ysize(4).makeGrid();

  getStyle = function(feature) {
    return {
      weight: 1,
      opacity: 0.4,
      color: "black",
      fillOpacity: 0.95,
      fillColor: leafleg.getColorByRangeAndSize(feature.properties.per_capt, feature.properties.density).c,
      className: "range-" + leafleg.getColorByRangeAndSize(feature.properties.per_capt, feature.properties.density).i,
      id: "range-" + leafleg.getColorByRangeAndSize(feature.properties.per_capt, feature.properties.density).i
    };
  };

  onEachFeature = function(feature, layer) {
    layer.on({
      mousemove: mousemove,
      mouseout: mouseout,
      mouseover: mouseover,
      click: zoomToFeature
    });
  };

  mouseover = function(e) {
    var layer, layerPopup;
    layer = e.target;
    return layerPopup = L.popup().setLatLng(e.latlng).setContent(layer.feature.properties.name).openOn(map);
  };

  mousemove = function(e) {
    var layer;
    layer = e.target;
    layer.setStyle({
      color: "white",
      weight: 3,
      opacity: 0.8,
      fillOpacity: 0.9
    });
    if (!L.Browser.ie && !L.Browser.opera) {
      layer.bringToFront();
    }
  };

  mouseout = function(e) {
    var colorIndex, layer, legendElement;
    statesLayer.resetStyle(e.target);
    layer = e.target;
    colorIndex = leafleg.getIndexByColor(e);
    legendElement = document.getElementById(colorIndex);
    leafleg.resetHighlightByFeature(e);
  };

  zoomToFeature = function(e) {
    map.fitBounds(e.target.getBounds());
  };

  L.mapbox.accessToken = "pk.eyJ1IjoiYXJtaW5hdm4iLCJhIjoiSTFteE9EOCJ9.iDzgmNaITa0-q-H_jw1lJw";

  map = L.mapbox.map("map").setView([37.8, -96], 4);

  L.mapbox.tileLayer('arminavn.4o0plkma').addTo(map);

  map.scrollWheelZoom.disable();

  popup = new L.Popup({
    autoPan: false
  });

  console.log(statesData);

  statesLayer = L.geoJson(statesData, {
    style: getStyle,
    onEachFeature: onEachFeature
  }).addTo(map).bindPopup();

  legend = L.control({
    position: "bottomright"
  });

  legend.onAdd = function(map) {
    var div, leg_div;
    leafleg = L.leaflegend().color1("skyblue").color2("purple").nameLegCols(['Educational attainment', 'Population density']).steps(4).xsize(4).ysize(4).makeGrid();
    div = void 0;
    div = document.getElementById("leaflegend");
    leg_div = leafleg.getLegendHTML(map);
    return div;
  };

  legend.addTo(map);

  closeTooltip = void 0;

}).call(this);
