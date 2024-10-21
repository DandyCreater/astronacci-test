import 'package:astronacci/core/constanta/constanta_string.dart';
import 'package:astronacci/feature/auth/domain/entity/login_resp_entity.dart';
import 'package:astronacci/feature/profile/presentation/cubit/edit-profile-cubit/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/profile-bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileSuccess) {
                var data = state.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: Text(
                        "Profile Data",
                        style: GoogleFonts.poppins(
                            fontSize: 26.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            shape: BoxShape.circle,
                            image: data.imageUrl != null &&
                                    data.imageUrl!.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(data.imageUrl ?? ""),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: (data.imageUrl == "" || data.imageUrl!.isEmpty)
                              ? const Icon(
                                  Icons.person_2_outlined,
                                  size: 100,
                                  color: Colors.white,
                                )
                              : null),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<EditProfileCubit>()
                            .loadDataFirst(LoginRespEntity(
                              uid: data.uid,
                              firstName: data.firstName,
                              lastName: data.lastName,
                              address: data.address,
                              bornDate: data.bornDate,
                              bornPlace: data.bornPlace,
                              gender: data.gender,
                              email: data.email,
                              imageUrl: data.imageUrl,
                            ));
                        Navigator.pushNamed(
                            context, RouteConstanta.editProfileScreen);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Edit Profile",
                          style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomCard(
                      data: "${data.firstName} ${data.lastName}",
                      width: width,
                      title: "Nama :",
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomCard(
                      data: "${data.bornPlace}, ${data.bornDate}",
                      width: width,
                      title: "Tempat, Tanggal Lahir :",
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard(
                          data: data.gender,
                          width: width * 0.4,
                          title: "Gender",
                        ),
                        CustomCard(
                          data: data.email,
                          width: width * 0.4,
                          title: "Email :",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomCard(
                      data: data.address,
                      width: width,
                      title: "Alamat",
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteConstanta.changePasswordScreen);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Change Password",
                          style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Colors.red,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  double? width;
  String? title;
  String? data;
  CustomCard({this.width, this.title, this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "",
              style: GoogleFonts.poppins(
                  fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              data ?? "",
              style: GoogleFonts.poppins(
                  fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
