// import 'package:autism/logic/services/colors_app.dart';
// import 'package:flutter/material.dart';

// class SessionsDataScreen extends StatefulWidget {
//   const SessionsDataScreen({super.key});

//   @override
//   State<SessionsDataScreen> createState() => _SessionsDataScreenState();
// }

// class _SessionsDataScreenState extends State<SessionsDataScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,

//         title: Text(
//           'Details',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.only(bottom: 20),
//             width: double.infinity,
//             height: 330,
//             decoration: BoxDecoration(
//               color: ColorsApp().primaryColor,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 CircleAvatar(
//                   radius: 45,
//                   backgroundColor: Colors.grey[300],
//                   backgroundImage: AssetImage('assets/images/doctors4.jpg'),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Omar',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 Text(
//                   'Edrees',
//                   style: TextStyle(fontSize: 14, color: Colors.white),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 20),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white, width: 1.5),
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(
//                             Icons.phone_outlined,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(height: 35, width: 2, color: Colors.white70),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white, width: 1.5),
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(Icons.chat_outlined, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           ChildDataSessions(title: 'Name', subTitle: 'Omar'),
//         ],
//       ),
//     );
//   }
// }

// class ChildDataSessions extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   const ChildDataSessions({
//     super.key,
//     required this.title,
//     required this.subTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),

//           Text(
//             'Omar',
//             style: TextStyle(
//               fontSize: 17,
//               color: Colors.grey,
//               //  fontWeight: FontWeight.bold,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//             child: Divider(color: Colors.grey[300], thickness: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:autism/logic/services/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionsDataScreen extends StatefulWidget {
  const SessionsDataScreen({super.key});

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
    final prefs = await SharedPreferences.getInstance();
    final childId = prefs.getString('child_id');

    if (childId == null) return;

    final supabase = Supabase.instance.client;

    try {
      final childResponse = await supabase
          .from('children')
          .select()
          .eq('id', childId)
          .single();

      final sessionResponse = await supabase
          .from('sessions')
          .select()
          .eq('child_id', childId);

      setState(() {
        childData = childResponse;
        sessions = sessionResponse as List<dynamic>;
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
                // ✅ نفس الـ Header تبعك تماماً
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
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        childData!['gender'],
                        style: TextStyle(fontSize: 14, color: Colors.white),
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

                // ✅ نفس تنسيق ChildDataSessions ولكن ديناميكي
                ChildDataSessions(
                  title: "Age",
                  subTitle: childData!['age'].toString(),
                ),
                ChildDataSessions(
                  title: "Diagnosis",
                  subTitle: childData!['diagnosis'],
                ),
                ChildDataSessions(
                  title: "Hobbies",
                  subTitle: childData!['hobbies'],
                ),

                SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: sessions.length,
                    itemBuilder: (context, i) {
                      final s = sessions[i];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: ListTile(
                          title: Text(s['title']),
                          subtitle: Text("Date: ${s['scheduled_at']}"),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class ChildDataSessions extends StatelessWidget {
  final String title;
  final String subTitle;

  const ChildDataSessions({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(subTitle, style: TextStyle(fontSize: 17, color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Divider(color: Colors.grey[300], thickness: 1.5),
          ),
        ],
      ),
    );
  }
}
