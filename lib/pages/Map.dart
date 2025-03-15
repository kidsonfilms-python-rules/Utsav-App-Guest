import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:utsav_app/util/DesignConstants.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Set<Marker> _markers = {};
  String _mapStyle = '';
  Location? _selectedLocation;
  late PanelController _panelController;
  GoogleMapController? _mapController;

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
    final List<Location> locations = [
      Location(
        name: 'Patel\'s Phuchka',
        buildingName: 'Cafeteria',
        locationType: 'Food',
        description: 'A beautiful city in California with iconic landmarks.',
        position: const LatLng(38.69023475780903, -121.2241666435147),
      ),
      Location(
        name: 'Stage #1',
        buildingName: 'MAIN BUILDING',
        locationType: 'Stage',
        description:
            'The entertainment capital of the world with famous attractions.',
        position: const LatLng(38.690483782353056, -121.2243186340391),
      ),
      Location(
        name: 'Chess',
        buildingName: 'CLASSROOM',
        locationType: 'Alternate',
        description:
            'The entertainment capital of the world with famous attractions.',
        position: const LatLng(38.69040063973745, -121.22447240884625),
      ),
    ];

    setState(() {
      for (var location in locations) {
        _markers.add(
          Marker(
            markerId: MarkerId(location.name),
            position: location.position,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: InfoWindow(title: '', snippet: ''),
            onTap: () {
              _onMarkerTapped(location);
            },
          ),
        );
      }
    });
  }

  void _onMarkerTapped(Location location) {
    setState(() {
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
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      onPanelClosed: _onPanelClosed,
      color: DesignConstants.BACKGROUND_COLOR,
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          _mapController?.setMapStyle(_mapStyle);
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
        // cloudMapId: '2f5fd67bccd50830',
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
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: DesignConstants.TEXT_SECONDARY_COLOR,
              ),
            ),
            SizedBox(height: 25),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.amber,
                        width: MediaQuery.sizeOf(context).width * 0.45,
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
                        width: MediaQuery.sizeOf(context).width * 0.45,
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
                                      color: DesignConstants.TEXT_SECONDARY_COLOR,
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
                                      color: DesignConstants.TEXT_SECONDARY_COLOR,
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