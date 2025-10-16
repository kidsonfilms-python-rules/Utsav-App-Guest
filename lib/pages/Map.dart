import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final String? autoSelectMarkerId;
  const MapPage({super.key, this.autoSelectMarkerId});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late PanelController _panelController;
  Location? _selectedLocation;
  MapboxMap? mapboxMap;
  // Class-level variables to store the overlay IDs
  String? _floorplanLayerId;

  final LightState _lightTimeState = LightState.dusk;
  LightState _lightState = LightState.dusk;

  CameraOptions initCamera = CameraOptions(
    center: Point(coordinates: Position(-121.22430823733487, 38.690377656961)),
    zoom: 19,
    bearing: 0,
    pitch: 0,
  );

  PointAnnotation? pointAnnotation;
  PointAnnotationManager? pointAnnotationManager;

  // We'll store the list of locations so we can reference them.
  final List<Location> _locations = [];

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  void _onMarkerTapped(Location location) {
    setState(() {
      _selectedLocation = location;
    });
    _panelController.open();
  }

  void _onPanelClosed() {
    setState(() {});
  }

  void _defaultMapStyleChanges() async {
    mapboxMap?.style.setStyleImportConfigProperty(
      "basemap",
      "lightPreset",
      "night",
    );

    await mapboxMap?.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    await mapboxMap?.compass.updateSettings(CompassSettings(enabled: false));
  }

  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    _defaultMapStyleChanges();

    final List<Location> locations = [
      Location(
        name: "Cafeteria",
        buildingName: 'BUILDING A',
        locationType: 'Food',
        description:
            'A delicious treat available on campus like the really great mutton.',
        position: const LatLng(38.69023475780903, -121.2241666435147),
        currentEvent: "Dinner",
      ),
      Location(
        name: "Patel's Phuchka",
        buildingName: 'LOBBY',
        locationType: 'Food',
        description:
            'A delicious treat available on campus and also get the delicious samosas.',
        position: const LatLng(38.69040278065333, -121.22425229254445),
      ),
      Location(
        name: 'Stage #1',
        buildingName: 'BUILDING A',
        locationType: 'Stage',
        description:
            'The main stage for events and natoks. Come watch the show of your life!',
        position: const LatLng(38.690483782353056, -121.2243186340391),
        currentEvent: "Natok #1",
      ),
      Location(
        name: 'Classroom',
        buildingName: 'BUILDING A',
        locationType: 'Alternate',
        description:
            'A quiet place to relax and play chess or hangout when you need a break from the festivities.',
        position: const LatLng(38.69040063973745, -121.22447240884625),
      ),
    ];

    // Store the locations in our state variable.
    _locations.clear();
    _locations.addAll(locations);

    mapboxMap.annotations.createPointAnnotationManager().then((value) {
      pointAnnotationManager = value;

      rootBundle.load('assets/icons/Map Pin.png').then((bytes) {
        final Uint8List imageData = bytes.buffer.asUint8List();

        for (var i = 0; i < locations.length; i++) {
          pointAnnotationManager
              ?.create(
                PointAnnotationOptions(
                  geometry: Point(
                    coordinates: Position(
                      locations[i].position.longitude,
                      locations[i].position.latitude,
                      100,
                    ),
                  ),
                  image: imageData,
                  iconSize: 1.5,
                ),
              )
              .then((a) {
                locations[i].id = a.id;
              });
        }

        // rootBundle.load('assets/icons/Map Pin Selected.png').then((bytes2) {
        //   final Uint8List imageData2 = bytes2.buffer.asUint8List();
        pointAnnotationManager?.tapEvents(
          onTap: (annotation) {
            // ignore: avoid_print
            print("onAnnotationClick, id: ${annotation.id}");
            _onMarkerTapped(
              locations.firstWhere(
                (loc) => loc.id == annotation.id,
                orElse:
                    () => Location(
                      buildingName: "NF",
                      name: "NF",
                      locationType: "NF",
                      description: "NF",
                      position: LatLng(0, 0),
                    ),
              ),
            );
          },
        );
        // });
        // circleAnnotationManager?.longPressEvents(
        //   onLongPress: (annotation) {
        //     // ignore: avoid_print
        //     print("onAnnotationLongPress, id: ${annotation.id}");
        //   },
        // );
      });
    });

    // Add your overlay source and layer here
    await _addFloorplanOverlay();

    // Now that layer exists, set up the zoom listener
    mapboxMap.onMapZoomListener = (x) {
      _onMapZoom(x);
    };
  }

  // --------------------------
  // Listen to camera changes to update opacity
  // --------------------------
  void _onMapZoom(MapContentGestureContext mcgc) async {
    if (mapboxMap == null || _floorplanLayerId == null) return;

    final CameraState cameraState = await mapboxMap!.getCameraState();
    final double zoom = cameraState.zoom;

    double opacity;
    if (zoom < 19) {
      opacity = 0.0;
    } else if (zoom >= 19 && zoom <= 20) {
      opacity = 0.8 * ((zoom - 19) / 2.0);
    } else {
      opacity = 0.8;
    }

    print("ZOOOOOM $opacity $zoom");

    // ✅ Check that layer exists before applying property
    final bool layerExists = await mapboxMap!.style.styleLayerExists(
      _floorplanLayerId!,
    );
    if (layerExists) {
      try {
        await mapboxMap!.style.setStyleLayerProperty(
          _floorplanLayerId!,
          "raster-opacity",
          opacity,
        );
      } catch (e) {
        print("⚠️ Failed to set layer opacity: $e");
      }
    } else {
      print(
        "⚠️ Layer ${_floorplanLayerId!} not yet ready, skipping opacity update.",
      );
    }

    // optional lighting adjustments
    if (opacity >= 0.45 && _lightState != LightState.night) {
      mapboxMap!.style.setStyleImportConfigProperty(
        "basemap",
        "lightPreset",
        "night",
      );
      _lightState = LightState.night;
    } else if (opacity < 0.45 && _lightState == LightState.night) {
      mapboxMap!.style.setStyleImportConfigProperty(
        "basemap",
        "lightPreset",
        _lightTimeState.name,
      );
      _lightState = _lightTimeState;
    }
  }

  String? _floorplanSourceId;

  Future<void> _addFloorplanOverlay() async {
    if (mapboxMap == null) return;

    _floorplanSourceId = "floorplan-raster-source";
    _floorplanLayerId = "floorplan-raster-layer";

    final corners = [
      [-121.22441280930384, 38.69064536788592], // top-left 38.69064536788592, -121.22441280930384
      [-121.22396736256658, 38.69035874824386], // top-right 38.69035874824386, -121.22396736256658
      [-121.22421847843263, 38.69012039014122], // bottom-right 38.69012039014122, -121.22421847843263
      [-121.2246639251699, 38.690406025789684], // bottom-left 38.690406025789684, -121.2246639251699
    ];

    // Add image source
    await mapboxMap!.style.addSource(
      ImageSource(
        id: _floorplanSourceId!,
        url: "https://siddharthray.com/cdn/Internal Map OCC.png", // TODO: replace later
        coordinates: corners,
      ),
    );

    // Add raster layer using that source
    await mapboxMap!.style.addLayer(
      RasterLayer(
        id: _floorplanLayerId!,
        sourceId: _floorplanSourceId!,
        rasterOpacity: 0.0,
      ),
    );

    print("✅ Floorplan overlay added to style");
  }

  @override
  Widget build(BuildContext context) {
    final double logoWidth = 90.0;
    final double logoLeft = 16.0;
    final double logoClosedBottom = 90.0; // bottom offset when closed

    return SlidingUpPanel(
      controller: _panelController,
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height * 0.4,
      snapPoint: 0.4,
      panelSnapping: true,
      panelBuilder: () => _buildPanel(),
      onPanelSlide: (pos) {},
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      onPanelClosed: _onPanelClosed,
      color: DesignConstants.backgroundColor,
      body: Stack(
        children: [
          MapWidget(
            cameraOptions: initCamera,
            textureView: true,
            styleUri:
                "mapbox://styles/thesiddharthray/cmgrk2b03005g01sq2qgjhq42",
            onMapCreated: _onMapCreated,
            onZoomListener: (x) => _onMapZoom(x),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 45, 16, 0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: SearchBar(
                    constraints: BoxConstraints(maxWidth: 200, minHeight: 44),
                    hintText: "Search",
                    leading: Padding(
                      padding: EdgeInsets.fromLTRB(4, 0, 8, 0),
                      child: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: DesignConstants.primaryTextColor,
                        size: 20,
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      DesignConstants.backgroundColor,
                    ),
                    hintStyle: WidgetStateProperty.all(
                      GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.secondaryTextColor,
                        ),
                      ),
                    ),
                    textStyle: WidgetStateProperty.all(
                      GoogleFonts.getFont(
                        "Roboto Condensed",
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                        ),
                      ),
                    ),
                    autoFocus: false,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      if (value != "") {
                        Location? searchLocation = _locations.firstWhere(
                          (loc) => loc.name.toLowerCase().contains(
                            value.toLowerCase(),
                          ),
                          orElse:
                              () => Location(
                                buildingName: "NF",
                                name: "NF",
                                locationType: "NF",
                                description: "NF",
                                position: LatLng(0, 0),
                              ),
                        );
                        if (searchLocation.name == "NF") {
                          searchLocation = _locations.firstWhere(
                            (loc) => loc.buildingName.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                            orElse:
                                () => Location(
                                  buildingName: "NF",
                                  name: "NF",
                                  locationType: "NF",
                                  description: "NF",
                                  position: LatLng(0, 0),
                                ),
                          );
                        }
                        if (searchLocation.name == "NF") {
                          searchLocation = _locations.firstWhere(
                            (loc) => loc.locationType.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                            orElse:
                                () => Location(
                                  buildingName: "NF",
                                  name: "NF",
                                  locationType: "NF",
                                  description: "NF",
                                  position: LatLng(0, 0),
                                ),
                          );
                        }
                        if (searchLocation.name == "NF") {
                          searchLocation = _locations.firstWhere(
                            (loc) => loc.currentEvent.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                            orElse:
                                () => Location(
                                  buildingName: "NF",
                                  name: "NF",
                                  locationType: "NF",
                                  description: "NF",
                                  position: LatLng(0, 0),
                                ),
                          );
                        }
                        if (searchLocation.name == "NF") {
                          searchLocation = _locations.firstWhere(
                            (loc) => loc.description.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                            orElse:
                                () => Location(
                                  buildingName: "NF",
                                  name: "NF",
                                  locationType: "NF",
                                  description: "NF",
                                  position: LatLng(0, 0),
                                ),
                          );
                        }

                        if (searchLocation.name != "NF") {
                          _onMarkerTapped(searchLocation);
                        }
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: IconButton(
                    onPressed: () async {
                      setState(() {
                        if (DesignConstants.mapType != MapType.hybrid) {
                          DesignConstants.mapType = MapType.hybrid;
                        } else {
                          DesignConstants.mapType = MapType.normal;
                        }
                      });
                      await mapboxMap!.loadStyleURI(
                        DesignConstants.mapType == MapType.normal
                            ? "mapbox://styles/thesiddharthray/cmgrk2b03005g01sq2qgjhq42"
                            : MapboxStyles.STANDARD_SATELLITE,
                      );
                      _defaultMapStyleChanges();
                    },
                    icon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(FontAwesomeIcons.satellite, size: 20),
                    ),
                    padding: EdgeInsets.all(16),
                    color:
                        DesignConstants.mapType == MapType.hybrid
                            ? DesignConstants.backgroundColor
                            : DesignConstants.primaryTextColor,
                    style: IconButton.styleFrom(
                      backgroundColor:
                          DesignConstants.mapType != MapType.hybrid
                              ? DesignConstants.backgroundColor
                              : DesignConstants.primaryTextColor,
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        FontAwesomeIcons.locationCrosshairs,
                        size: 20,
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    color: DesignConstants.primaryTextColor,
                    style: IconButton.styleFrom(
                      backgroundColor: DesignConstants.backgroundColor,
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 120),
            // curve: Curves.easeOut,
            curve: Curves.linear,
            left: logoLeft,
            bottom: logoClosedBottom,
            // (_panelPosition * (panelMaxHeight + logoAbovePanelOffset)),
            child: IgnorePointer(
              ignoring: true,
              child: SafeArea(
                child: Opacity(
                  opacity: 0.4,
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Mapbox_logo_2019.svg/640px-Mapbox_logo_2019.svg.png',
                    width: logoWidth,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    if (_selectedLocation == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: DesignConstants.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 25),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // color: Colors.amber,
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedLocation!.name,
                              style: GoogleFonts.getFont(
                                'Roboto Condensed',
                                textStyle: TextStyle(
                                  color: DesignConstants.primaryTextColor,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              _selectedLocation!.buildingName,
                              style: GoogleFonts.getFont(
                                "Roboto Condensed",
                                textStyle: TextStyle(
                                  color: DesignConstants.secondaryTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // color: Colors.amber,
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "DISTANCE",
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "200 ft",
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TYPE",
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  _selectedLocation!.locationType,
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color: DesignConstants.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_selectedLocation!.currentEvent != "None")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 6),
                                  Text(
                                    "CURRENT EVENT",
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      textStyle: TextStyle(
                                        color:
                                            DesignConstants.secondaryTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _selectedLocation!.currentEvent,
                                    style: GoogleFonts.getFont(
                                      "Roboto Condensed",
                                      textStyle: TextStyle(
                                        color: DesignConstants.primaryTextColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DESCRIPTION",
                        style: GoogleFonts.getFont(
                          "Roboto Condensed",
                          textStyle: TextStyle(
                            color: DesignConstants.secondaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _selectedLocation!.description,
                        style: GoogleFonts.getFont(
                          'Roboto Condensed',
                          textStyle: TextStyle(
                            color: DesignConstants.primaryTextColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Location {
  final String name;
  final String buildingName;
  final String locationType;
  final String description;
  final LatLng position;
  final String currentEvent;
  String? id;

  Location({
    required this.name,
    required this.buildingName,
    required this.locationType,
    required this.description,
    required this.position,
    this.currentEvent = "None",
    this.id = "NONE",
  });
}

enum LightState { day, night, dusk, dawn }
