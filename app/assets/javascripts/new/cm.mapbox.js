(function ($) {
    $(function () {
        var hasMap = !!$('[data-type="cm-map"]').length;

        if (!hasMap) return;

        var options = {
            map: {
                minZoom: 5,
                maxZoom: 9,
                zoom: 7,
                zoomControl: false,
                center: [30, -85],
                maxBounds: [[70, -159], [3, -43]]
            },
            users: {
                endpoint: 'https://drake.gces.staging.c66.me/api/geo_users.json',
                icon: {
                    iconUrl: 'images/svg/pin.svg',
                    iconSize: [40, 40],
                    className: 'single-pin'
                },
                length: 26,
                pagination: {
                    limit: 5
                }
            },
            waves: {
                endpoint: {
                    9: 'js/resources/geojson/waves-9.geojson',
                    8: 'js/resources/geojson/waves-8.geojson',
                    7: 'js/resources/geojson/waves-7.geojson'
                }
            }
        };

        var details = {
            center: $('.map-center'),
            mouse: $('.map-mouse'),
            popup: $('.leaflet-popup-pane'),
            search: $('[data-type~="cm-search"]'),
            zoom: $('.map-zoom')
        };

        var templates = {
            user: Handlebars.compile($('#map-cluster-user').html()),
            popup: Handlebars.compile($('#map-cluster-popup').html()),
            popupUsers: Handlebars.compile($('#map-cluster-popup-users').html()),
            search: Handlebars.compile($('#map-search-results').html())
        };

        // initiate and configure mapbox
        L.mapbox.accessToken = 'pk.eyJ1IjoiZ2NlcyIsImEiOiJjaW5hZHZjMGwwaDc3djBrcTVtZDB4dTB6In0.CNlYH0qbhmfn46jOgWnuNg';

        var map = L.mapbox.map('map', 'gces.707d3d74', options.map);

        new L.Control.Zoom({position: 'bottomright'}).addTo(map);

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
        var userGeoJsonLayer = null;
        var userMarkers = L.markerClusterGroup({
            showCoverageOnHover: false,
            zoomToBoundsOnClick: false,
            spiderfyOnMaxZoom: false
        });

        userMarkers.on('clusterclick', function (event) {
            var layer = event.layer;
            var users = [];

            $.each(layer.getAllChildMarkers(), function (key, marker) {
                users.push({content: marker.getPopup().getContent()});
            });

            users = _.chunk(users, options.users.pagination.limit);

            layer.bindPopup(templates.popup());
            layer.openPopup();

            // bind paginator
            var index = 0;
            var pager = $('[data-section="pager-container"]');
            var content = pager.find('[data-section="pager-content"]');
            var navigation = pager.find('[data-section="pager-navigation"]');
            var prev = navigation.find('[data-section="pager-prev"]');
            var next = navigation.find('[data-section="pager-next"]');
            var currentPage = navigation.find('[data-section="page-current"]');
            var lastPage = navigation.find('[data-section="page-last"]');

            content.html(templates.popupUsers({users: users[index]}));
            currentPage.text(1);
            lastPage.text(users.length);

            prev.addClass('hidden');

            if (users.length <= 1) {
                next.addClass('hidden');
            }

            prev.on('click', function (event) {
                event.preventDefault();

                next.removeClass('hidden');
                content.html(templates.popupUsers({users: users[--index]}));
                currentPage.text(index);

                if (index <= 0) {
                    prev.addClass('hidden');
                    currentPage.text(1);
                }
            });

            next.on('click', function (event) {
                event.preventDefault();

                prev.removeClass('hidden');
                content.html(templates.popupUsers({users: users[++index]}));
                currentPage.text(index + 1);

                if (index >= users.length - 1) {
                    next.addClass('hidden');
                }
            });
        });

        $.get(options.users.endpoint, function (data) {
            userGeoJsonLayer = L.geoJson(data);

            userGeoJsonLayer.eachLayer(function (layer) {
                var properties = layer.feature.properties;

                layer.bindPopup(templates.user({
                    name: _.truncate(properties.firstName + ' ' + properties.lastName, {length: options.users.length}),
                    profile: properties.profile,
                    title: _.truncate(properties.title, {length: options.users.length}),
                    image: properties.image
                }));

                layer.setIcon(L.icon(options.users.icon));
            });

            userMarkers.addLayer(userGeoJsonLayer);
            map.addLayer(userMarkers);
        });

        // initiate and configure map searching functionality

        var exploreMap = $('.explore-map');
        var displayOverlay = $('[data-type~="display-overlay"]');
        var landingElement = $('.page-landing');
        var searchForm = details.search.parent('form');
        var searchElement = $('.landing-search');
        var searchResults = $('.search-results');

        var mapTimer = null;
        var mapOn = false;
        var mapHold = false;
        var showingResults = false;
        var userSearchLayer = null;

        // gather user data
        searchForm.on('submit', function (event) {
            event.preventDefault();

            var url = options.users.endpoint + '?q=' + details.search.val();
            var uid = 0;
            var results = [];

            $.get(url, function (data) {
                var southWest, northEast;

                searchElement.addClass('is-on');

                showingResults = true;

                $.each(data.features, function (index, item) {
                    var properties = item.properties;
                    var coordinates = item.geometry.coordinates;

                    if (!southWest || (southWest.lat > coordinates[1] && southWest.lng > coordinates[0])) {
                        southWest = L.latLng(coordinates[1], coordinates[0]);
                    }

                    if (!northEast || (northEast.lat < coordinates[1] && northEast.lng < coordinates[0])) {
                        northEast = L.latLng(coordinates[1], coordinates[0]);
                    }

                    results.push({
                        uid: index,
                        name: _.truncate(properties.firstName + ' ' + properties.lastName, {length: options.users.length}),
                        profile: properties.profile,
                        title: _.truncate(properties.title, {length: options.users.length}),
                        image: properties.image,
                        location: JSON.stringify(coordinates)
                    });
                });

                if (!results.length) {
                    searchResults.empty().append(templates.search({empty: 'No results to display.'}));
                } else {
                    searchResults.empty().append(templates.search({results: results}));

                    searchResults.find('.consultant-wrapper').on('click', function () {
                        var element = $(this);
                        var data = element.data();
                        
                        $.each(userMarkers.getLayers(), function (index, layer) {
                            if (layer.options.uid == data.uid) {
                                userMarkers.zoomToShowLayer(layer, function () {
                                    layer.openPopup();
                                });

                                return false;
                            }
                        });
                    });

                    userSearchLayer = L.geoJson(data);

                    userSearchLayer.eachLayer(function (layer) {
                        var properties = layer.feature.properties;

                        layer.bindPopup(templates.user({
                            name: _.truncate(properties.firstName + ' ' + properties.lastName, {length: options.users.length}),
                            profile: properties.profile,
                            title: _.truncate(properties.title, {length: options.users.length}),
                            image: properties.image
                        }));

                        layer.setIcon(L.icon(options.users.icon));
                        layer.options.uid = uid++;
                    });

                    userMarkers.removeLayer(userGeoJsonLayer);
                    userMarkers.addLayer(userSearchLayer);

                    console.log(userSearchLayer.getLayers());

                    if (southWest && northEast) {
                        map.panInsideBounds(L.latLngBounds(southWest, northEast));
                    }
                }

                $('.close-search-results').on('click', function (event) {
                    event.preventDefault();

                    userMarkers.removeLayer(userSearchLayer);
                    userMarkers.addLayer(userGeoJsonLayer);
                    searchResults.empty();
                    searchElement.removeClass('is-on');

                    details.search.val('');
                });
            });
        });

        // remove search filter
        details.search.on('keydown', function () {
            if (!mapOn) {
                landingElement.addClass('map-on');
                mapOn = true;
            }

            if (showingResults) {
                userMarkers.removeLayer(userSearchLayer);
                userMarkers.addLayer(userGeoJsonLayer);
                searchResults.empty();
                searchElement.removeClass('is-on');
            }
        });

        $(document).on('click', function (event) {
            var target = $(event.target);

            if (!mapOn && !target.is('a, a *') && !mapHold) {
                landingElement.addClass('map-on');
                mapOn = true;
            }
        });

        // turn map on when exploring and after timeout
        exploreMap.on('click', function (event) {
            event.preventDefault();

            if (!mapOn) {
                landingElement.addClass('map-on');
                mapOn = true;
                mapHold = false;
            }
        });

        mapTimer = setTimeout(function () {
            landingElement.addClass('map-on');
            mapOn = true;
        }, 10000);

        // toggle menu when clicked
        var menuToggle = $('.landing-menu-toggle');
        var header = $('.landing-header');

        menuToggle.on('click', function (event) {
            event.preventDefault();

            var element = $(this);

            if (element.hasClass('is-active')) {
                element.removeClass('is-active');
                header.removeClass('is-on');
            } else {
                element.addClass('is-active');
                header.addClass('is-on');
            }
        });

        displayOverlay.on('click', function (event) {
            event.preventDefault();

            if (mapOn) {
                clearTimeout(mapTimer);
                landingElement.removeClass('map-on');
                mapOn = false;
                mapHold = true;

                menuToggle.removeClass('is-active');
                header.removeClass('is-on');
            }
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
