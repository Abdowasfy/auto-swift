import 'package:auto_swift/core/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key, required this.carData});
  
 
  final Map<String, dynamic> carData;

  @override
  Widget build(BuildContext context) {
    
    final String name = carData['name']?.toString() ?? 'Car Model';
    final String brand = carData['brand']?.toString() ?? 'Brand';
    final String image = carData['image']?.toString() ?? '';
    final String price = carData['price']?.toString() ?? '0';
    final String engine = carData['engine']?.toString() ?? 'N/A';
    final String speed = carData['speed']?.toString() ?? 'N/A';
    final String seats = carData['seats']?.toString() ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Image.network(
            image,
            height: 300.h,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 300.h,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
          const Gap(20),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: brand,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
                const Gap(8),
                CustomText(
                  text: "\$$price",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Engine: $engine",
                      fontSize: 14.sp,
                    ),
                    CustomText(
                      text: "Speed: $speed",
                      fontSize: 14.sp,
                    ),
                    CustomText(
                      text: "Seats: $seats",
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}