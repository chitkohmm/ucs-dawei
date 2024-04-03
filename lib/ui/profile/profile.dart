import 'package:flutter/material.dart';
import 'package:libms_flutter/data/network/sqlite_client.dart';
import 'package:libms_flutter/domain/constants.dart';
import 'package:libms_flutter/domain/storage_utils.dart';
import 'package:libms_flutter/ui/borrow_books/borrow_books.dart';
import 'package:libms_flutter/ui/expired_books/expired_books.dart';
import 'package:libms_flutter/ui/order_list/order_list.dart';
import 'package:libms_flutter/ui/profile/widgets/profile_info_card.dart';
import 'package:libms_flutter/ui/profile/widgets/users_downloaded_book_list.dart';
import 'package:libms_flutter/ui/splash/splash.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                String url = StorageUtils.getString("url");
                StorageUtils.clear();
                StorageUtils.setString("url", url);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Splash()),
                    (route) => false);
                await SqliteClient.removeAllBooks();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        elevation: .8,
        shadowColor: Colors.black12,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ProfileInfoCard(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Your books",
                                style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: .3,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          _buttonCard(
                            "Expired Books",
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ExpiredBooks()));
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.018,
                          ),
                          _buttonCard("Borrowing Books", () {
                            kGoToNext(context, const BorrowBooks());
                          }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.018,
                          ),
                          _buttonCard("Download Books", () {
                            kGoToNext(context, const UserDownloadedBooksList());
                          }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.018,
                          ),
                          _buttonCard("Order Books", () {
                            kGoToNext(context, const OrderList());
                          }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.018,
                          ),
                          // _buttonCard("Pending Books", () {
                          //   /// download page
                          //   kGoToNext(context, const PendingList());
                          // }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonCard(String label, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: .2)
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: ListTile(
            dense: true,
            leading: Image.asset(
              "assets/images/book.png",
              height: 22,
            ),
            title: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF5AE4A8),
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
