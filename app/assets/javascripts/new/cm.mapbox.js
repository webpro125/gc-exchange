(function ($) {
    $(function () {
        var hasMap = !!$('[data-type="cm-map"]').length;

        if (!hasMap) return;

        var options = {
            map: {
                minZoom: 5,
                maxZoom: 9,
                zoom: 7,
                center: [30, -85],
                maxBounds: [[50, -129], [23, -63]]
            },
            users: {
                endpoint: '/js/resources/geojson/users.geojson',
                icon: {
                    iconUrl: '/images/svg/pin.svg',
                    iconSize: [40, 40],
                    className: 'single-pin'
                }
            },
            waves: {
                endpoint: {
                    9: '/js/resources/geojson/waves-9.geojson',
                    8: '/js/resources/geojson/waves-8.geojson',
                    7: '/js/resources/geojson/waves-7.geojson'
                }
            }
        };

        var details = {
            center: $('.map-center'),
            mouse: $('.map-mouse'),
            popup: $('.leaflet-popup-pane'),
            zoom: $('.map-zoom')
        };

        var templates = {
            user: Handlebars.compile($('#map-cluster-user').html()),
            popup: Handlebars.compile($('#map-cluster-popup').html())
        };

        // initiate and configure mapbox
        L.mapbox.accessToken = 'pk.eyJ1IjoiZ2NlcyIsImEiOiJjaW5hZHZjMGwwaDc3djBrcTVtZDB4dTB6In0.CNlYH0qbhmfn46jOgWnuNg';

        var map = L.mapbox.map('map', 'gces.707d3d74', options.map);

        // add wave layer
        var waveLayers = {
            9: L.mapbox.featureLayer(),
            8: L.mapbox.featureLayer(),
            7: L.mapbox.featureLayer()
        };

        $.each(waveLayers, function (zoom, layer) {
            $.get(options.waves.endpoint[zoom], function (data) {
                layer.setGeoJSON(JSON.parse(data));
            });

            layer.on('layeradd', function (event) {
                var marker = event.layer;
                var feature = marker.feature;

                marker.setIcon(L.icon(feature.properties.icon));
            });
        });

        map.addLayer(waveLayers[options.map.zoom]);

        map.on('zoomend', function () {
            var currentZoom = map.getZoom();

            $.each(waveLayers, function (zoom, layer) {
                if (currentZoom == zoom) {
                    map.addLayer(layer);
                } else {
                    map.removeLayer(layer);
                }
            });
        });

        // add user layer
        var userMarkers = L.markerClusterGroup({
            showCoverageOnHover: false,
            zoomToBoundsOnClick: false,
            spiderfyOnMaxZoom: false
        });

        userMarkers.on('clusterclick', function (event) {
            var layer = event.layer;
            var content = [];

            $.each(layer.getAllChildMarkers(), function (key, marker) {
                content.push({content: marker.getPopup().getContent()});
            });

            content = templates.popup({content: content});

            layer.bindPopup(content);
            layer.openPopup();

            // bind paginator
        });

        $.get(options.users.endpoint, function (data) {
            var geoJsonLayer = L.geoJson(JSON.parse(data));

            geoJsonLayer.eachLayer(function (layer) {
                var properties = layer.feature.properties;

                layer.bindPopup(templates.user({
                    name: properties.firstName + ' ' + properties.lastName,
                    profile: '',
                    title: properties.title,
                    image: properties.image
                }));

                layer.setIcon(L.icon(options.users.icon));
            });

            userMarkers.addLayer(geoJsonLayer);
            map.addLayer(userMarkers);
        });



        // @TODO: REMOVE BEFORE GOING LIVE!

        updateCenter();
        updateMouse(map.getCenter());
        updateZoom();

        map.on('drag', function () {
            updateCenter();
        });

        map.on('zoomend', function () {
            updateZoom();
        });

        map.on('mousemove', function (event) {
            updateMouse(event.latlng);
        });

        function round(value) {
            return Math.round(value * 100) / 100;
        }

        function updateCenter() {
            var center = _.mapValues(map.getCenter(), function (value) {
                return round(value);
            });

            details.center.text(center.lat + ', ' + center.lng);
        }

        function updateZoom() {
            var zoom = round(map.getZoom());

            details.zoom.text(zoom);
        }

        function updateMouse(latlng) {
            var center = _.mapValues(latlng, function (value) {
                return round(value);
            });

            details.mouse.text(center.lat + ', ' + center.lng);
        }
    });
})(jQuery);
