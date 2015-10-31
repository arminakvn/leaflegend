(function() {
  var cartoDataUrl, closeTooltip, getStyle, leafleg, legend, map, mousemove, mouseout, mouseover, onEachFeature, parse, popup, ready, statesLayer, tractsById, zoomToFeature;

  leafleg = L.leaflegend().color1("skyblue").color2("purple").steps(4).xsize(4).ysize(4).makeGrid();

  getStyle = function(feature) {
    return {
      weight: 1,
      opacity: 0.4,
      color: "black",
      fillOpacity: 0.95,
      fillColor: leafleg.getColorByRangeAndSize(feature.properties.land_value, feature.properties.far).c,
      className: "range-" + leafleg.getColorByRangeAndSize(feature.properties.land_value, feature.properties.far).i,
      id: "range-" + leafleg.getColorByRangeAndSize(feature.properties.land_value, feature.properties.far).i
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
    var layer;
    layer = e.target;
    return console.log("layer", layer);
  };

  mousemove = function(e) {
    var layer;
    layer = e.target;
    if (e.target) {
      leafleg.highlightByFeature(e);
    }
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

  map = L.mapbox.map("map").setView([42.625183, -70.678424], 13);

  cartoDataUrl = "http://arminavn.cartodb.com/api/v2/sql?format=geojson&q=SELECT * FROM glsterparcels WHERE land_value < 5500000 &api_key=9150413ca8fb81229459d0a5c2947620e42d0940";

  L.mapbox.tileLayer('arminavn.4o0plkma').addTo(map);

  $.ajax(cartoDataUrl, {
    type: 'GET',
    dataType: 'json',
    error: function(jqXHR, textStatus, errorThrown) {
      return console.log("error");
    },
    success: (function(_this) {
      return function(data, textStatus, jqXHR) {
        var statesLayer;
        console.log(data);
        return statesLayer = L.geoJson(data, {
          style: getStyle,
          onEachFeature: onEachFeature
        }).addTo(map).bindPopup();
      };
    })(this)
  });

  map.scrollWheelZoom.disable();

  popup = new L.Popup({
    autoPan: false
  });

  tractsById = d3.map();

  console.log(tractsById);

  parse = function(error, row) {};

  ready = function(error, us) {
    if (error) {
      throw error;
    }
    console.log(us);
  };

  statesLayer = L.geoJson(null, {
    style: getStyle,
    onEachFeature: onEachFeature
  }).addTo(map).bindPopup();

  legend = L.control({
    position: "bottomright"
  });

  console.log(statesLayer);

  legend.onAdd = function(map) {
    var div, leg_div;
    leafleg = L.leaflegend().color1("skyblue").color2("purple").nameLegCols(['land_value', 'far']).steps(4).xsize(4).ysize(4).xintervals([0, .75, .2, 5, 10]).yintervals([0, 400000, 420000, 440000, 5500000]).makeGrid();
    div = void 0;
    div = document.getElementById("leaflegend");
    leg_div = leafleg.getLegendHTML(map);
    return div;
  };

  legend.addTo(map);

  closeTooltip = void 0;

}).call(this);
