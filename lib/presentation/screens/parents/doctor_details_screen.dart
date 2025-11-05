import 'dart:developer';

import 'package:autism/logic/cubit/add_child/cubit/children_cubit.dart';
import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/logic/services/di/dependancy_injection.dart';
import 'package:autism/logic/services/notifications/fcm_notification.dart';
import 'package:autism/logic/services/schedule_services/schedule_service.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/widgets/auth/sign_up_in_customTextFields.dart';
import 'package:autism/presentation/widgets/parent/doctor_details/doctor_title_card.dart';
import 'package:autism/presentation/widgets/parent/doctor_details/drop_down_view_children.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

DateTime? selectedDay = DateTime.now();

class DoctorDetailsScreen extends StatefulWidget {
  final dynamic doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  String? selectedChildId; // 🟢 لتخزين id الطفل
  final ScheduleService _scheduleService = ScheduleService();

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;
    final doctorId = doctor['id'];

    // 🟢 جلب البيانات مع قيم افتراضية لتجنب الأخطاء
    final doctorName = doctor['profiles']?['full_name'] ?? 'Unknown Doctor';
    final specialty = doctor['specialty'] ?? 'Not specified';
    final imageUrl = doctor['profiles']?['avatar_url'];
    final tokens = doctor['profiles']?['tokens'] ?? [];
    final biography =
        doctor['bio'] ?? 'No biography available for this doctor.';
    final qualification =
        doctor['qualification'] ?? 'No qualifications provided.';
    log(tokens.toString());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey[100],
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🟢 صورة واسم وتخصص
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageUrl != null && imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : const AssetImage('assets/images/doctors4.jpg')
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            doctorName,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.medical_services_outlined,
                                size: 22,
                                color: ColorsApp().primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  specialty,
                                  maxLines: 1,
                                  overflow: TextOverflow
                                      .ellipsis, // 👈 يحط ... بدل القص
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                // 🟢 تقييم ثابت مؤقت
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: index < 4
                          ? const Color(0xFFFF7F3E)
                          : Colors.grey[300],
                      size: 24,
                    );
                  }),
                ),

                const SizedBox(height: 25),
                // 🟢 السيرة الذاتية
                DoctorTitleCard(title: 'Biography', subTitle: biography),

                const SizedBox(height: 25),
                // 🟢 المؤهلات
                DoctorTitleCard(
                  title: 'Qualification',
                  subTitle: qualification,
                ),

                const SizedBox(height: 25),
                const Text(
                  'Scheduled',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),

                WeeklyDatePicker(
                  selectedDay: selectedDay!,
                  changeDay: (value) {
                    setState(() {
                      selectedDay = value;
                    });
                    print('✅ Selected Day: $selectedDay');
                  },
                  enableWeeknumberText: false,
                  backgroundColor: Colors.grey[100] ?? Colors.white,
                  selectedDigitBackgroundColor: ColorsApp().primaryColor,
                  weekdayTextColor: Colors.black87,
                  digitsColor: Colors.black54,
                  selectedDigitColor: Colors.white,
                  weekdays: const [
                    "Mon",
                    "Tue",
                    "Wed",
                    "Thu",
                    "Fri",
                    "Sat",
                    "Sun",
                  ],
                ),
                const SizedBox(height: 10),
                BlocProvider(
                  create: (context) =>
                      ChildrenCubit()..fetchChildrenForCurrentUser(),
                  child: const DropDownViewChildren(),
                ),

                const SizedBox(height: 20),
                CustomTextFormField(
                  focusNode: doctorsDetailsScreenTitleFocus,
                  validator: completeDoctor,
                  controller: doctorsDetailsScreenTitle,
                  hintText: 'title',
                  icon: Icons.text_fields,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  focusNode: doctorsDetailsScreenDescriptionFocus,
                  validator: completeDoctor,
                  controller: doctorsDetailsScreenDescription,
                  hintText: 'description',
                  icon: Icons.description,
                ),

                const SizedBox(height: 20),
                CustomTextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                    TimeTextInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  focusNode: doctorsDetailsScreenDurationMinutesFocus,
                  validator: completeDoctor,
                  controller: doctorsDetailsScreenDurationMinutes,
                  hintText: '00',
                  icon: Icons.timer,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final childId = prefs.getString(
                      'child_id',
                    );
                    if (childId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please add a child before booking.'),
                        ),
                      );
                      return;
                    }
                    if (doctorsDetailsScreenTitle.text.isEmpty ||
                        doctorsDetailsScreenDescription.text.isEmpty ||
                        doctorsDetailsScreenDurationMinutes.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please fill all required fields before booking.',
                          ),
                        ),
                      );
                      return;
                    }

                    try {
                      await _scheduleService.createSchedule(
                        title: doctorsDetailsScreenTitle.text,
                        description: doctorsDetailsScreenDescription.text,
                        scheduledAt: selectedDay!.toIso8601String(),
                        durationMinutes: totalMinutes,
                        childId: childId,
                        doctorId: doctorId.toString(),
                      );
                      for (final token in tokens) {
                        getIt<NotificationsHelper>().sendNotification(
                          title: "New Session",
                          body:
                              "New session has been scheduled at ${selectedDay!.toIso8601String()}",
                          type: "order",
                          token: token,
                        );
                      }

                      // ✅ إظهار رسالة نجاح
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✅ Schedule created successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // ✅ تنظيف الحقول
                      doctorsDetailsScreenTitle.clear();
                      doctorsDetailsScreenDescription.clear();
                      doctorsDetailsScreenScheduledAt.clear();
                      doctorsDetailsScreenDurationMinutes.clear();

                      Navigator.pop(context); // إغلاق الصفحة بعد النجاح
                    } catch (e) {
                      print(e);
                      // ✅ في حال وجود خطأ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('❌ Error creating schedule: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF7F3E),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Book',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
