import 'package:flutter/material.dart';
import 'package:medication/constant/TextStyles.dart';
import 'package:medication/constant/colors.dart';
import '../constant/height.dart';
import '../data/dbHelper.dart';
import '../models/medicine.dart';
import 'medicine_add.dart';
import 'medicine_detail.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({super.key, this.picture});

  @override
  State<MedicineList> createState() => _MedicineListState();
  final String? picture;
}

class _MedicineListState extends State<MedicineList> {
  List<Medicine> medicines = [];
  var dbHelper = DbHelper();
  int medicineCount = 0;
  String title = "My Medicines";
  String txt1 = "Welcome the Pill Reminder";
  String txt2 = "Tap + button to add new Medicine.";
  @override
  void initState() {
    getMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildMedicineList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: ColorItems.lacivert,
        onPressed: () {
          goToMedicineAdd();
        },
      ),
    );
  }

  ListView? buildMedicineList() {
    return ListView.builder(
        itemCount: medicineCount == 0 ? 1 : medicineCount,
        itemBuilder: (BuildContext context, int position) {
          if (medicineCount == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Height.elli,
                Container(
                  child: Image.asset(
                    'assets/images/homePage.png',
                  ),
                ),
                Height.otuz,
                Text(
                  txt1,
                  style: Styles.TextWidgets,
                ),
                Height.bes,
                Text(
                  txt2,
                  style: Styles.TextWidgets,
                ),
              ],
            );
          }
          return Column(
            children: [
              Card(
                color: ColorItems.lacivert,
                elevation: 2.0,
                child: ListTile(
                  leading: Image.asset(
                  
                    this.medicines[position].image.toString(),
                  ),
                  title: Text(
                  
                    this.medicines[position].name.toString(),
                    style: Styles.dailyReviewStyle,
                  ),
                  subtitle: Text(
                      style: Styles.dailyReviewStyleSubtitle,
                     
                      "${this.medicines[position].dosage} ${this.medicines[position].dosageType}"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        
                        this.medicines[position].date.toString(),
                        style: Styles.trailing,
                      ),
                      Text(
                        // ignore: unnecessary_this
                        this.medicines[position].hour.toString(),
                        style: Styles.trailing,
                      )
                    ],
                  ),
                  onTap: () {
                    // ignore: unnecessary_this
                    goToDetail(this.medicines[position]);
                  },
                ),
              ),
            ],
          );
        });
  }

  void goToMedicineAdd() async {
    bool? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MedicineAdd()));
    if (result != null) {
      if (result) {
        getMedicines();
      }
    }
  }

  void getMedicines() async {
    var medicinesFuture = dbHelper.getMedicines();
    medicinesFuture.then((data) {
      setState(() {
        // ignore: unnecessary_this
        this.medicines = data;
        medicineCount = data.length;
      });
    });
  }

  void goToDetail(Medicine medicine) async {
    bool? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MedicineDetail(medicine)));
    if (result != null) {
      if (result) {
        getMedicines();
      }
    }
  }
}
