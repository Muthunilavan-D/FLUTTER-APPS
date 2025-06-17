import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:f_fit/gemini_service.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const QuoteApp());
  });
}

class QuoteApp extends StatefulWidget {
  const QuoteApp({Key? key}) : super(key: key);

  @override
  _QuoteAppState createState() => _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  TextEditingController queryController = TextEditingController();
  String quote = "Enter a topic and get an inspiring quote!";
  bool isLoading = false;

  void getQuote(BuildContext context) async {
    if (queryController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter a topic!", style: TextStyle(color: Colors.white)),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.blue.shade900,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    String result = await GeminiService.fetchQuote(queryController.text);

    setState(() {
      quote = result;
      isLoading = false;
    });
  }

  void copyQuote(BuildContext context) {
    Clipboard.setData(ClipboardData(text: quote));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Quote copied to clipboard!")),
    );
  }

  void shareQuote() {
    Share.share(quote);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: size.width * 0.08,
      vertical: size.height * 0.015,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true, // Ensure content resizes with keyboard
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          toolbarHeight: size.height * 0.06,
          title: Text(
            "Random Quote Generator",
            style: GoogleFonts.lora(
              fontSize: size.width * 0.055,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue.shade900,
          elevation: 4,
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext scaffoldContext) {
            return ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: padding,
                    right: padding,
                    top: padding,
                    bottom: MediaQuery.of(context).viewInsets.bottom + padding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.1), // Space to push content toward center
                      TextField(
                        maxLength: 60,
                        controller: queryController,
                        style: GoogleFonts.poppins(color: Colors.blue.shade900),
                        decoration: InputDecoration(
                          labelText: "Enter topic",
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue.shade900, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: size.height * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      ElevatedButton(
                        onPressed: () => getQuote(scaffoldContext),
                        style: ElevatedButton.styleFrom(
                          padding: buttonPadding,
                          elevation: 3,
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: size.width * 0.05,
                                height: size.width * 0.05,
                                child: const CircularProgressIndicator(color: Colors.white),
                              )
                            : Text(
                                "Get Quote",
                                style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Container(
                        padding: EdgeInsets.all(size.width * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade200,
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          quote,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lora(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => copyQuote(scaffoldContext),
                            icon: Icon(Icons.copy, color: Colors.blue.shade900),
                            tooltip: "Copy Quote",
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(size.width * 0.025),
                              elevation: 2,
                            ),
                          ),
                          SizedBox(width: size.width * 0.05),
                          IconButton(
                            onPressed: shareQuote,
                            icon: Icon(Icons.share, color: Colors.blue.shade900),
                            tooltip: "Share Quote",
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(size.width * 0.025),
                              elevation: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.1),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}