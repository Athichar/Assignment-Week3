import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AirQualityPage extends StatefulWidget {
  const AirQualityPage({super.key});

  @override
  State<AirQualityPage> createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  Map<String, dynamic>? airData;
  bool loading = true;
  DateTime? lastUpdated; // ★ เพิ่มเวลาอัปเดตล่าสุด

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() => loading = true);

    // ใช้ token ของปิ่นเองได้
    final url = Uri.parse(
      "https://api.waqi.info/feed/here/?token=088e0533ecc0d410c5720ae1a844cc6d21bcdb3e",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        airData = {
          "aqi": data["data"]?["aqi"] ?? 0,
          "temp": data["data"]?["iaqi"]?["t"]?["v"],
          "city": data["data"]?["city"]?["name"] ?? "",
        };
        loading = false;
        lastUpdated = DateTime.now(); // ★ บันทึกเวลาอัปเดต
      });
    } else {
      setState(() => loading = false);
      // ไม่โชว์ error เยอะ ให้คงเรียบ ๆ
    }
  }

  String getAirQualityLabel(int aqi) {
    if (aqi <= 50) return "Good 😊";
    if (aqi <= 100) return "Moderate 😐";
    if (aqi <= 150) return "Unhealthy (SG) 😷";
    if (aqi <= 200) return "Unhealthy 🤒";
    if (aqi <= 300) return "Very Unhealthy 😨";
    return "Hazardous ☠️";
  }

  Color getAirQualityColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow.shade700;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    if (aqi <= 300) return Colors.purple;
    return Colors.brown;
  }

  @override
  Widget build(BuildContext context) {
    final aqi = airData?["aqi"] ?? 0;
    final city = (airData?["city"] ?? "") as String? ?? "";
    final temp = airData?["temp"];

    final aqiColor = getAirQualityColor(aqi);

    return Scaffold(
      extendBodyBehindAppBar: true, // ★ ให้สีไล่เฉดชิดบน
      appBar: AppBar(
        title: const Text("Air Quality"),
        centerTitle: true,
        foregroundColor: Colors.white, // ★ ตัวอักษรขาว
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container( // ★ ไล่เฉดตามสี AQI
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [aqiColor.withOpacity(0.95), aqiColor.withOpacity(0.65)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration( // ★ พื้นหลังนุ่ม ๆ
          gradient: LinearGradient(
            colors: [Color(0xFFF6F8FF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: loading
              ? const Center(child: CircularProgressIndicator(color: Colors.black))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ★ Pill เมือง
                    if (city.isNotEmpty) Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on, size: 18, color: Colors.black54),
                            const SizedBox(width: 6),
                            Text(city,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ★ Card กลาง สะอาด คลีน
                    Card(
                      elevation: 10,
                      shadowColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 26, 20, 22),
                        child: Column(
                          children: [
                            // ตัวเลข AQI
                            Text(
                              "$aqi",
                              style: TextStyle(
                                fontSize: 88,
                                fontWeight: FontWeight.w900,
                                color: aqiColor,
                                height: 0.95,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // ★ chip สถานะ
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: aqiColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                getAirQualityLabel(aqi),
                                style: TextStyle(
                                  color: aqiColor.withOpacity(0.95),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),
                            const Divider(height: 1),

                            // แถวอุณหภูมิ
                            Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.thermostat_auto, color: Colors.black87),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Temperature : ${temp ?? "--"} °C",
                                    style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ปุ่ม Refresh
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: fetchData,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Refresh"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: aqiColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                            elevation: 1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ★ Last updated เล็ก ๆ
                    if (lastUpdated != null)
                      Text(
                        "Last updated: ${lastUpdated!.hour.toString().padLeft(2, '0')}:${lastUpdated!.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
