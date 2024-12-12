import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PremiumSubscriptionScreen extends StatefulWidget {
  const PremiumSubscriptionScreen({super.key});

  @override
  State<PremiumSubscriptionScreen> createState() =>
      _PremiumSubscriptionScreenState();
}

class _PremiumSubscriptionScreenState extends State<PremiumSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 7,
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/subscription_icon.svg',
                  height: 231.83,
                  width: 211.67,
                ),
                SvgPicture.asset(
                  'assets/images/subscription_crown.svg',
                  height: 90.22,
                  width: 80.87,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 27.17,
          ),
          const Text(
            'Upgrade to PRO',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Access To Every Country \nCancel Anytime ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF8A8A8A),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const SizedBox(
                width: 160,
              ),
              SvgPicture.asset(
                'assets/images/done_icon.svg',
                height: 18,
                width: 18,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'No Adds',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const SizedBox(
                width: 160,
              ),
              SvgPicture.asset(
                'assets/images/done_icon.svg',
                height: 18,
                width: 18,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Faster Connection',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const SizedBox(
                width: 160,
              ),
              SvgPicture.asset(
                'assets/images/done_icon.svg',
                height: 18,
                width: 18,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Worldwide Location',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4A00E0), // Purple shade
                          Color(0xFF9396BA), // Light purple transitioning
                        ],
                        stops: [0.0, 0.7], // Starting and ending points
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text(
                            '1 Month',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            'BDT 1000/month',
                            style: TextStyle(
                                color: Color(0xFFFEFEFE), fontSize: 12),
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4A00E0), // Purple shade
                          Color(0xFF9396BA), // Light purple transitioning
                        ],
                        stops: [0.0, 0.7], // Starting and ending points
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text(
                            '1 Year',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'BDT 4000/month',
                                style: TextStyle(
                                    color: Color(0xFFFEFEFE), fontSize: 12),
                              ),
                              Text(
                                'BDT 490/month',
                                style: TextStyle(
                                    color: Color(0xFFFEFEFE), fontSize: 10),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        backgroundColor: const Color(0xFFF2F2F2)),
                    onPressed: () {},
                    child: const Text(
                      'Try Premium Free',
                      style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  '7 days free Trail. Then BDT 1000/month',
                  style: TextStyle(fontSize: 10, color: Color(0xFF545454)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
