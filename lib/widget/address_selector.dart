import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wg_pro_002/app/model/AddressSelect.dart';

// 定义一个选择完成的回调类型
typedef AddressCallback = void Function(
    String province, String city, String area);

class AddressSelector extends StatefulWidget {
  final Future<List<AddressSelect>> Function(String? id) fetchAddress;
  final AddressCallback onComplete;

  const AddressSelector(
      {super.key, required this.fetchAddress, required this.onComplete});

  @override
  _AddressSelectorState createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  AddressSelect? tmpProvince;
  AddressSelect? tmpCity;
  AddressSelect? tmpArea;
  int curIndex = 0;
  String? id;

  @override
  Widget build(BuildContext context) {
    double heightVal = MediaQuery.of(context).size.height * 0.7;
    double widthVal = MediaQuery.of(context).size.width - 100;

    return Container(
      height: heightVal,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          addressSelectionRow(context, widthVal),
          const Divider(height: 0.1),
          Expanded(
            child: FutureBuilder<List<AddressSelect>>(
              future: widget.fetchAddress(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    AddressSelect address = snapshot.data![index];
                    return InkWell(
                      onTap: () => handleAddressSelect(address),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Text(address.Value ?? ''),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget addressSelectionRow(BuildContext context, double widthVal) {
    return Padding(
      padding: const EdgeInsets.all(
          3), // Padding added here to apply to the whole row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            // Use Expanded to ensure the row of address options takes up all available space
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // This will provide even spacing between the address options
              children: <Widget>[
                addressOption(context, 'Select province', tmpProvince?.Value,
                    widthVal / 4, true, () {
                  // Adjust width to account for spacing
                  if (curIndex > 0) {
                    setState(() {
                      id = null;
                      curIndex = 0;
                    });
                  }
                }),
                const SizedBox(
                  width: 5,
                ),
                addressOption(context, 'Select city', tmpCity?.Value,
                    widthVal / 4, tmpProvince != null, () {
                  if (curIndex != 1) {
                    setState(() {
                      curIndex = 1;
                      id = tmpProvince?.Id;
                    });
                  }
                }),
                const SizedBox(
                  width: 5,
                ),
                addressOption(context, 'Select area', tmpArea?.Value,
                    widthVal / 4, tmpCity != null, () {
                  if (curIndex < 2) {
                    setState(() {
                      curIndex = 2;
                      id = tmpCity?.Id;
                    });
                  }
                }),
              ],
            ),
          ),
          confirmButton(),
        ],
      ),
    );
  }

  Widget addressOption(BuildContext context, String placeholder, String? value,
      double width, bool visible, VoidCallback onTap) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value ?? placeholder,
            style: const TextStyle(fontSize: 13, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget confirmButton() {
    return ElevatedButton(
      onPressed: () {
        if (tmpProvince != null && tmpCity != null && tmpArea != null) {
          widget.onComplete(
              tmpProvince!.Value!, tmpCity!.Value!, tmpArea!.Value!);
        } else {
          Fluttertoast.showToast(msg: "Please complete the address selection.");
        }
      },
      child: const Text('Confirm'),
    );
  }

  void handleAddressSelect(AddressSelect address) {
    setState(() {
      if (curIndex == 0) {
        tmpProvince = address;
        tmpCity = null;
        tmpArea = null;
        id = address.Id;
        curIndex = 1;
      } else if (curIndex == 1) {
        tmpCity = address;
        tmpArea = null;
        curIndex = 2;
        id = address.Id;
      } else {
        tmpArea = address;
      }
    });
  }
}
