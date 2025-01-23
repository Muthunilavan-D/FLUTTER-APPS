import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String condition = "";
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
        condition = getWeatherCondition(_weather?.mainCondition); // Update the condition
      });
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  String getWeatherCondition(String? mainCondition) {
    if (mainCondition == null) return "CONDITION: Sunny";

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return "CONDITION: Cloudy";
      case 'mist':
        return "CONDITION: Mist";
      case 'haze':
        return "CONDITION: Haze";
      case 'fog':
        return "CONDITION: Foggy";
      case 'dust':
        return "CONDITION: Dusty";
      case 'smoke':
        return "CONDITION: Smoky";
      case 'rain':
        return "CONDITION: Raining";
      case 'drizzle':
        return "CONDITION: Drizzling";
      case 'shower rain':
        return "CONDITION: Shower Rain";
      case 'thunderstorm':
        return "CONDITION: Thunderstorm";
      case 'clear':
        return "CONDITION: Clear";
      default:
        return "Sunny";
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/mist.json';
      case 'haze':
        return 'assets/haze.json';
      case 'fog':
        return 'assets/cloud.json';
      case 'dust':
        return 'assets/cloud.json';
      case 'smoke':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/rain.json';
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

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 206, 203, 203),
        toolbarHeight: 30,
        title: Text(
          "Minimal Weather App!",
          style: GoogleFonts.slabo27px(
              color: const Color.fromARGB(255, 23, 30, 34),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(229, 27, 27, 27),
          Color.fromARGB(228, 53, 48, 48)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 217, 218, 218),
              ),
              Text(
                _weather?.cityName ?? "Loading..",
                style: GoogleFonts.bebasNeue(
                    color: const Color.fromARGB(255, 13, 91, 134),
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                condition,
                style: GoogleFonts.belanosima(
                  fontSize: 36,
                  color: const Color.fromARGB(255, 189, 212, 224),
                ),
              ),
              const Spacer(),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 244, 125, 145),
                      Color.fromARGB(255, 249, 180, 140)
                    ])),
                child: Text('${_weather?.temperature.round()} °C',
                    style: GoogleFonts.macondo(
                        color: const Color.fromARGB(255, 7, 56, 82),
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

          condition = "CONDITION: Smoky";
          return 'assets/cloud.json';
        }

      case 'rain':
        {
          condition = "CONDITION: Raining";
          return 'assets/rain.json';
        }
      case 'drizzle':
        {
          condition = "CONDITION: Drizzling";
          return 'assets/rain.json';
        }
      case 'shower rain':
        {
          condition = "CONDITION:Shower Rain";
          return 'assets/rain.json';
        }
      case 'thunderstorm':
        {
          condition = "CONDITION: Thunderstorm";
          return "assets/thunder.json";
        }
      case 'clear':
        {
          condition = "CONDITION: Clear";
          return 'assets/sunny.json';
        }
      default:
        {
          condition = "CONDITION: Sunny";
          return 'assets/sunny.json';
        }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 206, 203, 203),
        toolbarHeight: 30,
        title: Text(
          "Minimal Weather App!",
          style: GoogleFonts.slabo27px(
              color: const Color.fromARGB(255, 23, 30, 34),
              fontWeight: FontWeight.bold),
        ),
      ),
      // backgroundColor: const Color.fromARGB(229, 27, 27, 27),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(229, 27, 27, 27),
          Color.fromARGB(228, 53, 48, 48)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 217, 218, 218),
              ),
              Text(
                _weather?.cityName ?? "Loading..",
                style: GoogleFonts.bebasNeue(
                    color: const Color.fromARGB(255, 13, 91, 134),
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                condition,
                style: GoogleFonts.belanosima(
                  fontSize: 36,
                  color: const Color.fromARGB(255, 189, 212, 224),
                ),
              ),
              const Spacer(),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 244, 125, 145),
                      Color.fromARGB(255, 249, 180, 140)
                    ])),
                child: Text('${_weather?.temperature.round()}°C',
                    style: GoogleFonts.macondo(
                        color: const Color.fromARGB(255, 7, 56, 82),
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
