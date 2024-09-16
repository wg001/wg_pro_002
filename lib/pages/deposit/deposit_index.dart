import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/pages/deposit/deposit_apply.dart';
import 'package:wg_pro_002/pages/deposit/deposit_info.dart';

class DepositIndex extends StatefulWidget {
  const DepositIndex({super.key});

  @override
  _DepositIndexState createState() => _DepositIndexState();
}

// 数据模型类
class DepositItem {
  final String amount;
  final String term;
  final String status;

  DepositItem({
    required this.amount,
    required this.term,
    required this.status,
  });

  factory DepositItem.fromJson(Map<String, dynamic> json) {
    return DepositItem(
      amount: json['amount'],
      term: json['term'],
      status: json['status'],
    );
  }
}

class _DepositIndexState extends State<DepositIndex> {
  List<DepositItem> _depositItems = [];
  bool _isLoading = true; // 初始加载指示器
  bool _isLoadingMore = false; // 加载更多数据时的指示器
  int _currentPage = 1; // 当前页码
  final int _perPage = 10; // 每页的数据量
  final ScrollController _scrollController = ScrollController(); // 滚动控制器

  @override
  void initState() {
    super.initState();
    _fetchDepositItems(); // 获取初始数据
    _scrollController.addListener(_onScroll); // 添加滚动监听
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 释放控制器
    super.dispose();
  }

  // 模拟带分页的 API 调用
  Future<void> _fetchDepositItems({bool isLoadMore = false}) async {
    if (isLoadMore) {
      setState(() {
        _isLoadingMore = true;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      // 模拟网络延迟
      await Future.delayed(const Duration(seconds: 2));

      // 模拟的 API 响应数据
      List<Map<String, dynamic>> data = [];

      // 为了模拟没有数据的情况，我们将 data 设置为空列表
      // 如果想要测试有数据的情况，可以将以下代码取消注释
      /*
      data = List.generate(_perPage, (index) {
        int itemNumber = index + 1 + (_currentPage - 1) * _perPage;
        return {
          'amount': '${itemNumber * 1000000}',
          'term': '${7 + index % 3 * 7}天',
          'status': index % 2 == 0 ? '待存款' : '已存款',
        };
      });
      */

      // 模拟数据结束
      bool hasMoreData = _currentPage < 3 && data.isNotEmpty; // 假设有 5 页数据

      setState(() {
        if (isLoadMore) {
          _depositItems
              .addAll(data.map((item) => DepositItem.fromJson(item)).toList());
          _isLoadingMore = false;
        } else {
          _depositItems =
              data.map((item) => DepositItem.fromJson(item)).toList();
          _isLoading = false;
        }
        if (hasMoreData) {
          _currentPage++;
        } else {
          // 没有更多数据，移除监听
          _scrollController.removeListener(_onScroll);
        }
      });
    } catch (e) {
      // 处理异常
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
      print('Error: $e');
    }
  }

  void _onScroll() {
    if (!_isLoadingMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) {
      // 接近底部
      _fetchDepositItems(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // 设置回退图标的颜色
        ),
        title: const Text('存款服务'),
        // backgroundColor: Colors.red, // AppBar 背景设为红色
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // 显示加载指示器
          : Stack(
              children: [
                // 顶部部分
                _buildTopSection(context),
                // 列表部分
                Positioned.fill(
                  top: 140, // 调整这个值以控制列表向下偏移，确保与顶部部分重叠
                  child: Column(
                    children: [
                      Expanded(
                        child: _depositItems.isEmpty
                            ? Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: const Center(
                                  child: Text(
                                    '暂时没有数据',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ))
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: _depositItems.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == _depositItems.length) {
                                    // 加载指示器
                                    return _buildLoadMoreIndicator();
                                  } else {
                                    return Column(
                                      children: [
                                        _buildDepositDetails(
                                            _depositItems[index], index),
                                        if (index != _depositItems.length - 1)
                                          _buildGreyDivider(),
                                      ],
                                    );
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    // 与之前相同
    return Container(
      padding: const EdgeInsets.all(20),
      color: WGColors.ThemeColor, // 红色背景
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Text('存款金额',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                    const Gap(5),
                    _help(context)
                  ]),
                  const SizedBox(height: 10),
                  const Text(
                    '12000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: WGColors.ThemeColor,
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  '去储蓄',
                  style: TextStyle(fontSize: 13),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DepositApply()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _help(BuildContext context) {
    // 与之前相同
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DepositInfo()));
        },
        child: Image.asset('${Config.BASE_APP_ASSETS_PATH}deposit_help.png'));
  }

  Widget _buildDepositDetails(DepositItem item, int index) {
    // 与之前相同，但使用传入的 item 数据
    // 根据索引调整圆角
    BorderRadius borderRadius;
    if (index == 0) {
      // 列表中的第一个项，左上角和右上角是圆角
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      );
    } else {
      // 其他项，圆角为 0
      borderRadius = BorderRadius.zero;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0), // 添加四周的间距
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white, // 白色卡片背景
        borderRadius: borderRadius, // 卡片圆角
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('存款金额', item.amount),
          const SizedBox(height: 10),
          _buildDetailRow('存款期限', item.term),
          const SizedBox(height: 10),
          _buildDetailRowWithColor(
            '当前状态',
            item.status,
            item.status == '待存款' ? Colors.orange : Colors.green,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MathUtils.screenWidth - 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: WGColors.ThemeColor,
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
              child: const Text(
                '去存款',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              onPressed: () {
                // 处理按钮操作
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    // 与之前相同
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithColor(String label, String value, Color color) {
    // 与之前相同
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildGreyDivider() {
    // 与之前相同
    return Container(
      height: 10,
      color: Colors.grey[200], // 浅灰色背景作为分割线
    );
  }

  Widget _buildLoadMoreIndicator() {
    // 加载更多指示器
    return Visibility(
      visible: _isLoadingMore,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
