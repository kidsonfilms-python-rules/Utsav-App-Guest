import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class MapPage extends StatefulWidget {
  final String? autoSelectMarkerId;
  const MapPage({Key? key, this.autoSelectMarkerId}) : super(key: key);

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
    _mapStyle = DesignConstants.MAP_STYLE;
  }

  void _setMarkers() {
    // Define a list of locations with full attributes.
    final List<Location> locations = [
      Location(
        name: "Cafeteria",
        buildingName: 'MAIN BUILDING',
        locationType: 'Food',
        description:
            'A delicious treat available on campus like the really great mutton.',
        position: const LatLng(38.69023475780903, -121.2241666435147),
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
        buildingName: 'MAIN BUILDING',
        locationType: 'Stage',
        description:
            'The main stage for events and natoks. Come watch the show of your life!',
        position: const LatLng(38.690483782353056, -121.2243186340391),
      ),
      Location(
        name: 'Classroom',
        buildingName: 'MAIN BUILDING',
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

  late var currentGreenMarker = null;
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
      _markers.add(currentGreenMarker);
      _selectedLocation = location;
    });
    _panelController.open();
  }

  void _onPanelClosed() {
    setState(() {
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
      color: DesignConstants.BACKGROUND_COLOR,
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          _mapController?.setMapStyle(_mapStyle);
          // Optionally, you can animate the camera to the selected location if autoSelect is enabled.
          if (widget.autoSelectMarkerId != null && _selectedLocation != null) {
            _mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: _selectedLocation!.position, zoom: 19.0),
              ),
            );
          }
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(38.690377656961, -121.22430823733487),
          zoom: 19.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        compassEnabled: false,
        markers: _markers,
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
                color: DesignConstants.TEXT_SECONDARY_COLOR,
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
                      Container(
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
                                  color: DesignConstants.TEXT_PRIMARY_COLOR,
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
                                  color: DesignConstants.TEXT_SECONDARY_COLOR,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // color: Colors.amber,
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "DISTANCE",
                                  style: GoogleFonts.getFont(
                                    "Roboto Condensed",
                                    textStyle: TextStyle(
                                      color:
                                          DesignConstants.TEXT_SECONDARY_COLOR,
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
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
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
                                      color:
                                          DesignConstants.TEXT_SECONDARY_COLOR,
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
                                      color: DesignConstants.TEXT_PRIMARY_COLOR,
                                      fontSize: 16,
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
                            color: DesignConstants.TEXT_SECONDARY_COLOR,
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
                            color: DesignConstants.TEXT_PRIMARY_COLOR,
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

  Location({
    required this.name,
    required this.buildingName,
    required this.locationType,
    required this.description,
    required this.position,
  });
}
