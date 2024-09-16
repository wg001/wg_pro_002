import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/pages/user_points/points.dart';
import 'package:wg_pro_002/pages/user_points/points_detail.dart';
import 'package:wg_pro_002/utils/common_utils.dart';

class PointsMall extends StatefulWidget {
  const PointsMall({super.key});

  @override
  _PointsShopPageState createState() => _PointsShopPageState();
}

class _PointsShopPageState extends State<PointsMall> {
  final ScrollController _scrollController = ScrollController();

  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        loadMoreProducts();
      }
    });
  }

  void loadMoreProducts() async {
    setState(() {
      isLoadingMore = true;
    });

    // 模拟加载更多数据
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        // products.addAll([
        //   Product(proImage: Config.BASE_APP_ASSETS_PATH+"", name: "新加载商品", points: 1500, value: "Rp7,000"),
        //   Product(name: "新加载商品2", points: 2500, value: "Rp15,000"),
        // ]);
        isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        title: const Text('积分商城'),
      ),
      body: Column(
        children: [
          // Top card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage(
                      '${Config.BASE_APP_ASSETS_PATH}home_bottom_bg_img.png'),
                  fit: BoxFit.fill, // 添加适当的填充模式
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            const Text(
                              '我的积分:',
                              style: TextStyle(
                                  color: Color.fromRGBO(96, 32, 0, 1),
                                  fontSize: 18),
                            ),
                            const Gap(5),
                            _help(context)
                          ]),
                          const Text(
                            '200',
                            style: TextStyle(
                                color: Color.fromRGBO(96, 32, 0, 1),
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Text(
                        '查看详情',
                        style: TextStyle(
                            fontSize: 13, color: Color.fromRGBO(96, 32, 0, 1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: PointsData.products.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == PointsData.products.length) {
                  // 显示加载更多的进度条
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final product = PointsData.products[index];
                return InkWell(
                    onTap: () {
                      CommonUtils.showToast(product.name);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PointsDetail(
                                product: product,
                              )));
                    },
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(product.proImage)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Gap(20),
                                  Text(
                                    "${product.points} 积分",
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _help(BuildContext context) {
    // 与之前相同
    return GestureDetector(
      onTap: () {
        CommonUtils.showToast("help01");
      },
      child: const Icon(
        Icons.help,
        color: Color.fromRGBO(247, 175, 160, 1),
      ),
    );
  }
}
