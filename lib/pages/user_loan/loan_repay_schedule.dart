import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';

class LoanRepaySchedule extends StatefulWidget {
  const LoanRepaySchedule({super.key});

  @override
  _LoanRepayScheduleState createState() => _LoanRepayScheduleState();
}

class _LoanRepayScheduleState extends State<LoanRepaySchedule> {
  final List<Map<String, String>> events = [
    {
      "period": "1期",
      "date": "2022-08-13",
      "amount": "500000",
      "capital": "13241",
      "interest": "27384"
    },
    {
      "period": "2期",
      "date": "2022-07-13",
      "amount": "500000",
      "capital": "13241",
      "interest": "27384"
    },
    {
      "period": "3期",
      "date": "2022-03-13",
      "amount": "500000",
      "capital": "13241",
      "interest": "27384"
    },
    {
      "period": "4期",
      "date": "2022-02-13",
      "amount": "500000",
      "capital": "13241",
      "interest": "27384"
    },
    {
      "period": "5期",
      "date": "2022-03-13",
      "amount": "500000",
      "capital": "13241",
      "interest": "27384"
    },
    {
      "period": "6期",
      "date": "2022-01-13",
      "amount": "500000",
      "capital": "13241",
      "interest": "27384"
    },
  ];
  Color bgColor = const Color.fromRGBO(245, 245, 245, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor, // 设置背景颜色
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text('还款计划'),
      ),
      body: mainContent(),
    );
  }

  Widget _timePointTag() {
    return Center(
      child: CircleAvatar(
        radius: 10.0, // 外圆半径
        backgroundColor: Colors.red, // 外圆颜色
        child: Container(
          width: 10.0, // 内圆宽度
          height: 10.0, // 内圆高度
          decoration: const BoxDecoration(
            color: Colors.white, // 内圆颜色
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget mainContent() {
    Color lineColor = const Color.fromRGBO(227, 227, 227, 1);
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final isFirst = index == 0;
        final isLast = index == events.length - 1;
        final event = events[index];

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: isFirst,
          isLast: isLast,
          indicatorStyle: IndicatorStyle(
            width: 20,
            padding: const EdgeInsets.all(0),
            indicator: _timePointTag(),
          ),
          beforeLineStyle: LineStyle(
            color: lineColor,
            thickness: 2,
          ),
          afterLineStyle: LineStyle(
            color: lineColor,
            thickness: 2,
          ),
          endChild: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event['period']!,
                                  style: const TextStyle(color: Colors.black),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  event["date"] ?? "",
                                ),
                              ],
                            ),
                            Text(
                              event["amount"] ?? "",
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(253, 251, 238, 1),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("本金"),
                                  Text(event["capital"] ?? "")
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("利息"),
                                  Text(event["interest"] ?? "")
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
        );
      },
    );
  }
}
