import 'package:flutter/material.dart';

class Slotpage extends StatefulWidget {
  const Slotpage({super.key});

  @override
  State<Slotpage> createState() => _SlotpageState();
}

class _SlotpageState extends State<Slotpage> {
  // Slot states (true = available)
  Map<String, bool> slots = {
    "P1": true,
    "P2": true,
    "P3": false,
    "P4": true,
  };

  @override
  Widget build(BuildContext context) {
    int total = slots.length;
    int available = slots.values.where((v) => v == true).length;

    return Scaffold(
      backgroundColor: const Color(0xffF4F7FD),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        title: const Text(
          "Live Map",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff1A1A1A),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Slots Status Card ----------------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade50,
                    Colors.blue.shade100.withOpacity(0.4)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade100.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$available / $total Slots Available",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Live Status",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Car Icon
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.directions_car,
                        size: 28, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Live Map",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff1A1A1A),
              ),
            ),

            const SizedBox(height: 15),

            // ---------------- Parking Layout ----------------
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),

              child: Row(
                children: [
                  // LEFT SIDE — Trees & Building
                  Expanded(
                    child: Column(
                      children: [
                        _areaCard(
                          label: "Trees",
                          color: Colors.green.shade100,
                          icon: Icons.park,
                        ),
                        const SizedBox(height: 18),
                        _areaCard(
                          label: "Building",
                          color: Colors.orange.shade100,
                          icon: Icons.apartment,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 18),

                  // RIGHT SIDE — Slots
                  Expanded(
                    child: Column(
                      children: [
                        _slotCard("P1"),
                        const SizedBox(height: 14),
                        _slotCard("P2"),
                        const SizedBox(height: 14),
                        _slotCard("P3"),
                        const SizedBox(height: 14),
                        _slotCard("P4"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- LEGEND ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _legendDot(Colors.green, "Available"),
                _legendDot(Colors.red, "Occupied"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- AREA BOX UI ----------------
  Widget _areaCard({required String label, required Color color, required IconData icon}) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- SLOT CARD ----------------
  Widget _slotCard(String slot) {
    bool isAvailable = slots[slot]!;

    return GestureDetector(
      onTap: () {
        _showSlotDetails(slot, isAvailable);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 60,
        decoration: BoxDecoration(
          color: isAvailable ? Colors.green.shade50 : Colors.red.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isAvailable ? Colors.green : Colors.red,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isAvailable
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Center(
          child: Text(
            slot,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isAvailable ? Colors.green.shade800 : Colors.red.shade800,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- SLOT DETAILS POPUP ----------------
  void _showSlotDetails(String slot, bool available) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Slot $slot",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                  children: [
                    Icon(
                      available ? Icons.check_circle : Icons.cancel,
                      color: available ? Colors.green : Colors.red,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      available ? "Available" : "Occupied",
                      style: TextStyle(
                        fontSize: 20,
                        color: available ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ],
          ),
        );
      },
    );
  }

  // ---------------- LEGEND DOT ----------------
  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        CircleAvatar(radius: 8, backgroundColor: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
