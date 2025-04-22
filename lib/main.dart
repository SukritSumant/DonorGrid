import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const MyApp());
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
      final position = await _determinePosition();
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        
        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          final String address = '${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.country ?? ''}';
          
          setState(() {
            _locationController.text = address.trim().isEmpty 
                ? '${position.latitude}, ${position.longitude}'
                : address;
            _isLoading = false;
          });
        } else {
          setState(() {
            _locationController.text = '${position.latitude}, ${position.longitude}';
            _isLoading = false;
          });
        }
      } catch (e) {
        // If geocoding fails, just use the coordinates
        setState(() {
          _locationController.text = '${position.latitude}, ${position.longitude}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      // Show a more user-friendly error message
      final errorMessage = e.toString().contains('permission')
          ? 'Location permission denied. Please enable in settings.'
          : e.toString().contains('disabled')
              ? 'Location services are disabled. Please enable in settings.'
              : 'Error getting location: ${e.toString()}';
      
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
                    // Save all information and complete registration
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registration Complete!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('Complete'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
