import 'dart:async';
import 'dart:ui'; // <-- needed for blur

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Auto slide every 5 seconds
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Smart Parking")),

      body: Column(
        children: [

          // ---------------------- YELLOW CURVED TOP ----------------------
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),

              child: Column(
                children: [

                  const SizedBox(height: 20),

                  // ---------------- CAROUSEL ----------------
                  SizedBox(
                    height: 200,
                    child: PageView(
                      controller: _pageController,
                      children: const [

                        SlideBox(
                          text: "Convenient Parking made simple and stress-free",
                          color: Colors.black,
                          image: "assets/car1.jpeg",
                        ),

                        SlideBox(
                          text: "Smart Parking Solutions for a smoother Journey ",
                          color: Colors.deepOrange,
                          image: "assets/car2.jpg",
                        ),

                        SlideBox(
                          text: "Drive In, Park Smart, and Save Time",
                          color: Colors.blue,
                          image: "assets/car3.jpg",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}




// ------------------------ SLIDE BOX WITH 2 COLUMNS ------------------------
class SlideBox extends StatelessWidget {
  final String text;
  final Color color;
  final String image;

  const SlideBox({
    super.key,
    required this.text,
    required this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 330,
        height: 175,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [

            // ---------- LEFT SIDE TEXT (50%) ----------
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // // ---------- REAL BLUR DIVIDER ----------
            // SizedBox(
            //   width: 18,
            //   height: double.infinity,
            //   child: ClipRect(
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            //       child: Container(
            //         color: Colors.white.withOpacity(0.25),
            //       ),
            //     ),
            //   ),
            // ),

            // ---------- RIGHT SIDE IMAGE (50%) ----------
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,   // 👈 Fills container fully
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// ---------------------- CUSTOM CURVE CLIPPER ----------------------
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 80,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
