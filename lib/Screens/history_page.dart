import 'package:flutter/material.dart';

class HistoryReportsPage extends StatelessWidget {
  const HistoryReportsPage({super.key});

  final Color primaryBlue = const Color(0xFF4A90E2);
  final Color softGray = const Color(0xFFF2F4F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "History & Reports",
          style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Today's Report",
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 18),

            // SUMMARY CARDS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _summaryCard(Icons.access_time, "Peak Usage Hour", "11 AM"),
                  const SizedBox(width: 12),
                  _summaryCard(Icons.place, "Most Occupied", "P2"),
                  const SizedBox(width: 12),
                  _summaryCard(Icons.calendar_today, "Events Today", "32"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // CHART CARDS
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 210, child: _occupancyCard()),
                  const SizedBox(width: 14),
                  SizedBox(width: 210, child: _usageCard()),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Slot Analytics",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _slotCard("P1", Colors.red, "Most Occupied"),
                  const SizedBox(width: 12),
                  _slotCard("P2", Colors.green, "Most Free"),
                  const SizedBox(width: 12),
                  _slotCard("P3", Colors.orange, "Balanced"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _recentEventsSection(),
          ],
        ),
      ),
    );
  }

  // 🔹 MODERN SUMMARY CARD
  Widget _summaryCard(IconData icon, String title, String value) {
    return Container(
      width: 135,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE9F1FF), Color(0xFFFFFFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),

      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.blueAccent),
          const SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 🔹 OCCUPANCY PIE CARD (With soft gradient)
  Widget _occupancyCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFF2F5FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),

      child: Column(
        children: [
          const Text(
            "Occupancy Overview",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),

          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade300,
                  ),
                ),
                CircularProgressIndicator(
                  value: 0.6,
                  strokeWidth: 18,
                  backgroundColor: Colors.green.shade300,
                  valueColor: AlwaysStoppedAnimation(Colors.red.shade400),
                ),
                const Text("60%",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.circle, size: 10, color: Colors.green),
              SizedBox(width: 5),
              Text("Free"),
              SizedBox(width: 15),
              Icon(Icons.circle, size: 10, color: Colors.red),
              SizedBox(width: 5),
              Text("Occupied"),
            ],
          )
        ],
      ),
    );
  }

  // 🔹 GRAPH CARD (Modern blue background)
  Widget _usageCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFE7F1FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Usage by Hour",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // GRAPH CONTAINER
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: CustomPaint(
              painter: _ImprovedGraphPainter(),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("6AM", style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text("9AM", style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text("11AM", style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text("12PM", style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text("6PM", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }


  // 🔹 SLOT CARD (Colored Backgrounds)
  Widget _slotCard(String slot, Color color, String status) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 13),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(slot,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 3),
                Text(status,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade700)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 🔹 RECENT EVENTS SECTION
  Widget _recentEventsSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Recent Events",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),

          Wrap(
            spacing: 10,
            children: [
              Chip(
                label: const Text("All"),
                backgroundColor: Colors.blue.shade50,
              ),
              Chip(
                label: const Text("Free → Occupied"),
                backgroundColor: Colors.green.shade50,
              ),
              Chip(
                label: const Text("Occupied → Free"),
                backgroundColor: Colors.red.shade50,
              ),
            ],
          ),

          const SizedBox(height: 20),
          _eventRow("10:45 AM", "A1 became Occupied"),
          _eventRow("10:47 AM", "A3 became Free"),
          _eventRow("11:12 AM", "A1 became Free"),
          _eventRow("12:04 PM", "P3 became Occupied"),
          _eventRow("1:27 PM", "P2 became Free"),
        ],
      ),
    );
  }

  Widget _eventRow(String time, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(time)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// FAKE GRAPH DESIGN
class _ImprovedGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 0.6;

    final graphPaint = Paint()
      ..color = const Color(0xFF4A90E2)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0x664A90E2),
          Color(0x114A90E2),
          Colors.transparent
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Grid Lines
    for (double i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Smooth graph curve path
    final path = Path();
    final fillPath = Path();

    final points = [
      Offset(size.width * 0.00, size.height * 0.75),
      Offset(size.width * 0.25, size.height * 0.50),
      Offset(size.width * 0.45, size.height * 0.80),
      Offset(size.width * 0.65, size.height * 0.30),
      Offset(size.width * 0.95, size.height * 0.55),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];

      final cp1 = Offset((prev.dx + curr.dx) / 2, prev.dy);
      final cp2 = Offset((prev.dx + curr.dx) / 2, curr.dy);

      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, curr.dx, curr.dy);
      fillPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, curr.dx, curr.dy);
    }

    // Close for fill
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    // Draw filled area
    canvas.drawPath(fillPath, fillPaint);

    // Draw bold curve line
    canvas.drawPath(path, graphPaint);

    // Highlight active point
    final highlight = points[2]; // 11AM peak
    final highlightPaint = Paint()..color = const Color(0xFF4A90E2);
    canvas.drawCircle(highlight, 5, highlightPaint);

    final glowPaint = Paint()
      ..color = const Color(0x554A90E2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawCircle(highlight, 10, glowPaint);
  }

  @override
  bool shouldRepaint(_) => true;
}

