import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:developer' as developer;

void main() {
  try {
    developer.log('Starting application', name: 'donor_grid');
    runApp(const MyApp());
    developer.log('Application started', name: 'donor_grid');
  } catch (e, stackTrace) {
    developer.log('Error starting application: $e\n$stackTrace', name: 'donor_grid', error: e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donor Grid',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE53935),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE53935),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFFE53935),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintStyle: const TextStyle(color: Colors.black54),
        ),
      ),
      home: const MyHomePage(title: 'Donor Registration'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();

  void _navigateToDateOfBirthScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DateOfBirthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Enter Name',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _navigateToDateOfBirthScreen,
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({super.key});

  @override
  State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE53935),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: const Text('Donor Registration'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Date of Birth',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: const TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today, color: Color(0xFFE53935)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BloodGroupScreen()),
                    );
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BloodGroupScreen extends StatefulWidget {
  const BloodGroupScreen({super.key});

  @override
  State<BloodGroupScreen> createState() => _BloodGroupScreenState();
}

class _BloodGroupScreenState extends State<BloodGroupScreen> {
  String selectedBloodGroup = 'A+';
  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: const Text('Donor Registration'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Blood Group',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedBloodGroup,
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFE53935)),
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                      onChanged: (String? value) {
                        setState(() {
                          selectedBloodGroup = value!;
                        });
                      },
                      items: bloodGroups.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LocationScreen()),
                    );
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  bool _isLoading = false;
  String? _selectedCity;

  // List of major cities
  final List<String> _cities = [
    'New York, USA',
    'London, UK',
    'Tokyo, Japan',
    'Paris, France',
    'Sydney, Australia',
    'Dubai, UAE',
    'Mumbai, India',
    'Toronto, Canada',
    'Madrid, Spain',
    'Berlin, Germany',
    'Beijing, China',
    'Singapore',
    'Rome, Italy',
    'Rio de Janeiro, Brazil',
    'Moscow, Russia',
    'Cape Town, South Africa',
    'Mexico City, Mexico',
    'Bangkok, Thailand',
    'Cairo, Egypt',
    'Seoul, South Korea',
  ];

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled. Please enable location services in your device settings.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions were denied. Please allow location access to use this feature.');
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
          'Location permissions are permanently denied. Please enable location permissions in your device settings.');
      } 

      // When we reach here, permissions are granted and we can get the location
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
    } catch (e) {
      return Future.error('Error accessing location services: $e');
    }
  }

  void _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get the actual device location instead of using fixed coordinates
      final position = await _determinePosition();
      try {
        // Try to get detailed placemark information
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        
        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          
          // Build location string with all available information
          String cityName = '';
          String adminArea = '';
          String country = '';
          
          // Get city/locality
          if (placemark.locality != null && placemark.locality!.isNotEmpty) {
            cityName = placemark.locality!;
          } else if (placemark.subAdministrativeArea != null && placemark.subAdministrativeArea!.isNotEmpty) {
            cityName = placemark.subAdministrativeArea!;
          } else if (placemark.name != null && placemark.name!.isNotEmpty && 
                    placemark.name != placemark.street) {
            cityName = placemark.name!;
          }
          
          // Get admin area (state/province)
          if (placemark.administrativeArea != null && placemark.administrativeArea!.isNotEmpty) {
            adminArea = placemark.administrativeArea!;
          }
          
          // Get country
          if (placemark.country != null && placemark.country!.isNotEmpty) {
            country = placemark.country!;
          }
          
          // Build the location string
          String locationString;
          
          if (cityName.isNotEmpty && adminArea.isNotEmpty && country.isNotEmpty) {
            // Full information
            locationString = "$cityName, $adminArea, $country";
          } else if (cityName.isNotEmpty && country.isNotEmpty) {
            // City and country
            locationString = "$cityName, $country";
          } else if (adminArea.isNotEmpty && country.isNotEmpty) {
            // Admin area and country
            locationString = "$adminArea, $country";
          } else if (cityName.isNotEmpty) {
            // Just city
            locationString = cityName;
          } else if (adminArea.isNotEmpty) {
            // Just admin area
            locationString = adminArea;
          } else if (country.isNotEmpty) {
            // Just country
            locationString = country;
          } else {
            // If we couldn't get any name information from the placemark,
            // try to match coordinates to known cities
            final knownCities = {
              'New York': {'lat': 40.71, 'lng': -74.01},
              'London': {'lat': 51.51, 'lng': -0.13},
              'Tokyo': {'lat': 35.68, 'lng': 139.77},
              'Mumbai': {'lat': 19.08, 'lng': 72.88},
              'Sydney': {'lat': -33.87, 'lng': 151.21},
              'Paris': {'lat': 48.85, 'lng': 2.35},
              'Dubai': {'lat': 25.20, 'lng': 55.27},
              'Singapore': {'lat': 1.35, 'lng': 103.82},
              'Hong Kong': {'lat': 22.28, 'lng': 114.16},
              'Berlin': {'lat': 52.52, 'lng': 13.41},
              'Rome': {'lat': 41.89, 'lng': 12.48},
              'Cairo': {'lat': 30.06, 'lng': 31.24},
              'Moscow': {'lat': 55.75, 'lng': 37.62},
              'Toronto': {'lat': 43.65, 'lng': -79.38},
            };
            
            String nearestCity = '';
            double shortestDistance = double.infinity;
            
            knownCities.forEach((city, coords) {
              final lat = coords['lat']!;
              final lng = coords['lng']!;
              
              final distance = ((position.latitude - lat) * (position.latitude - lat)) + 
                             ((position.longitude - lng) * (position.longitude - lng));
              
              if (distance < shortestDistance) {
                shortestDistance = distance;
                nearestCity = city;
              }
            });
            
            if (nearestCity.isNotEmpty) {
              locationString = nearestCity;
            } else {
              // As a last resort, show the coordinates in a readable format
              locationString = "${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}";
            }
          }
          
          setState(() {
            _locationController.text = locationString;
            _isLoading = false;
          });
        } else {
          // If no placemarks were found, display coordinates
          setState(() {
            _locationController.text = "${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}";
            _isLoading = false;
          });
        }
      } catch (e) {
        // If geocoding fails, show the raw coordinates
        setState(() {
          _locationController.text = "${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        // Leave the text field as is - don't add any default value
      });
      
      // Show an error message with guidance
      final errorMessage = e.toString().contains('permission')
          ? 'Location permission denied. Please enable in settings and try again.'
          : e.toString().contains('disabled')
              ? 'Location services are disabled. Please enable in settings and try again.'
              : 'Error getting location: ${e.toString().split('\n')[0]}';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: const Text('Donor Registration'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Location',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your location',
                      prefixIcon: Icon(Icons.location_on, color: Color(0xFFE53935)),
                    ),
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Or select from common cities:',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCity,
                      hint: const Text("Select a city"),
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFE53935)),
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCity = value;
                          if (value != null) {
                            _locationController.text = value;
                          }
                        });
                      },
                      items: _cities.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Or use your current location:',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _isLoading ? null : _getCurrentLocation,
                  icon: _isLoading 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.my_location, color: Colors.white),
                  label: Text(
                    _isLoading ? 'Getting location...' : 'Use my current location',
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DonationHistoryScreen()),
                    );
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// New screen for asking about donation history
class DonationHistoryScreen extends StatelessWidget {
  const DonationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: const Text('Donor Registration'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Have you donated blood before?',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LastDonationDateScreen()),
                        );
                      },
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegistrationCompleteScreen()),
                        );
                      },
                      child: const Text('No'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// New screen for last donation date
class LastDonationDateScreen extends StatefulWidget {
  const LastDonationDateScreen({super.key});

  @override
  State<LastDonationDateScreen> createState() => _LastDonationDateScreenState();
}

class _LastDonationDateScreenState extends State<LastDonationDateScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE53935),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: const Text('Donor Registration'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'When did you last donate blood?',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: const TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today, color: Color(0xFFE53935)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistrationCompleteScreen()),
                    );
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Registration complete screen
class RegistrationCompleteScreen extends StatelessWidget {
  const RegistrationCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: const Text('Registration Complete'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  'Registration Complete!',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Thank you for registering as a donor. Your information has been saved.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Go back to the beginning
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
