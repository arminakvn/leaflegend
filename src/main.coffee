### leaflegend main ###

# Base function.
leaflegend = L.LeafLegend = L.Class.extend(
  includes: L.Mixin.Events
  options:
    color1: ""
    color2: ""
    steps: 4
    xmin: 0
    xmax: 49
    ymin: 0
    ymax:  1190
    xsize: 4
    ysize: 4
    cols1: []
    gdrow: []
    colurschema1: []
    colurschema2: []
    colurschema3: []
    colurschema4: []
    cellColorIndex: []
    xintervals: []
    yintervals: []
    rects: []
    cell_width: []
    legend_el: undefined
    gridwidth: 164
    xintervalSize: 100
    yintervalSize: 10
    gutter_width: 0
    row_label_width: 120
    index_dicts: []
    nameCols:["",""]

  initialize: (data, options) ->
    _this = this
    L.setOptions _this, options
    return

  color1: (newColor1) ->
    @options.color1 = newColor1
    this
  color2: (newColor2) ->
    @options.color2 = newColor2
    this
  steps: (newSteps) ->
    @options.steps = newSteps
    this
  xmin: (newXmin) ->
    @options.xmin = newXmin
    this
  ymin: (newYmin) ->
    @options.ymin = newYmin
    this
  xmax: (newXmax) ->
    @options.xmax = newXmax
    this
  ymax: (newYmax) ->
    @options.ymax = newYmax
    this
  xsize: (newXsize) ->
    @options.xsize = newXsize
    this
  ysize: (newYsize) ->
    @options.ysize = newYsize
    this
  cols1: (newCols1) ->
    @options.cols1 = newCols1
    this
  gdrow: (newGdrow) ->
    @options.gdrow = newGdrow
    this
  colurschema1: (newColurschema1) ->
    @options.colurschema1 = newColurschema1
    this
  colurschema2: (newColurschema2) ->
    @options.colurschema2 = newColurschema2
    this
  colurschema3: (newColurschema3) ->
    @options.colurschema3 = newColurschema3
    this
  colurschema4: (newColurschema4) ->
    @options.colurschema4 = newColurschema4
    this
  cellColorIndex: (newCellColorIndex) ->
    @options.cellColorIndex = newCellColorIndex
    this
  rects: (newRects) ->
    @options.rects = newRects
    this
  cell_width: (newCellWidth) ->
    @options.cell_width = newCellWidth
    this
  legend_el: (newLegendEl) ->
    @options.legend_el = newLegendEl
    this
  gridwidth: (newGridwidth) ->
    @options.gridwidth = newGridwidth
    this
  xintervalSize: (newXintervalSize) ->
    @options.xintervalSize = newXintervalSize
    this
  yintervalSize: (newYintervalSize) ->
    @options.yintervalSize = newYintervalSize
    this
  gutterWidth: (newGutterWidth) ->
    @options.gutter_width = newGutterWidth
    this
  rowLabelWidth: (rowLabelWidth) ->
    @options.row_label_width = rowLabelWidth
    this
  indexDicts: (newIndexDicts) ->
    @options.index_dicts = newIndexDicts
    this
  nameCols: (newNameCols) ->
    @options.nameCols = newNameCols
    this

  nameLegCols: (horizarntalvertical) ->
    @nameCols horizarntalvertical

  makeGrid: ->
    color1 = @options.color1 # = chroma(68.67, -13.07, -46.59, 'lab') # this can be a chroma color object. e.g. chroma(68.67, -13.07, -46.59, 'lab') or a color e.g. 'green'
    color2 = @options.color2 # = chroma(76.84, 20.60, 51.06, 'lab') # this can be a chroma color object. e.g. chroma(76.84, 20.60, 51.06, 'lab') or a color e.g. 'tan'

    steps = @options.steps
    # grid size. still experimental. lch color model sometimes works better in 12 to 12 grids/needs more work
    grid_size_effective = steps
    grid_size = grid_size_effective # placeholder for a later idea to scale with better detail  
    x_size = @options.steps 
    y_size = @options.steps 
    icreament_size = 1 / grid_size 


    # palette params
    $palettes = []
    $palettes.push "$#palette" + "#{i}" for i in [0...grid_size]
    # palette elemets
    pallets = []
    pallets.push '=$("#pallet' + "#{i}" + '")' for i in [0...grid_size]

    pallets[n] = $palettes[n] for n in [0...grid_size]

    colurschema1 = []
    colurschema2 = []
    colurschema3 = []
    colurschema4 = []

    for x in [0...1] by icreament_size
      colurschema1.push chroma.interpolate(color1, "black", x, "lab").hex()
      colurschema2.push chroma.interpolate("black", color2, x, "lab").hex() 
      colurschema3.push chroma.interpolate(color1, "white", x, "lab").hex() 
      colurschema4.push chroma.interpolate("white", color2, x, "lab").hex() 

    colurs = []
    cols1 = []
    colursstatements = []
    for i in [0...grid_size]
      colurs.push "colurs" + i 
       
    colurs[i] 
    colurseq = colurs[i] = [] 
    
    for x in [0...grid_size] 
      if x is undefined
      else 
        cl1 = colurschema3[x] 
        cl2 = colurschema2[x]
        cols1.push chroma.interpolate(cl1,  cl2, m, "lab") for m in [0...1] by icreament_size
        # cols1.push m for m in colurschema4
    # 
    xintervalSize = @options.xmax/x_size
    xintervals = []
    xintervals.push @options.xmin + (i * xintervalSize) for i in [0...x_size]
    
    yintervalSize = @options.ymax/@options.ysize
    yintervals = []
    yintervals.push @options.ymin + (i * yintervalSize) for i in [0...y_size]
    
    @xintervals = xintervals
    @yintervals = yintervals
    @options.xintervals = xintervals
    @options.yintervals = yintervals
    @.colurschema1 colurschema1
    @.colurschema2 colurschema2
    @.colurschema3 colurschema3
    @.colurschema4 colurschema4
    @.cols1 cols1
    @options.xintervalSize = xintervalSize
    @.xintervalSize xintervalSize
    @.yintervalSize yintervalSize
    leaflegend = @
    steps = leaflegend.options.steps
    xsize = leaflegend.options.xsize
    ysize = leaflegend.options.ysize
    bez = 'checked'
    cell_width = 40
    gutter_width = 3
    icreament_size = 1 / grid_size 
    steps = leaflegend.options.steps 
    @cell_width cell_width
    @gutterWidth gutter_width
    gridwidth = steps * (cell_width + gutter_width)
    @gridwidth gridwidth
    # highlightCell = ->
    #   d3.select(this).style("stroke", "lightred")
    #   return

    rects = []
    width = gridwidth 
    height = gridwidth 

    # rectGrid = d3.layout.grid().bands().nodeSize([
    #   cell_width
    #   cell_width  
    # ]).padding([
    #   gutter_width
    #   gutter_width
    # ]).cols([
    #   steps
    # ]).rows([steps])

    if legend_el is undefined
        legend_el = L.DomUtil.create("div", "info legend")
        legend_el.setAttribute("id", "leaflegend")
        $( "body" ).append(legend_el)
    else 
        legend_el=@options.legend_el
    
    leg_el = $(legend_el)

    @_div = leg_el
    leg_el.css('width', gridwidth+ @options.row_label_width) 
    leg_el.css('height', gridwidth) 
    leg_el.css('margin-right', cell_width)
    leg_el.css('margin-bottom', 2 * cell_width) 
    leg_el.css('width', gridwidth + @options.row_label_width).html('')
    
    #### d3 version #####
    # svg = d3.select("#leaflegend").append("svg").attr(
    #   width: gridwidth
    #   height: gridwidth  
    # ).append("g").attr("transform", "translate(0,0)")
    #### d3 version #####

    # gdc = {}
    # gdrow = []
    # n = 0
    # for i in [0...xsize]
    #   for j in [0...ysize]
    #     if @options.cols1[((i) * (xsize)) + (j)] is undefined
    #       # n = n + 1
    #     else
    #       gdrow.push ({i: n, x: (j) * gridwidth, y: (i) * gridwidth, c: @options.cols1[((i) * (xsize)) + (j)]})
    #       n = n + 1
    # @.gdrow gdrow
    



    ############## leaflet version ################

    gdc = {}
    gdrow = []
    n = 0
    for i in [0...xsize]
      for j in [0...ysize]
        if @options.cols1[((i) * (xsize)) + (j)] is undefined
            # n = n + 1
        else 
          gdrow.push ({i: n, x: ("#{xintervals[j]}-#{xintervals[j+1]}"), y: ("#{yintervals[j]} &ndash; #{yintervals[j+1]}"), c: @options.cols1[((i) * (xsize)) + (j)]}) if xintervals[j+1] isnt undefined
          gdrow.push ({i: n, x: ("#{xintervals[j]}-#{@options.xmax}"), y: ("#{yintervals[j]} &ndash; #{@options.ymax}"), c: @options.cols1[((i) * (xsize)) + (j)]}) if xintervals[j+1] is undefined
          n = n + 1
    @.gdrow gdrow


    #### d3 version #####
    # rect = svg.selectAll(".rect").data(rectGrid(gdrow))
    # rect.enter().append("rect").attr("class", "rect").attr("width", cell_width).attr("height", cell_width).style("opacity", 1).style("fill", (d) ->
    #   return d.c).transition().attr("width", cell_width).attr("height",cell_width).attr("transform", (d) ->
    #   "translate(" + (d.x) + "," + d.y + ")"
    # ).style("opacity", 1)
    # # rect.on('mouseover', ->
    # #   return d3.select(this).style("fill", "#0F0"))
    # rect.exit().transition().attr("width", cell_width).attr("height",cell_width).attr("transform", (d) ->
    #   "translate(" + (d.x) + "," + d.y + ")"
    # ).style("opacity", 1e-6).remove()
    #### d3 version #####

    # @rects rect

    this

  getLegendHTML: (map) ->
    this.map = map
    @_m = map
    xmin =@options.xmin
    ymin =@options.ymin
    xintervalSize = @options.xintervalSize
    yintervalSize = @options.yintervalSize
    gdrow=@options.gdrow
    xsize=@options.xsize
    ysize=@options.ysize
    legend_el=@options.legend_el
    legend = []
    legendObject = []
    legendRowObject = []
    @_legendObject = []
    cell_width = @options.cell_width
    label1_rotate_option = 0 # optional to -45
    label1_position_option = @options.steps * @options.cell_width / 10.5 #-5 puts it on top ish
    label1_color_option = "blue"
    label2_rotate_option = -90
    label2_position_option = @options.steps * @options.cell_width / 19
    label2_color_option = "red"
    from = undefined
    to = undefined
    i = 0
    increment_in_em = 3.5 # setting up location paramater for legend labels
    gdrow_labels = gdrow[0..3]
    gdrow_labels.reverse()
    legendObject.push("<span style=\"height:" + @options.cell_width +  "px;\">" + "<div style=\"width:" + (2*@options.cell_width) + "px; position: relative; height: 0; text-align: left; color: #{label1_color_option}; font-weight: bold;" + "  -webkit-transform: translate(#{increment_in_em-increment_in_em}em,#{label1_position_option}em); -moz-transform: translate(#{increment_in_em-increment_in_em}em,#{label1_position_option}em); -o-transform: translate(#{increment_in_em-increment_in_em}em,#{label1_position_option}em); -ms-transform: translate(#{increment_in_em-increment_in_em}em,#{label1_position_option}em); transform: translate(#{increment_in_em-increment_in_em}em,#{label1_position_option}em);\">" + "<div style=\"-webkit-transform: rotate(#{label1_rotate_option}deg); -moz-transform: rotate(#{label1_rotate_option}deg);\">" + @.options.nameCols[1] + "</div></div></span>")
    legendObject.push("<span style=\"height:" + @options.cell_width +  "px;\">" + "<div style=\"width:" + (2*@options.cell_width) + "px; position: relative; height: 0; text-align: left; color: #{label1_color_option};" + "  -webkit-transform: translate(#{(col)*increment_in_em+1-increment_in_em}em,-6em); -moz-transform: translate(#{(col)*increment_in_em+1-increment_in_em}em,-6em); -o-transform: translate(#{(col)*increment_in_em+1-increment_in_em}em,-6em); -ms-transform: translate(#{(col)*increment_in_em+1-increment_in_em}em,-6em); -webkit-transform: translate(#{(col)*increment_in_em+4-increment_in_em}em,-4em); transform: translate(#{(col)*increment_in_em+4-increment_in_em}em,-4em);\">" + "<div style=\"-webkit-transform: rotate(-45deg); -moz-transform: rotate(-45deg);\">" + gdrow_labels[col].y + "</div></div></span>") for col in [0...ysize]
    legendObject.push("<span style=\"height:" + @options.cell_width +  "px;\">" + "<div style=\"width:" + (2*@options.cell_width) + "px; position: relative; height: 0; text-align: left;  color: #{label2_color_option}; font-weight: bold;" + "  -webkit-transform: translate(#{-cell_width/7}em,#{label2_position_option}em); -moz-transform: translate(#{-cell_width/7}em,#{label2_position_option}em); -o-transform: translate(#{-cell_width/7}em,#{label2_position_option}em); -ms-transform: translate(#{-cell_width/7}em,#{label2_position_option}em); transform: translate(#{-cell_width/7}em,#{label2_position_option}em); -webkit-transform: translate(#{-cell_width/7}em,#{label2_position_option}em);\">" + "<div style=\"-webkit-transform: rotate(#{label2_rotate_option}deg); -moz-transform: rotate(#{label2_rotate_option}deg);\">" + @.options.nameCols[0] + "</div></div></span>")
    for j in [0...ysize]
        legendRowObject = []
        from = gdrow[j].i * xintervalSize
        colum_from = gdrow[j]
        for i in [0...xsize]
            legendRowObject.push("<span class=\"swatch\" style=\"background:" + gdrow[(j*xsize)+i].c + "; position: initial; display:block; float:left; height:" + @options.cell_width + "px; width:" + @options.cell_width+ "px;\"" + "id=" + gdrow[(j*xsize)+i].i + "></span> ")
            legendRowObject.push("<span class=\"swatch-gutter\" style=\"background:none; position: relative; display:block; float:left; height:" + @options.cell_width + "px; width:" + @options.gutter_width+ "px;\"" + "></span> ")
            i++
        to = gdrow[j+1].i * xintervalSize
        gridwidth = @options.gridwidth + @options.row_label_width
        legendObject.push("<li style=\"height:" + @options.gutter_width + "px; position: relative; width:" + gridwidth + "px;" + "\">" +  "</li>")  # +"<span>" +  from + " to " + to +  "</span> ")
        legendObject.push("<li style=\"height:" + @options.cell_width + "px;  color: #{label2_color_option}; position: relative; width:" + gridwidth + "px;" + "\">" + legendRowObject.join("") + "\v " + "\v " + "\v " + "\v " + "\v " +gdrow[j].x+ "</li>")
        @_legendObject.push legendObject
        j++
    legend.push "<ul style=\"width: " + gridwidth + "px; list-style-type:none\">" + legendObject.join("") + "</ul>" 

    textControl = L.Control.extend(
      options:
        position: "bottomright"
      onAdd: (map) =>

        @_m = map if @_m is undefined  
        if @_legendDomEl is undefined
            @_legendDomEl = L.DomUtil.create("div", "info legend")
            @_legendDomEl.setAttribute("id", "leaflegend")
            @_m.getPanes().overlayPane.appendChild(@_legendDomEl)
        return
    )
    div = document.getElementById("leaflegend")
    div.innerHTML += legend
    # console.log "div", div
    L.DomEvent.addListener div, 'mouseover', ((e) ->
        $(e.target).css('cursor','pointer')
        if $(e.target).prop('class') == 'swatch'
            $(e.target).css('border', '3px solid white')
            $(e.target).css('opacity', '0.8')
            $(e.target).css('border-radius', '10%')
        mapLayers = @_m._layers
        for key, value of mapLayers
            if value.options and value.options.className == "range-#{e.target.id}"
                value.bringToFront()
                value.setStyle
                    weight: 3
                    opacity: 0.9
                    fillOpacity: 0.9
        return
    ), this
    L.DomEvent.addListener div, 'mouseout', ((e) ->
        $(e.target).css('cursor','default')
        mapLayers = @_m._layers
        $(e.target).css('border', '0px solid white')
        $(e.target).css('opacity', '1')
        $(e.target).css('border-radius', '0%')
        for key, value of mapLayers
            if value.options and value.options.className == "range-#{e.target.id}"
                value.setStyle
                    weight: 1
                    opacity: 0.4
                    fillOpacity: 1
        return
    ), this
    div
    return

  addTo: (map) ->
    map.addLayer this
    this

  
  getIndexByColor: (event) ->
    for each in @options.gdrow

        x_in = ((each.x).split "-")[0]
        x_out = ((each.x).split "-")[1]
        y_in = ((each.y).split "-")[0]
        y_out = ((each.y).split "-")[1]

        try
            if each.c.hex() == event.target.options.fillColor.hex()
                try
                    return each.i
                catch e
        catch e
            if each.c.hex() == event.layer.options.fillColor.hex()
                return each.i
   
  highlightByFeature: (e) ->
    if e.target.options
        className_ = e.target.options.className
    else
        for key, value of e.target._layers
            className_ = value.options.className if value.options.className isnt undefined
    class_Name= className_.replace("range-", "")
    legEl = L.DomUtil.get(class_Name)
    $(legEl).css('border', '3px solid white')
    $(legEl).css('border-radius', '10%')

  resetHighlightByFeature: (e) ->
    if e.target.options
        className_ = e.target.options.className
    else
        for key, value of e.target._layers
            className_ = value.options.className if value.options.className isnt undefined
    class_Name= className_.replace("range-", "")
    legEl = L.DomUtil.get(class_Name)
    $(legEl).css('border', '0px solid white')
    $(legEl).css('border-radius', '0%')

  getColorByRangeAndSize: (x_val, y_val) ->
    ix_intervals = Math.floor(x_val / @options.xintervalSize)
    iy_intervals = Math.floor(y_val / @options.yintervalSize)
    @cellColorIndex = ((iy_intervals)* @options.xsize) + ix_intervals 
    @cellColor = @options.gdrow[@cellColorIndex]
    try
        index_dicts = @options.index_dicts
        index_dicts.push ({i: @cellColor.i, x_val: x_val, y_val: y_val, x: @cellColor.x, y: @cellColor.y, color: @cellColor.c})

        @.indexDicts index_dicts

        return @cellColor
    catch e
        @cellColor = NaN
    

   
)
L.control.command = (options) ->
  new L.Control.Command(options)

L.leaflegend = (data, options) ->
  new L.LeafLegend(data, options)

addChainedAttributeAccessor = (obj, propertyAttr, attr) ->
    obj[attr] = (newValues...) ->
        if newValues.length == 0
            obj[propertyAttr][attr]
        else
            obj[propertyAttr][attr] = newValues[0]
            obj
  true

# Version.
leaflegend.VERSION = '0.0.0'
# Export to the root, which is probably `window`.
root.leaflegend = leaflegend

# ---
# generated by js2coffee 2.0.0