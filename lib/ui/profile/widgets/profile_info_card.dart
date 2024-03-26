import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/models/login/login_response.dart';
import '../../../domain/storage_utils.dart';

class ProfileInfoCard extends StatefulWidget {
  const ProfileInfoCard({Key? key}) : super(key: key);

  @override
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  late UserInfo userInfo;
  @override
  void initState() {
    final decodedData = jsonDecode(StorageUtils.getString("user_info"));
    userInfo = UserInfo.fromJson(decodedData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(
                top:
                    0.0), // Change this based on the spacing between the card container and the avatar
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  12,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 16, left: 16),
              child: Column(
                children: [
                  _textRow("Name", '${userInfo.name}'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  _textRow("Roll No", '${userInfo.rollNumber}'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  _textRow("NRC", userInfo.nrc ?? " - "),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  _textRow("Phone", userInfo.phone ?? "-"),
                ],
              ),
            ),
          ),
          /*      Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade900,
              radius: 50,
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child:
                    Image.asset("assets/images/student_3d_illustration.webp"),
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _textRow(String label, String name) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: .5),
          ),
        ),
        Text(
          ":",
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            "\t$name",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
