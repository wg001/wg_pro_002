import 'package:flutter/material.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';

class DepositInfo extends StatelessWidget {
  const DepositInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '存款',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        backgroundColor: WGColors.ThemeColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // 设置回退图标的颜色
          // size: 28, // 设置回退图标的大小
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    WGColors.ThemeColor, // 从主题颜色开始
                    Color.fromRGBO(249, 249, 249, 1) // 渐变到白色
                  ],
                  stops: [0.3, 0.3],
                ),
              ),
            ),
          ),
          _mainContent(context),
        ],
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Container(
        height: MathUtils.screenHeight * 2 / 3,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SIMPANAN PEMBERDAYAAN SAHABAT KOPI SUSU (SIMBATKU)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildSectionTitle('Ketentuan Simpanan:'),
              const Text(
                '1. Simpanan mulai dari Rp10.000.000 (Initial Deposit start from Rp10.000.000)\n'
                '2. Bagi hasil yang sangat bersaing dengan hasil maksimal',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              // Withdrawal Rules Section
              _buildSectionTitle(
                  'Ketentuan Penarikan/Pencairan Dana sebelum Jatuh Tempo:'),
              const Text(
                '1. Bunga Berjalan Hangus\n'
                '2. Biaya/Denda Pinalti 20% dari Pokok Simpanan\n'
                '3. Pajak sesuai ketentuan yang berlaku',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              // Interest Rate Section with Table
              _buildInterestRateTable(),
              const SizedBox(height: 20),
              // Terms Section
              _buildSectionTitle('Syarat Simpanan:'),
              const Text(
                '1. Menjadi Anggota Koperasi Pilihan Sahabat Semua\n'
                '2. Menandatangani Formulir Simpanan (Secara Digital)',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ));
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInterestRateTable() {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(151, 151, 151, 1), // 边框颜色
          width: 0.6, // 边框宽度
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 30,
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(220, 134, 75, 1),
                  Color.fromRGBO(240, 172, 119, 1),
                ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Suku Bunga',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
          ),
          const SizedBox(height: 5),
          _buildInterestRateRow('3 Bulan', '5%/tahun'),
          _buildInterestRateRow('6 Bulan', '5.5%/tahun'),
          _buildInterestRateRow('12 Bulan', '6%/tahun'),
        ],
      ),
    );
  }

  Widget _buildInterestRateRow(String period, String rate) {
    double marginLeft = MathUtils.screenWidth / 5 - 10;
    TextStyle fontStyle =
        const TextStyle(color: Color.fromRGBO(102, 102, 102, 1), fontSize: 15);
    return Padding(
      padding: EdgeInsets.only(left: marginLeft, top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              period,
              textAlign: TextAlign.left,
              style: fontStyle,
            ),
          ),
          Expanded(
            child: Text(
              rate,
              textAlign: TextAlign.left,
              style: fontStyle,
            ),
          ),
        ],
      ),
    );
  }
}
