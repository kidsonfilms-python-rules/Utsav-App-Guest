import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:utsav_app/util/design_constants.dart';

class MapPage extends StatefulWidget {
  final String? autoSelectMarkerId;
  const MapPage({super.key, this.autoSelectMarkerId});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Set<Marker> _markers = {};
  String _mapStyle = '';
  Location? _selectedLocation;
  late PanelController _panelController;
  GoogleMapController? _mapController;
  // We'll store the list of locations so we can reference them.
  final List<Location> _locations = [];

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
    _loadMapStyle();
    _setMarkers();
  }

  void _loadMapStyle() {
    _mapStyle = DesignConstants.mapStyle;
  }

  void _setMarkers() {
    // Define a list of locations with full attributes.
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

    // Create markers from the locations.
    for (var location in locations) {
      final Marker marker = Marker(
        markerId: MarkerId(location.name),
        position: location.position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        // Disable default info window
        infoWindow: const InfoWindow(title: '', snippet: ''),
        onTap: () {
          _onMarkerTapped(location);
        },
      );
      _markers.add(marker);
    }

    setState(() {});

    // If an auto-select marker id is provided, try to auto-select it.
    if (widget.autoSelectMarkerId != null) {
      // ignore: unnecessary_nullable_for_final_variable_declarations
      final Location? autoLocation = _locations.firstWhere(
        (loc) =>
            loc.name.toLowerCase() == widget.autoSelectMarkerId!.toLowerCase(),
        // orElse: () => null,
      );
      if (autoLocation != null) {
        // Delay a little to ensure the map is rendered
        Future.delayed(const Duration(milliseconds: 300), () {
          _onMarkerTapped(autoLocation);
        });
      }
    }
  }

  Marker? currentGreenMarker;
  void _onMarkerTapped(Location location) {
    setState(() {
      // Reset all markers to blue
      if (currentGreenMarker != null) {
        _markers.add(
          Marker(
            markerId: currentGreenMarker!.markerId,
            position: currentGreenMarker!.position,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: currentGreenMarker!.infoWindow,
            onTap: currentGreenMarker!.onTap,
          ),
        );
        _markers.remove(currentGreenMarker);
      }
      // Set the tapped marker to green
      currentGreenMarker = Marker(
        markerId: MarkerId(location.name),
        position: location.position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        // infoWindow: InfoWindow(
        //   title: location.name,
        //   snippet: location.description,
        // ),
        onTap: () {
          _onMarkerTapped(location);
        },
      );
      _markers.add(currentGreenMarker!);
      _selectedLocation = location;
    });
    _panelController.open();
  }

  void _onPanelClosed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: currentGreenMarker!.markerId,
          position: currentGreenMarker!.position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: currentGreenMarker!.infoWindow,
          onTap: currentGreenMarker!.onTap,
        ),
      );
      _markers.remove(currentGreenMarker);
      currentGreenMarker = null;
      _selectedLocation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _panelController,
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height * 0.4,
      snapPoint: 0.4,
      panelSnapping: true,
      panelBuilder: () => _buildPanel(),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      onPanelClosed: _onPanelClosed,
      color: DesignConstants.backgroundColor,
      body: Stack(
        children: [
          GoogleMap(
            style: _mapStyle,
            onMapCreated: (controller) {
              _mapController = controller;
              // Optionally, you can animate the camera to the selected location if autoSelect is enabled.
              if (widget.autoSelectMarkerId != null &&
                  _selectedLocation != null) {
                _mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _selectedLocation!.position,
                      zoom: 19.0,
                      tilt: 45,
                    ),
                  ),
                );
              }
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(38.690377656961, -121.22430823733487),
              tilt: 45,
              zoom: 19.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: DesignConstants.mapType,
            zoomControlsEnabled: false,
            compassEnabled: false,
            markers: _markers,
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
                    onPressed: () {
                      setState(() {
                        if (DesignConstants.mapType != MapType.hybrid) {
                          DesignConstants.mapType = MapType.hybrid;
                        } else {
                          DesignConstants.mapType = MapType.normal;
                        }
                      });
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

  Location({
    required this.name,
    required this.buildingName,
    required this.locationType,
    required this.description,
    required this.position,
    this.currentEvent = "None",
  });
}
