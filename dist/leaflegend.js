(function(root, undefined) {

  "use strict";



/* leaflegend main */

(function() {
  var addChainedAttributeAccessor, leaflegend,
    __slice = [].slice;

  leaflegend = L.LeafLegend = L.Class.extend({
    includes: L.Mixin.Events,
    options: {
      color1: "",
      color2: "",
      steps: 4,
      xmin: 0,
      xmax: 49,
      ymin: 0,
      ymax: 1190,
      xsize: 4,
      ysize: 4,
      cols1: [],
      gdrow: [],
      colurschema1: [],
      colurschema2: [],
      colurschema3: [],
      colurschema4: [],
      cellColorIndex: [],
      xintervals: [],
      yintervals: [],
      rects: [],
      cell_width: [],
      legend_el: void 0,
      gridwidth: 164,
      xintervalSize: 100,
      yintervalSize: 10,
      gutter_width: 0,
      row_label_width: 120,
      index_dicts: [],
      nameCols: ["", ""]
    },
    initialize: function(data, options) {
      var _this;
      _this = this;
      L.setOptions(_this, options);
    },
    color1: function(newColor1) {
      this.options.color1 = newColor1;
      return this;
    },
    color2: function(newColor2) {
      this.options.color2 = newColor2;
      return this;
    },
    steps: function(newSteps) {
      this.options.steps = newSteps;
      return this;
    },
    xmin: function(newXmin) {
      this.options.xmin = newXmin;
      return this;
    },
    ymin: function(newYmin) {
      this.options.ymin = newYmin;
      return this;
    },
    xmax: function(newXmax) {
      this.options.xmax = newXmax;
      return this;
    },
    ymax: function(newYmax) {
      this.options.ymax = newYmax;
      return this;
    },
    xsize: function(newXsize) {
      this.options.xsize = newXsize;
      return this;
    },
    ysize: function(newYsize) {
      this.options.ysize = newYsize;
      return this;
    },
    cols1: function(newCols1) {
      this.options.cols1 = newCols1;
      return this;
    },
    gdrow: function(newGdrow) {
      this.options.gdrow = newGdrow;
      return this;
    },
    colurschema1: function(newColurschema1) {
      this.options.colurschema1 = newColurschema1;
      return this;
    },
    colurschema2: function(newColurschema2) {
      this.options.colurschema2 = newColurschema2;
      return this;
    },
    colurschema3: function(newColurschema3) {
      this.options.colurschema3 = newColurschema3;
      return this;
    },
    colurschema4: function(newColurschema4) {
      this.options.colurschema4 = newColurschema4;
      return this;
    },
    cellColorIndex: function(newCellColorIndex) {
      this.options.cellColorIndex = newCellColorIndex;
      return this;
    },
    rects: function(newRects) {
      this.options.rects = newRects;
      return this;
    },
    cell_width: function(newCellWidth) {
      this.options.cell_width = newCellWidth;
      return this;
    },
    legend_el: function(newLegendEl) {
      this.options.legend_el = newLegendEl;
      return this;
    },
    gridwidth: function(newGridwidth) {
      this.options.gridwidth = newGridwidth;
      return this;
    },
    xintervalSize: function(newXintervalSize) {
      this.options.xintervalSize = newXintervalSize;
      return this;
    },
    yintervalSize: function(newYintervalSize) {
      this.options.yintervalSize = newYintervalSize;
      return this;
    },
    gutterWidth: function(newGutterWidth) {
      this.options.gutter_width = newGutterWidth;
      return this;
    },
    rowLabelWidth: function(rowLabelWidth) {
      this.options.row_label_width = rowLabelWidth;
      return this;
    },
    indexDicts: function(newIndexDicts) {
      this.options.index_dicts = newIndexDicts;
      return this;
    },
    nameCols: function(newNameCols) {
      this.options.nameCols = newNameCols;
      return this;
    },
    nameLegCols: function(horizarntalvertical) {
      return this.nameCols(horizarntalvertical);
    },
    makeGrid: function() {
      var $palettes, bez, cell_width, cl1, cl2, color1, color2, cols1, colurs, colurschema1, colurschema2, colurschema3, colurschema4, colurseq, colursstatements, gdc, gdrow, grid_size, grid_size_effective, gridwidth, gutter_width, height, i, icreament_size, j, leg_el, legend_el, m, n, pallets, rects, steps, width, x, x_size, xintervalSize, xintervals, xsize, y_size, yintervalSize, yintervals, ysize, _i, _j, _k, _l, _m, _n, _o, _p, _q, _r, _s;
      color1 = this.options.color1;
      color2 = this.options.color2;
      steps = this.options.steps;
      grid_size_effective = steps;
      grid_size = grid_size_effective;
      x_size = this.options.steps;
      y_size = this.options.steps;
      icreament_size = 1 / grid_size;
      $palettes = [];
      for (i = _i = 0; 0 <= grid_size ? _i < grid_size : _i > grid_size; i = 0 <= grid_size ? ++_i : --_i) {
        $palettes.push("$#palette" + ("" + i));
      }
      pallets = [];
      for (i = _j = 0; 0 <= grid_size ? _j < grid_size : _j > grid_size; i = 0 <= grid_size ? ++_j : --_j) {
        pallets.push('=$("#pallet' + ("" + i) + '")');
      }
      for (n = _k = 0; 0 <= grid_size ? _k < grid_size : _k > grid_size; n = 0 <= grid_size ? ++_k : --_k) {
        pallets[n] = $palettes[n];
      }
      colurschema1 = [];
      colurschema2 = [];
      colurschema3 = [];
      colurschema4 = [];
      for (x = _l = 0; _l < 1; x = _l += icreament_size) {
        colurschema1.push(chroma.interpolate(color1, "black", x, "lab").hex());
        colurschema2.push(chroma.interpolate("black", color2, x, "lab").hex());
        colurschema3.push(chroma.interpolate(color1, "white", x, "lab").hex());
        colurschema4.push(chroma.interpolate("white", color2, x, "lab").hex());
      }
      colurs = [];
      cols1 = [];
      colursstatements = [];
      for (i = _m = 0; 0 <= grid_size ? _m < grid_size : _m > grid_size; i = 0 <= grid_size ? ++_m : --_m) {
        colurs.push("colurs" + i);
      }
      colurs[i];
      colurseq = colurs[i] = [];
      for (x = _n = 0; 0 <= grid_size ? _n < grid_size : _n > grid_size; x = 0 <= grid_size ? ++_n : --_n) {
        if (x === void 0) {

        } else {
          cl1 = colurschema3[x];
          cl2 = colurschema2[x];
          for (m = _o = 0; _o < 1; m = _o += icreament_size) {
            cols1.push(chroma.interpolate(cl1, cl2, m, "lab"));
          }
        }
      }
      xintervalSize = this.options.xmax / x_size;
      xintervals = [];
      for (i = _p = 0; 0 <= x_size ? _p < x_size : _p > x_size; i = 0 <= x_size ? ++_p : --_p) {
        xintervals.push(this.options.xmin + (i * xintervalSize));
      }
      yintervalSize = this.options.ymax / this.options.ysize;
      yintervals = [];
      for (i = _q = 0; 0 <= y_size ? _q < y_size : _q > y_size; i = 0 <= y_size ? ++_q : --_q) {
        yintervals.push(this.options.ymin + (i * yintervalSize));
      }
      this.xintervals = xintervals;
      this.yintervals = yintervals;
      this.options.xintervals = xintervals;
      this.options.yintervals = yintervals;
      this.colurschema1(colurschema1);
      this.colurschema2(colurschema2);
      this.colurschema3(colurschema3);
      this.colurschema4(colurschema4);
      this.cols1(cols1);
      this.options.xintervalSize = xintervalSize;
      this.xintervalSize(xintervalSize);
      this.yintervalSize(yintervalSize);
      leaflegend = this;
      steps = leaflegend.options.steps;
      xsize = leaflegend.options.xsize;
      ysize = leaflegend.options.ysize;
      bez = 'checked';
      cell_width = 40;
      gutter_width = 3;
      icreament_size = 1 / grid_size;
      steps = leaflegend.options.steps;
      this.cell_width(cell_width);
      this.gutterWidth(gutter_width);
      gridwidth = steps * (cell_width + gutter_width);
      this.gridwidth(gridwidth);
      rects = [];
      width = gridwidth;
      height = gridwidth;
      if (legend_el === void 0) {
        legend_el = L.DomUtil.create("div", "info legend");
        legend_el.setAttribute("id", "leaflegend");
        $("body").append(legend_el);
      } else {
        legend_el = this.options.legend_el;
      }
      leg_el = $(legend_el);
      this._div = leg_el;
      leg_el.css('width', gridwidth + this.options.row_label_width);
      leg_el.css('height', gridwidth);
      leg_el.css('margin-right', cell_width);
      leg_el.css('margin-bottom', 2 * cell_width);
      leg_el.css('width', gridwidth + this.options.row_label_width).html('');
      gdc = {};
      gdrow = [];
      n = 0;
      for (i = _r = 0; 0 <= xsize ? _r < xsize : _r > xsize; i = 0 <= xsize ? ++_r : --_r) {
        for (j = _s = 0; 0 <= ysize ? _s < ysize : _s > ysize; j = 0 <= ysize ? ++_s : --_s) {
          if (this.options.cols1[(i * xsize) + j] === void 0) {

          } else {
            if (xintervals[j + 1] !== void 0) {
              gdrow.push({
                i: n,
                x: "" + xintervals[j] + "-" + xintervals[j + 1],
                y: "" + yintervals[j] + " &ndash; " + yintervals[j + 1],
                c: this.options.cols1[(i * xsize) + j]
              });
            }
            if (xintervals[j + 1] === void 0) {
              gdrow.push({
                i: n,
                x: "" + xintervals[j] + "-" + this.options.xmax,
                y: "" + yintervals[j] + " &ndash; " + this.options.ymax,
                c: this.options.cols1[(i * xsize) + j]
              });
            }
            n = n + 1;
          }
        }
      }
      this.gdrow(gdrow);
      return this;
    },
    getLegendHTML: function(map) {
      var cell_width, col, colum_from, div, from, gdrow, gridwidth, i, increment_in_em, j, label1_color_option, label1_position_option, label1_rotate_option, label2_color_option, label2_position_option, label2_rotate_option, legend, legendObject, legendRowObject, legend_el, textControl, to, xintervalSize, xmin, xsize, yintervalSize, ymin, ysize, _i, _j, _k;
      this.map = map;
      this._m = map;
      xmin = this.options.xmin;
      ymin = this.options.ymin;
      xintervalSize = this.options.xintervalSize;
      yintervalSize = this.options.yintervalSize;
      gdrow = this.options.gdrow;
      xsize = this.options.xsize;
      ysize = this.options.ysize;
      legend_el = this.options.legend_el;
      legend = [];
      legendObject = [];
      legendRowObject = [];
      this._legendObject = [];
      cell_width = this.options.cell_width;
      label1_rotate_option = 0;
      label1_position_option = this.options.steps * this.options.cell_width / 10.5;
      label1_color_option = "blue";
      label2_rotate_option = -90;
      label2_position_option = this.options.steps * this.options.cell_width / 19;
      label2_color_option = "red";
      from = void 0;
      to = void 0;
      i = 0;
      increment_in_em = 3.5;
      legendObject.push("<span style=\"height:" + this.options.cell_width + "px;\">" + "<div style=\"width:" + (2 * this.options.cell_width) + ("px; position: relative; height: 0; text-align: left; color: " + label1_color_option + "; font-weight: bold;") + ("  -webkit-transform: translate(" + (1 * increment_in_em - 6 - increment_in_em) + "em,-7em); -moz-transform: translate(" + (1 * increment_in_em - 6 - increment_in_em) + "em,-7em); -o-transform: translate(" + (1 * increment_in_em - 6 - increment_in_em) + "em,-7em); -ms-transform: translate(" + (1 * increment_in_em - 6 - increment_in_em) + "em,-7em); transform: translate(" + (1 * increment_in_em - increment_in_em) + "em," + label1_position_option + "em);\">") + ("<div style=\"-webkit-transform: rotate(" + label1_rotate_option + "deg); -moz-transform: rotate(" + label1_rotate_option + "deg);\">") + this.options.nameCols[1] + "</div></div></span>");
      for (col = _i = 0; 0 <= ysize ? _i < ysize : _i > ysize; col = 0 <= ysize ? ++_i : --_i) {
        legendObject.push("<span style=\"height:" + this.options.cell_width + "px;\">" + "<div style=\"width:" + (2 * this.options.cell_width) + ("px; position: relative; height: 0; text-align: left; color: " + label1_color_option + ";") + ("  -webkit-transform: translate(" + (col * increment_in_em + 1 - increment_in_em) + "em,-6em); -moz-transform: translate(" + (col * increment_in_em + 1 - increment_in_em) + "em,-6em); -o-transform: translate(" + (col * increment_in_em + 1 - increment_in_em) + "em,-6em); -ms-transform: translate(" + (col * increment_in_em + 1 - increment_in_em) + "em,-6em); transform: translate(" + (col * increment_in_em + 4 - increment_in_em) + "em,-4em);\">") + "<div style=\"-webkit-transform: rotate(-45deg); -moz-transform: rotate(-45deg);\">" + gdrow[col].y + "</div></div></span>");
      }
      legendObject.push("<span style=\"height:" + this.options.cell_width + "px;\">" + "<div style=\"width:" + (2 * this.options.cell_width) + ("px; position: relative; height: 0; text-align: left;  color: " + label2_color_option + "; font-weight: bold;") + ("  -webkit-transform: translate(" + (xsize * increment_in_em + 6 + increment_in_em) + "em,-7em); -moz-transform: translate(" + (xsize * increment_in_em + 6 + increment_in_em) + "em,-7em); -o-transform: translate(" + (xsize * increment_in_em + 6 + increment_in_em) + "em,-7em); -ms-transform: translate(" + (xsize * increment_in_em + 6 + increment_in_em) + "em,-7em); transform: translate(" + (xsize * increment_in_em + 2) + "em," + (ysize * increment_in_em) + "em); -webkit-transform: translate(" + (-cell_width / 7) + "em," + label2_position_option + "em);\">") + ("<div style=\"-webkit-transform: rotate(" + label2_rotate_option + "deg); -moz-transform: rotate(" + label2_rotate_option + "deg);\">") + this.options.nameCols[0] + "</div></div></span>");
      for (j = _j = 0; 0 <= ysize ? _j < ysize : _j > ysize; j = 0 <= ysize ? ++_j : --_j) {
        legendRowObject = [];
        from = gdrow[j].i * xintervalSize;
        colum_from = gdrow[j];
        for (i = _k = 0; 0 <= xsize ? _k < xsize : _k > xsize; i = 0 <= xsize ? ++_k : --_k) {
          legendRowObject.push("<span class=\"swatch\" style=\"background:" + gdrow[(j * xsize) + i].c + "; position: initial; display:block; float:left; height:" + this.options.cell_width + "px; width:" + this.options.cell_width + "px;\"" + "id=" + gdrow[(j * xsize) + i].i + "></span> ");
          legendRowObject.push("<span class=\"swatch-gutter\" style=\"background:none; position: relative; display:block; float:left; height:" + this.options.cell_width + "px; width:" + this.options.gutter_width + "px;\"" + "></span> ");
          i++;
        }
        to = gdrow[j + 1].i * xintervalSize;
        gridwidth = this.options.gridwidth + this.options.row_label_width;
        legendObject.push("<li style=\"height:" + this.options.gutter_width + "px; position: relative; width:" + gridwidth + "px;" + "\">" + "</li>");
        legendObject.push("<li style=\"height:" + this.options.cell_width + ("px;  color: " + label2_color_option + "; position: relative; width:") + gridwidth + "px;" + "\">" + legendRowObject.join("") + "\v " + "\v " + "\v " + "\v " + "\v " + gdrow[j].x + "</li>");
        this._legendObject.push(legendObject);
        j++;
      }
      legend.push("<ul style=\"width: " + gridwidth + "px; list-style-type:none\">" + legendObject.join("") + "</ul>");
      textControl = L.Control.extend({
        options: {
          position: "bottomright"
        },
        onAdd: (function(_this) {
          return function(map) {
            if (_this._m === void 0) {
              _this._m = map;
            }
            if (_this._legendDomEl === void 0) {
              _this._legendDomEl = L.DomUtil.create("div", "info legend");
              _this._legendDomEl.setAttribute("id", "leaflegend");
              _this._m.getPanes().overlayPane.appendChild(_this._legendDomEl);
            }
          };
        })(this)
      });
      div = document.getElementById("leaflegend");
      div.innerHTML += legend;
      L.DomEvent.addListener(div, 'mouseover', (function(e) {
        var key, mapLayers, value;
        $(e.target).css('cursor', 'pointer');
        if ($(e.target).prop('class') === 'swatch') {
          $(e.target).css('border', '3px solid white');
          $(e.target).css('opacity', '0.8');
          $(e.target).css('border-radius', '10%');
        }
        mapLayers = this._m._layers;
        for (key in mapLayers) {
          value = mapLayers[key];
          if (value.options && value.options.className === ("range-" + e.target.id)) {
            value.bringToFront();
            value.setStyle({
              weight: 3,
              opacity: 0.9,
              fillOpacity: 0.9
            });
          }
        }
      }), this);
      L.DomEvent.addListener(div, 'mouseout', (function(e) {
        var key, mapLayers, value;
        $(e.target).css('cursor', 'default');
        mapLayers = this._m._layers;
        $(e.target).css('border', '0px solid white');
        $(e.target).css('opacity', '1');
        $(e.target).css('border-radius', '0%');
        for (key in mapLayers) {
          value = mapLayers[key];
          if (value.options && value.options.className === ("range-" + e.target.id)) {
            value.setStyle({
              weight: 1,
              opacity: 0.4,
              fillOpacity: 1
            });
          }
        }
      }), this);
      div;
    },
    addTo: function(map) {
      map.addLayer(this);
      return this;
    },
    getIndexByColor: function(event) {
      var e, each, x_in, x_out, y_in, y_out, _i, _len, _ref;
      _ref = this.options.gdrow;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        each = _ref[_i];
        x_in = (each.x.split("-"))[0];
        x_out = (each.x.split("-"))[1];
        y_in = (each.y.split("-"))[0];
        y_out = (each.y.split("-"))[1];
        try {
          if (each.c.hex() === event.target.options.fillColor.hex()) {
            try {
              return each.i;
            } catch (_error) {
              e = _error;
            }
          }
        } catch (_error) {
          e = _error;
          if (each.c.hex() === event.layer.options.fillColor.hex()) {
            return each.i;
          }
        }
      }
    },
    highlightByFeature: function(e) {
      var className_, class_Name, key, legEl, value, _ref;
      if (e.target.options) {
        className_ = e.target.options.className;
      } else {
        _ref = e.target._layers;
        for (key in _ref) {
          value = _ref[key];
          if (value.options.className !== void 0) {
            className_ = value.options.className;
          }
        }
      }
      class_Name = className_.replace("range-", "");
      legEl = L.DomUtil.get(class_Name);
      $(legEl).css('border', '3px solid white');
      return $(legEl).css('border-radius', '10%');
    },
    resetHighlightByFeature: function(e) {
      var className_, class_Name, key, legEl, value, _ref;
      if (e.target.options) {
        className_ = e.target.options.className;
      } else {
        _ref = e.target._layers;
        for (key in _ref) {
          value = _ref[key];
          if (value.options.className !== void 0) {
            className_ = value.options.className;
          }
        }
      }
      class_Name = className_.replace("range-", "");
      legEl = L.DomUtil.get(class_Name);
      $(legEl).css('border', '0px solid white');
      return $(legEl).css('border-radius', '0%');
    },
    getColorByRangeAndSize: function(x_val, y_val) {
      var e, index_dicts, ix_intervals, iy_intervals;
      ix_intervals = Math.floor(x_val / this.options.xintervalSize);
      iy_intervals = Math.floor(y_val / this.options.yintervalSize);
      this.cellColorIndex = (iy_intervals * this.options.xsize) + ix_intervals;
      this.cellColor = this.options.gdrow[this.cellColorIndex];
      try {
        index_dicts = this.options.index_dicts;
        index_dicts.push({
          i: this.cellColor.i,
          x_val: x_val,
          y_val: y_val,
          x: this.cellColor.x,
          y: this.cellColor.y,
          color: this.cellColor.c
        });
        this.indexDicts(index_dicts);
        return this.cellColor;
      } catch (_error) {
        e = _error;
        return this.cellColor = NaN;
      }
    }
  });

  L.control.command = function(options) {
    return new L.Control.Command(options);
  };

  L.leaflegend = function(data, options) {
    return new L.LeafLegend(data, options);
  };

  addChainedAttributeAccessor = function(obj, propertyAttr, attr) {
    return obj[attr] = function() {
      var newValues;
      newValues = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (newValues.length === 0) {
        return obj[propertyAttr][attr];
      } else {
        obj[propertyAttr][attr] = newValues[0];
        return obj;
      }
    };
  };

  true;

  leaflegend.VERSION = '0.0.0';

  root.leaflegend = leaflegend;

}).call(this);


}(this));
