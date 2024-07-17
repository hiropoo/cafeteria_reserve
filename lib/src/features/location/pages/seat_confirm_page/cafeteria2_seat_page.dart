import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';

class Cafeteria2SeatPage extends StatelessWidget {
  final int seatNumber;

  const Cafeteria2SeatPage({super.key, required this.seatNumber});

  @override
  Widget build(BuildContext context) {
    // 座席情報
    final List<Seat> cafeteria1Seats = List.generate(
      60,
      (index) {
        if (index == seatNumber - 1) {
          return Seat(seatNumber: index + 1, isSelected: true);
        }
        return Seat(seatNumber: index + 1);
      },
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 店舗名
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '第2食堂',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Text(
                  '座席を確認してください',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 左側のテーブル
                      // 1 ~ 12
                      _LeftSideTable(
                        seats: [
                          cafeteria1Seats[0],
                          cafeteria1Seats[1],
                          cafeteria1Seats[2],
                          cafeteria1Seats[3],
                          cafeteria1Seats[4],
                          cafeteria1Seats[5],
                          cafeteria1Seats[6],
                          cafeteria1Seats[7],
                          cafeteria1Seats[8],
                          cafeteria1Seats[9],
                          cafeteria1Seats[10],
                          cafeteria1Seats[11],
                        ],
                      ),

                      // 中央のテーブル  x6
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                // 13 ~ 18
                                _CenterTable(
                                  seats: [
                                    cafeteria1Seats[12],
                                    cafeteria1Seats[13],
                                    cafeteria1Seats[14],
                                    cafeteria1Seats[15],
                                    cafeteria1Seats[16],
                                    cafeteria1Seats[17],
                                  ],
                                ),

                                // 31 ~ 36
                                _CenterTable(
                                  seats: [
                                    cafeteria1Seats[30],
                                    cafeteria1Seats[31],
                                    cafeteria1Seats[32],
                                    cafeteria1Seats[33],
                                    cafeteria1Seats[34],
                                    cafeteria1Seats[35],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                // 19 ~ 24
                                _CenterTable(
                                  seats: [
                                    cafeteria1Seats[18],
                                    cafeteria1Seats[19],
                                    cafeteria1Seats[20],
                                    cafeteria1Seats[21],
                                    cafeteria1Seats[22],
                                    cafeteria1Seats[23],
                                  ],
                                ),

                                // 37 ~ 42
                                _CenterTable(seats: [
                                  cafeteria1Seats[36],
                                  cafeteria1Seats[37],
                                  cafeteria1Seats[38],
                                  cafeteria1Seats[39],
                                  cafeteria1Seats[40],
                                  cafeteria1Seats[41],
                                ]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                // 25 ~ 30
                                _CenterTable(
                                  seats: [
                                    cafeteria1Seats[24],
                                    cafeteria1Seats[25],
                                    cafeteria1Seats[26],
                                    cafeteria1Seats[27],
                                    cafeteria1Seats[28],
                                    cafeteria1Seats[29],
                                  ],
                                ),

                                // 43 ~ 48
                                _CenterTable(
                                  seats: [
                                    cafeteria1Seats[42],
                                    cafeteria1Seats[43],
                                    cafeteria1Seats[44],
                                    cafeteria1Seats[45],
                                    cafeteria1Seats[46],
                                    cafeteria1Seats[47],
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // 入り口
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Text(
                              '入り口',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      // 右側のテーブル
                      // 49 ~ 60
                      const _RightSideTable(
                        seats: [
                          Seat(seatNumber: 48),
                          Seat(seatNumber: 49),
                          Seat(seatNumber: 50),
                          Seat(seatNumber: 51),
                          Seat(seatNumber: 52),
                          Seat(seatNumber: 53),
                          Seat(seatNumber: 54),
                          Seat(seatNumber: 55),
                          Seat(seatNumber: 56),
                          Seat(seatNumber: 57),
                          Seat(seatNumber: 58),
                          Seat(seatNumber: 59),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: MyButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('戻る'),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftSideTable extends StatelessWidget {
  final List<Seat> seats;

  const _LeftSideTable({required this.seats});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double tableWidth = screenWidth * 0.08;
    double tableHeight = screenHeight * 0.6;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: tableWidth,
          height: tableHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            12,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                child: seats[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RightSideTable extends StatelessWidget {
  final List<Seat> seats;

  const _RightSideTable({required this.seats});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double tableWidth = screenWidth * 0.08;
    double tableHeight = screenHeight * 0.6;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            12,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                child: seats[index],
              );
            },
          ),
        ),
        Container(
          width: tableWidth,
          height: tableHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

class _CenterTable extends StatelessWidget {
  const _CenterTable({required this.seats});
  final List<Seat> seats;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double tableWidth = screenWidth * 0.23;
    double tableHeight = screenHeight * 0.05;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              seats[0],
              seats[1],
              seats[2],
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: tableWidth,
            height: tableHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              seats[3],
              seats[4],
              seats[5],
            ],
          ),
        ],
      ),
    );
  }
}

class Seat extends HookWidget {
  final int seatNumber; // 座席番号
  final bool isSelected; // 座席が選択されているか

  const Seat({super.key, required this.seatNumber, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double chairWidth = screenWidth * 0.25 * 0.2;

    return Container(
      width: chairWidth,
      height: chairWidth,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).colorScheme.tertiary : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
