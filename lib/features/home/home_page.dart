import 'package:auto_swift/core/components/custom_container.dart';
import 'package:auto_swift/core/components/custom_text.dart';
import 'package:auto_swift/core/routing/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedBrand = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(40.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: const NetworkImage(
                    "https://picsum.photos/200",
                  ),
                ),

                CustomText(
                  text: "Qena , Egypt",
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),

                const Icon(CupertinoIcons.circle_grid_3x3),
              ],
            ),

            const Gap(20),

            Row(
              children: [
                CustomText(
                  text: "Hello, ",
                  fontSize: 30.sp,
                  color: Colors.grey.shade400,
                ),

                CustomText(text: "Abdelrahman", fontSize: 30.sp),
              ],
            ),

            CustomText(
              text: "Choose your ideal Car",
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),

            const Gap(20),

            // Brands
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('cars').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                final cars = snapshot.data!.docs;

                // Get unique brands from Firestore
                final brands = <String>[
                  'All',
                  ...cars
                      .map((car) => car.data()['brand']?.toString() ?? '')
                      .where((brand) => brand.isNotEmpty)
                      .toSet(),
                ];

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: brands.map((brand) {
                      final bool isSelected = selectedBrand == brand;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBrand = brand;
                            });
                          },
                          child: CustomContainer(
                            radius: 20.w,
                            color: isSelected
                                ? Colors.blueAccent
                                : Colors.grey.shade200,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            child: CustomText(
                              text: brand,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

            const Gap(20),

            // Cars
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('cars')
                    .snapshots(),

                builder: (context, snapshot) {
                  // Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Text(
                          snapshot.error.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        ),
                      ),
                    );
                  }

                  // Empty
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: "No cars available",
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    );
                  }

                  final allCars = snapshot.data!.docs;

                  // Filter cars
                  final cars = selectedBrand == 'All'
                      ? allCars
                      : allCars.where((car) {
                          final brand = car.data()['brand']?.toString() ?? '';

                          return brand == selectedBrand;
                        }).toList();

                  // No cars for selected brand
                  if (cars.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: "No cars available",
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: cars.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.w,
                      crossAxisSpacing: 3.w,
                      childAspectRatio: 1 / 1.25,
                    ),

                    itemBuilder: (context, index) {
                      final car = cars[index].data();

                      final String name = car['name']?.toString() ?? '';

                      final String brand = car['brand']?.toString() ?? '';

                      final String image = car['image']?.toString() ?? '';

                      final dynamic price = car['price'] ?? 0;

                      return GestureDetector(
                        onTap: () {
                     
                          debugPrint(
                            'Car: $name | Brand: $brand | Price: $price',
                          );

                          
                        },
                        child: GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.carDetailsPage, extra: car);
                          },
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,

                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox(
                                      height: 120.h,
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: name,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),

                                      CustomText(
                                        text: brand,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: "\$$price",
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),

                                          const Icon(
                                            Icons.arrow_circle_right_rounded,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
