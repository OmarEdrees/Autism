import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/widgets/doctors/sessions_data_screen/child_data_sessions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionsDataScreen extends StatefulWidget {
  final Map<String, dynamic> sessionData;
  const SessionsDataScreen({super.key, required this.sessionData});

  @override
  State<SessionsDataScreen> createState() => _SessionsDataScreenState();
}

class _SessionsDataScreenState extends State<SessionsDataScreen> {
  Map<String, dynamic>? childData;
  List<dynamic> sessions = [];

  @override
  void initState() {
    super.initState();
    fetchChildAndSessions();
  }

  Future<void> fetchChildAndSessions() async {
    final childId = widget.sessionData['child_id'];

    if (childId == null) return;

    final supabase = Supabase.instance.client;

    try {
      final childResponse = await supabase
          .from('children')
          .select()
          .eq('id', childId)
          .single();

      setState(() {
        childData = childResponse;
        sessions = [widget.sessionData]; // ✅ عرض نفس الجلسة فقط
      });
    } catch (e) {
      print('❌ Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: childData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  height: 330,
                  decoration: BoxDecoration(
                    color: ColorsApp().primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: childData!['image_url'] != null
                            ? NetworkImage(childData!['image_url'])
                            : AssetImage('assets/images/doctors4.jpg')
                                  as ImageProvider,
                      ),
                      SizedBox(height: 5),
                      Text(
                        childData!['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        childData!['gender'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.phone_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 2,
                            color: Colors.white70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.chat_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ChildDataSessions(
                          title: "Age",
                          subTitle: childData!['age'].toString(),
                        ),
                        ChildDataSessions(
                          title: "Birth Date",
                          subTitle: childData!['birthdate'],
                        ),
                        ChildDataSessions(
                          title: "Diagnosis",
                          subTitle: childData!['diagnosis'],
                        ),
                        ChildDataSessions(
                          title: "Hobbies",
                          subTitle: childData!['hobbies'],
                        ),

                        ////////////////////////////////////////////////////////////
                        ...sessions.map((s) {
                          return Column(
                            children: [
                              ChildDataSessions(
                                title: "Session Title",
                                subTitle: s['title'] ?? '',
                              ),
                              ChildDataSessions(
                                title: "Description",
                                subTitle: s['description'] ?? '',
                              ),
                              ChildDataSessions(
                                title: "Scheduled At",
                                subTitle: formatLocalDate(
                                  s['scheduled_at'] ?? '',
                                ),
                              ),
                              ChildDataSessions(
                                title: "Duration Minutes",
                                subTitle: (s['duration_minutes'] ?? 0)
                                    .toString(),
                              ),
                              ChildDataSessions(
                                title: "Status",
                                subTitle: s['status'] ?? '',
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
