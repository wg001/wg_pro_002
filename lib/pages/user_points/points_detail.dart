import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/pages/user_points/points.dart';

class PointsDetail extends StatelessWidget {
  final Product product;
  const PointsDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Divider line = const Divider(
      thickness: 1,
      height: 1,
      color: Color.fromRGBO(234, 234, 234, 1),
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 积分券
          Center(
            child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    line,
                    const Gap(20),
                    SizedBox(
                      width: MathUtils.screenWidth * 0.4,
                      height: 100,
                      child: Image.asset(
                        product.proImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromRGBO(51, 51, 51, 1)),
                    ),
                    const Gap(30),
                    line,
                    const Gap(10),
                    Row(
                      children: [
                        const Gap(30),
                        Text(
                          "${product.points} points",
                          style:
                              const TextStyle(fontSize: 24, color: Colors.red),
                        ),
                      ],
                    ),
                    const Gap(10)
                  ],
                )),
          ),
          const Gap(10),
          // 积分数

          // 使用方法标题
          Column(children: [
            Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "使用方法",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(51, 51, 51, 1)),
                          ),
                        ],
                      )),
                  line,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      '借款或存款时抵扣当月服务费\n\n我是额外说明我是额外说明我是额外说明我是额外说明我是额外说明我是额外说明我是额外说明我是额外说明Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(102, 102, 102, 1)),
                    ),
                  ),
                  const Gap(20)
                ])),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // 确认逻辑
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(225, 142, 85, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    '确认',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ],
      )),
    );
  }
}
