import 'package:auto_swift/core/components/custom_botton.dart';
import 'package:auto_swift/core/components/custom_container.dart';
import 'package:auto_swift/core/components/custom_text_field.dart';
import 'package:auto_swift/features/admin/widgets/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _model = TextEditingController();

  final TextEditingController _price = TextEditingController();

  final TextEditingController _engine = TextEditingController();

  final TextEditingController _speed = TextEditingController();

  final TextEditingController _seats = TextEditingController();
  List<String> avaliableColors = ["Red", "Blue", "Black"];
  List<String> brands = ["Bmw", "Lamborghini", "Audi"];
  String? selectedBrand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Admin Page'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  width: 40.w,
                  height: 40.h,
                  radius: 60.sp,
                  color: Colors.pink,
                ),
                const Icon(CupertinoIcons.share_up),
              ],
            ),

            Gap(20.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _engine,
                    hint: "Car Engine",
                    type: TextInputType.number,
                  ),
                ),
                Gap(10.w),

                Expanded(
                  child: CustomTextField(
                    controller: _speed,
                    hint: "Car Speed",
                    type: TextInputType.number,
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: CustomTextField(
                    controller: _seats,
                    hint: "Seats Number",
                    type: TextInputType.number,
                  ),
                ),
              ],
            ),
            Gap(20.h),
            CustomTextField(
              controller: _model,
              hint: "Car Model",
              type: TextInputType.text,
            ),
            Gap(20.h),
            CustomTextField(
              controller: _price,
              hint: "Car Price",
              type: TextInputType.number,
            ),
            Gap(20.h),
            CustomDropDown(
              value: selectedBrand,
              valid: "please select at least one item",
              hint: "Car Brand",
              items: brands
                  .map(
                    (brand) =>
                        DropdownMenuItem(child: Text(brand), value: brand),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedBrand = value as String;
                });
              },
            ),
            Gap(20.h),
            CustomButton(
              color: Colors.blueAccent,
              onTap: () {},
              width: double.infinity,
              height: 35.h,
              radius: 8.w,
              child: Center(child: Text("Add Car")),
            ),
          ],
        ),
      ),
    );
  }
}
