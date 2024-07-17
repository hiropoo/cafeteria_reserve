import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';

class Cafeteria1SeatPage extends StatelessWidget {
  final int seatNumber;
  static const int maxSeatNumber = 54;

  const Cafeteria1SeatPage({super.key, required this.seatNumber});

  @override
  Widget build(BuildContext context) {
    // 座席情報
    final List<Cafeteria1Seat> cafeteria2Seats = List.generate(
      maxSeatNumber,
      (index) {
        if (index == seatNumber - 1) {
          return Cafeteria1Seat(seatNumber: index + 1, isSelected: true);
        }
        return Cafeteria1Seat(seatNumber: index + 1);
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
                    '第1食堂',
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),

                        // 1 ~ 18
                        child: _Table(
                          seats: [
                            cafeteria2Seats[0],
                            cafeteria2Seats[1],
                            cafeteria2Seats[2],
                            cafeteria2Seats[3],
                            cafeteria2Seats[4],
                            cafeteria2Seats[5],
                            cafeteria2Seats[6],
                            cafeteria2Seats[7],
                            cafeteria2Seats[8],
                            cafeteria2Seats[9],
                            cafeteria2Seats[10],
                            cafeteria2Seats[11],
                            cafeteria2Seats[12],
                            cafeteria2Seats[13],
                            cafeteria2Seats[14],
                            cafeteria2Seats[15],
                            cafeteria2Seats[16],
                            cafeteria2Seats[17],
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),

                        // 19 ~ 36
                        child: _Table(
                          seats: [
                            cafeteria2Seats[18],
                            cafeteria2Seats[19],
                            cafeteria2Seats[20],
                            cafeteria2Seats[21],
                            cafeteria2Seats[22],
                            cafeteria2Seats[23],
                            cafeteria2Seats[24],
                            cafeteria2Seats[25],
                            cafeteria2Seats[26],
                            cafeteria2Seats[27],
                            cafeteria2Seats[28],
                            cafeteria2Seats[29],
                            cafeteria2Seats[30],
                            cafeteria2Seats[31],
                            cafeteria2Seats[32],
                            cafeteria2Seats[33],
                            cafeteria2Seats[34],
                            cafeteria2Seats[35],
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),

                        // 37 ~ 54
                        child: _Table(
                          seats: [
                            cafeteria2Seats[36],
                            cafeteria2Seats[37],
                            cafeteria2Seats[38],
                            cafeteria2Seats[39],
                            cafeteria2Seats[40],
                            cafeteria2Seats[41],
                            cafeteria2Seats[42],
                            cafeteria2Seats[43],
                            cafeteria2Seats[44],
                            cafeteria2Seats[45],
                            cafeteria2Seats[46],
                            cafeteria2Seats[47],
                            cafeteria2Seats[48],
                            cafeteria2Seats[49],
                            cafeteria2Seats[50],
                            cafeteria2Seats[51],
                            cafeteria2Seats[52],
                            cafeteria2Seats[53]
                          ],
                        ),
                      ),

                      // 入り口
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Text(
                              '出口',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
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

class _Table extends StatelessWidget {
  const _Table({required this.seats});
  final List<Cafeteria1Seat> seats;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double tableWidth = screenWidth * 0.9;
    double tableHeight = screenHeight * 0.05;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              seats[0],
              seats[1],
              seats[2],
              seats[3],
              seats[4],
              seats[5],
              seats[6],
              seats[7],
              seats[8],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              seats[9],
              seats[10],
              seats[11],
              seats[12],
              seats[13],
              seats[14],
              seats[15],
              seats[16],
              seats[17],
            ],
          ),
        ],
      ),
    );
  }
}

class Cafeteria1Seat extends HookWidget {
  final int seatNumber; // 座席番号
  final bool isSelected; // 座席が選択されているか

  const Cafeteria1Seat({super.key, required this.seatNumber, this.isSelected = false});

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
