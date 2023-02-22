import 'package:flutter/material.dart';
import 'package:medication/components/customize_appBar.dart';
import 'package:medication/constant/TextStyles.dart';
import 'package:medication/constant/buttonStyles.dart';
import 'package:medication/constant/colors.dart';
import 'package:medication/screen/medicine_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final String addMedText = "Press + to add a mediminder";
    final String headerText = "Medication Reminder";
    final String version = "Version 1.0";

    return Scaffold(
      appBar: CustomAppBar(title: "My Medicine"),
      body: SafeArea(
        child: MedicineList(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: ColorItems.lacivert,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorItems.beyaz,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/icons/bottle.png",
                        width: 70,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          headerText,
                          style: Styles.headerText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              leading: Icon(
                Icons.home,
                color: ColorItems.mor,
              ),
              title: Text(
                "Home",
                style: Styles.info,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.chat,
                color: ColorItems.mor,
              ),
              title: Text(
                "Send Feedback",
                style: Styles.info,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.share,
                color: ColorItems.mor,
              ),
              title: Text(
                "Share",
                style: Styles.info,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.star,
                color: ColorItems.sari,
              ),
              title: Text(
                "Rate us",
                style: Styles.info,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.exit_to_app),
                  color: ColorItems.kirmizi,
                ),
                Text(
                  version,
                  style: Styles.TextWidgets,
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: ColorItems.beyaz,
    );
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to logout?'),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyles.redButton,
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              ElevatedButton(
                style: ButtonStyles.greenButton,
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
}
