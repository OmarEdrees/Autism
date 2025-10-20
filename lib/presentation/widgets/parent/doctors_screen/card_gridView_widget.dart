import 'package:flutter/material.dart';

class CardGridViewWidget extends StatefulWidget {
  const CardGridViewWidget({super.key});

  @override
  State<CardGridViewWidget> createState() => _CardGridViewWidgetState();
}

class _CardGridViewWidgetState extends State<CardGridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 5),
          height: 180,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset.fromDirection(1.5, 1.5),
                color: Colors.grey,
                blurStyle: BlurStyle.normal,
                blurRadius: 0.5,
                spreadRadius: 0.2,
              ),
            ],

            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),

          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/doctors4.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(15),
                //     topRight: Radius.circular(15),
                //   ),
                //   child: Image.asset('assets/images/doctor.webp', fit: BoxFit.fill),
                // ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Dr. John Doe',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Pediatric Specialist',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
