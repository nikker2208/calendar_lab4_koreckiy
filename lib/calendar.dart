import 'package:flutter/material.dart';
class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late TextEditingController yearContrl = TextEditingController();
  late TextEditingController monthContrl = TextEditingController();
  late TextEditingController nowYear = TextEditingController();
  late TextEditingController nowMonth = TextEditingController();
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    yearContrl = TextEditingController(text: now.year.toString());
    monthContrl = TextEditingController(text: now.month.toString());
    nowYear = TextEditingController(text: now.year.toString());
    nowMonth = TextEditingController(text: now.month.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Календарь",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 100),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        yearContrl.text = (int.parse(nowYear.text)).toString();
                        monthContrl.text = (int.parse(nowMonth.text)).toString();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      "Сегодня",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                buildRow('Year', yearContrl),
                buildRow('Month', monthContrl),
                month(),
              ],
            ),
          ),
      ),
    );
  }
  Widget buildRow(String text, TextEditingController control) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildButtonLeft(text),
          textOut(control),
          buildButtonRight(text),
        ],
      ),
    );
  }
  Widget textOut(TextEditingController control){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      width: 100.0,
      child: TextField(

        controller: control,
        enabled: false,
        readOnly: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
  Widget buildButtonLeft(String numrow) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (numrow == 'Year') {
              if (int.parse(yearContrl.text) <= 200) {
              } else {
                yearContrl.text =
                    (int.parse(yearContrl.text) - 1).toString();
              }
          } else {
              if (int.parse(monthContrl.text) <= 1) {
                yearContrl.text = (int.parse(yearContrl.text) - 1).toString();
                monthContrl.text = '12';
              } else {
                monthContrl.text = (int.parse(monthContrl.text) - 1).toString();
              }
            }
        });
      },
      child: Icon(
        Icons.arrow_left,
        color: Colors.black,
        size: 25,
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
      ),
    );
  }
  Widget buildButtonRight(String numrow) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (numrow == 'Year') {
              yearContrl.text = (int.parse(yearContrl.text) + 1).toString();
          } else {
            if (int.parse(monthContrl.text) >= 12) {
              yearContrl.text = (int.parse(yearContrl.text) + 1).toString();
              monthContrl.text = '1';
            } else {
              monthContrl.text =
                  (int.parse(monthContrl.text) + 1).toString();
            }
          };
        });
      },
      child: Icon(
        Icons.arrow_right,
        color: Colors.black,
        size: 25,
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
      ),
    );
  }
  Widget month(){
    DateTime now = DateTime(
      int.parse(yearContrl.text),
      int.parse(monthContrl.text),
      1,
    );

    int currentDay = 0;
    int currentWeekday = now.weekday;

    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    int daysInPrevMonth = DateTime(now.year, now.month, 0).day;
    int daysInNextMonth = 1;
    List<Widget> weeks = [];

    while (currentDay <= daysInMonth) {
      List<Widget> buttonsInRow = [];
      bool isCurrentMonth = false;

      for (int i = 1; i < 8; i++) {
        int dayOfMonth = currentDay + i - currentWeekday + 1;

        if (dayOfMonth <= daysInMonth && dayOfMonth > 0) {
          isCurrentMonth = true;
          buttonsInRow.add(
            Expanded(
              child: SizedBox(
                child: Container(
                  color: dayOfMonth == DateTime.now().day && monthContrl.text == DateTime.now().month.toString() && yearContrl.text == DateTime.now().year.toString()
                      ? Colors.red
                      : Colors.white,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      bottom: 5,
                      right: 5,
                      left: 5),
                    child: Text(
                      dayOfMonth.toString(),
                      style: TextStyle(
                          fontSize: 20,
                        color: dayOfMonth == DateTime.now().day && monthContrl.text == DateTime.now().month.toString() && yearContrl.text == DateTime.now().year.toString()
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                ),
              ),
            ),
          );
        } else if (dayOfMonth <= 0) {
          buttonsInRow.insert(0,
            Expanded(
              child: SizedBox(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      bottom: 5,
                      right: 5,
                      left: 5),
                  color: Colors.white24,
                  child: Text(
                    daysInPrevMonth.toString(),
                    style: TextStyle(
                        fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
          daysInPrevMonth--;
        } else {
          buttonsInRow.add(
            Expanded(
              child: SizedBox(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      bottom: 5,
                      right: 5,
                      left: 5),
                  color: Colors.white24,
                  child: Text(
                    daysInNextMonth.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
          daysInNextMonth++;
        }
      }

      if (isCurrentMonth) {
        weeks.add(
          Row(
            children: buttonsInRow,
          ),
        );
      }

      currentDay = currentDay + 7 - currentWeekday + 1;
      currentWeekday = 1;
    }

    return Expanded(
      child: ListView(
        children: weeks,
      ),
    );
  }
}
