import 'package:astronacci/feature/dashboard/data/model/user_resp_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailScreen extends StatelessWidget {
  final UserDetail userDetail;
  const UserDetailScreen({required this.userDetail, super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.35,
                width: width,
                color: Colors.indigo,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70.0,
                    ),
                    Text(
                      "KNOW YOUR CUSTOMER",
                      style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.12,
              ),
              Text(
                "${userDetail.firstName} ${userDetail.lastName}",
                style: GoogleFonts.poppins(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Text(
                userDetail.email,
                style: GoogleFonts.poppins(
                    fontSize: 16.0, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "In this future, we find a harmonious balance between progress and preservation, where every action is guided by a commitment to the greater good. Together, we build a world that reflects our highest aspirations, where hope, compassion, and innovation light the way forward.",
                  style: GoogleFonts.poppins(
                      fontSize: 12.0, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.25),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 10,
                        spreadRadius: 3,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black, width: 2),
                    image: DecorationImage(
                        image: NetworkImage(userDetail.imageUrl),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
