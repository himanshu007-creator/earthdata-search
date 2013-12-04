ns = window.edsc.map.L

ns.ProjectionSwitcher = do (L) ->
  DomUtil = L.DomUtil

  ProjectionSwitcher = L.Control.extend
    options:
      position: 'topright'

    initialize: (options={}) ->
      L.Control.prototype.initialize.call(this, options);

    onAdd: (map) ->
      @map = map
      $root = $('<div class="projection-switcher leaflet-bar">
                   <a href="#arctic" class="projection-switcher-arctic" title="North Polar Stereographic">N</a>
                   <a href="#geo" class="leaflet-disabled projection-switcher-geo" title="WGS 84 / Plate Carree">=</a>
                   <a href="#antarctic" class="projection-switcher-geo" title="South Polar Stereographic">S</a>
                 </div>')

      @$root = $root
      $container = $(map.getContainer())
      gibsMap = $container.data('map')

      self = this

      $root.find('a').on 'click dblclick', (e) ->
        e.preventDefault()
        e.stopPropagation()
        newProjection = this.href.split('#')[1]
        gibsMap[newProjection]()

      map.on 'projectionchange', (e) ->
        self.setProjection e.projection

      $root[0]

    onRemove: (map) ->


    setProjection: (proj) ->
      $root = @$root
      $link = @$root.children("[href=##{proj}]")

      $link.siblings().removeClass('leaflet-disabled')
      $link.addClass('leaflet-disabled')

  exports = ProjectionSwitcher
