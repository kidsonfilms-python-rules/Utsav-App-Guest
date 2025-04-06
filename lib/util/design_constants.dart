import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesignConstants {
  static var backgroundColor = Color.fromARGB(255, 22, 21, 56);
  static var primaryCardColor = Color.fromARGB(255, 9, 12, 41);
  static var primaryCardColorLight = Color.fromARGB(255, 58, 60, 82);
  static var primaryTextColor = Colors.white;
  static var secondaryTextColor = Color.fromARGB(255, 89, 89, 109);
  static var green = Color.fromARGB(255, 69, 186, 105);
  static var darkGreen = Color.fromARGB(255, 8, 134, 47);
  static var red = Color.fromARGB(255, 240, 85, 55);

  static var mapStyle = '''[
    {
        "featureType": "all",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#202c3e"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "gamma": 0.01
            },
            {
                "lightness": 20
            },
            {
                "weight": "1.39"
            },
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "weight": "0.96"
            },
            {
                "saturation": "9"
            },
            {
                "visibility": "on"
            },
            {
                "color": "#000000"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [
            {
                "lightness": 30
            },
            {
                "saturation": "9"
            },
            {
                "color": "#29446b"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
            {
                "saturation": 20
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
            {
                "lightness": 20
            },
            {
                "saturation": -20
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
            {
                "lightness": 10
            },
            {
                "saturation": -30
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#193a55"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "saturation": 25
            },
            {
                "lightness": 25
            },
            {
                "weight": "0.01"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "lightness": -20
            }
        ]
    }
]''';
  static MapType mapType = MapType.normal;

  static List<Theme> themeOptions = [
    const Theme(
      "Dark",
      true,
      Color.fromARGB(255, 9, 12, 41),
      Color.fromARGB(255, 22, 21, 56),
      Color.fromARGB(255, 9, 12, 41),
      Color.fromARGB(255, 58, 60, 82),
      Colors.white,
      Color.fromARGB(255, 89, 89, 109),
      Color.fromARGB(255, 69, 186, 105),
      Color.fromARGB(255, 8, 134, 47),
    ),
    const Theme(
      "Light",
      false,
      Colors.white,
      Colors.white,
      Color.fromARGB(255, 228, 228, 228),
      Color.fromARGB(255, 228, 228, 228),
      Colors.black,
      Color.fromARGB(255, 89, 89, 109),
      Color.fromARGB(255, 69, 186, 105),
      Color.fromARGB(255, 8, 134, 47),
    ),
    const Theme(
      "Midnight",
      true,
      Colors.black,
      Colors.black,
      Color.fromARGB(255, 31, 31, 31),
      Color.fromARGB(255, 62, 62, 62),
      Colors.white,
      Color.fromARGB(255, 98, 98, 98),
      Color.fromARGB(255, 69, 186, 105),
      Color.fromARGB(255, 8, 134, 47),
    ),
  ];

  static int chosenTheme = 0;

  static void updateTheme() async {
    backgroundColor = themeOptions[chosenTheme].backgroundColor;
    primaryCardColor = themeOptions[chosenTheme].primaryCardColor;
    primaryCardColorLight = themeOptions[chosenTheme].primaryCardColorLight;
    primaryTextColor = themeOptions[chosenTheme].primaryTextColor;
    secondaryTextColor = themeOptions[chosenTheme].secondaryTextColor;
    green = themeOptions[chosenTheme].green;
    darkGreen = themeOptions[chosenTheme].darkGreen;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("THEME", chosenTheme);
  }
}

class Theme {
  final String name;
  final bool isDark;
  final Color previewColor;
  final Color backgroundColor;
  final Color primaryCardColor;
  final Color primaryCardColorLight;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color green;
  final Color darkGreen;
  const Theme(
    this.name,
    this.isDark,
    this.previewColor,
    this.backgroundColor,
    this.primaryCardColor,
    this.primaryCardColorLight,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.green,
    this.darkGreen,
  );
}
