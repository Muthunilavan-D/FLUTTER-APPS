import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('c9bf77369e8e15abc2e0769502d47934');
  Weather? _weather;

  _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();

      if (cityName.isEmpty || cityName == "Unknown location") {
        throw Exception("Invalid city name");
      }

      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  String getWeatherAnimation(String? maincondition) {
    if (maincondition == null) return 'assets/sunny.json';

    switch (maincondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'haze':
      case 'fog':
      case 'dust':
      case 'smoke':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return "assets/thunder.json";
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 104, 104, 104),
        toolbarHeight: 30,
        title: Text(
          "Minimal Weather App!",
          style: GoogleFonts.slabo27px(color: const Color.fromARGB(255, 23, 30, 34),fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color.fromARGB(229, 27, 27, 27),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25,),
            const Icon(Icons.location_on,color: Color.fromARGB(255, 217, 218, 218),),
            Text(
              _weather?.cityName ?? "loading",
              style: GoogleFonts.bebasNeue(
                  color: Colors.blueGrey,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            const Spacer(),
            CircleAvatar(radius: 45,backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: Text('${_weather?.temperature.round()}°C',
                  style: GoogleFonts.bebasNeue(
                      color: Colors.blueGrey,
                      fontSize: 36,
                      fontWeight: FontWeight.bold)),
            ),const SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
