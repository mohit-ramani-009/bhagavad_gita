import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List decodedJson = [];
  bool isLoading = true;

  String selectedLanguage = 'english';

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      final jsonString = await rootBundle.loadString("assets/json/bhagavad_gita.json");
      await Future.delayed(const Duration(seconds: 2)); // Simulated loading delay
      decodedJson = jsonDecode(jsonString);
    } catch (e) {
      print("Error loading JSON: $e");
      decodedJson = [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.pinkAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Bhagavad Gita",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Background Image with Overlay
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ae1d2f8be341b77d0698c4b3130b25c8.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0), // Adjust sigmaX and sigmaY for more/less blur
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3), // Add a semi-transparent overlay
                ),
              ),
            ),
          ),
          // Content
          isLoading
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                Text(
                  "Loading Chapters...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
              : Column(
            children: [
              // Language Dropdown
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    dropdownColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'english',
                        child: Text("English"),
                      ),
                      DropdownMenuItem(
                        value: 'gujrati',
                        child: Text("Gujarati"),
                      ),
                      DropdownMenuItem(
                        value: 'hindi',
                        child: Text("Hindi"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                ),
              ),
              // CarouselSlider
              CarouselSlider(
                options: CarouselOptions(
                  height: 230.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  viewportFraction: 0.8,
                ),
                items: [
                  "assets/images/e1755f0a1e024828dd8f1027ebf2e041.jpg",
                  "assets/images/3e85ff0461cb00e96ff8d5b2dd044a4b.jpg",
                  "assets/images/84ad76b6068fe556150d277e08a9d26a.jpg",
                  "assets/images/97e186e9f91f3e1364b323b773b59d3f.jpg",
                  "assets/images/172aefe512a7da313275257694080f53.jpg",
                  "assets/images/194bc2f058d8951008b24133c2104548.jpg",
                  "assets/images/6510e8880402fb0c85e7c3cef3f11a15.jpg",
                  "assets/images/7250f953517f31cbaf88f6ba58add1d4.jpg",
                  "assets/images/d6c4e133e6caaf41e0e87fb364c59ecc.jpg",
                  "assets/images/e1d291bf579c16fbddfdbee03a72b95a.jpg",
                ].map((imagePath) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              // List of Chapters
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  itemCount: decodedJson.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = decodedJson[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          "DetailScreen",
                          arguments: {
                            "chapter": item,
                            "selectedLanguage": selectedLanguage,
                          },
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient:  LinearGradient(
                                  colors: [Colors.deepPurple.withOpacity(0.7), Colors.pinkAccent.withOpacity(0.7)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "${item['chapter_number'] ?? '?'}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              item['title']?[selectedLanguage] ?? 'No Chapter Name',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Colors.deepPurple, Colors.pinkAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
