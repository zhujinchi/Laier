import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/system_info.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List singlelistData = [];

  List multiplelistData = [
    {
      "title": "记录1",
      "introduction": "拍摄于武汉大学",
      "imageUrl":
          "https://cid-inc.com/app/uploads/2020/10/lai_leaf_area_index_canopy.jpg",
    },
  ];

  _getImageInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      singlelistData = [];
      if (prefs.getString('imageInfo') != null) {
        var imageInfo = prefs.getString('imageInfo');
        var infoList = imageInfo!.split(';');
        for (var i = 0; i < infoList.length; i++) {
          singlelistData.add({
            "title": '记录' + (i + 1).toString(),
            "introduction": infoList[i].split('@')[1],
            "imageUrl": infoList[i].split('@')[0]
          });
        }
      } else {
        singlelistData = [];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getImageInfo();
    _tabController = TabController(length: 2, vsync: this);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
    );

    return Scaffold(
        backgroundColor: SystemInfo.shared().backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0.w,
          title: Text(
            '历史',
            style: TextStyle(
                color: SystemInfo.shared().themeColor,
                fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: SystemInfo.shared().themeColor,
            indicatorColor: SystemInfo.shared().themeColor.withOpacity(0.8),
            tabs: const [
              Tab(
                text: "单次",
              ),
              Tab(
                text: "批量处理",
              ),
            ],
          ),
        ),

        //内容区域
        body: TabBarView(
          //必须配置
          controller: _tabController,
          children: [singleList(), multipleList()],
        ));
  }

  Widget singleList() {
    return EasyRefresh(
      child: ListView(
          children: singlelistData.map((value) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Image.file(File(value['imageUrl'])),
              subtitle: Text('lai值：3.14\n经纬度：北纬 N31.37  东经E121.80\n时间：' +
                  value['introduction']),
              title: Text('单次拍摄：' + value['title']),
              selectedColor: Colors.grey,
              enabled: true,
              onTap: () {
                showAlertDialog(value['imageUrl']);
              },
            ),
            const Divider(height: 1, indent: 0.0, color: Colors.grey)
          ],
        );
      }).toList()),
      onRefresh: () async {
        _getImageInfo();
        setState(() {});
      },
    );
  }

  getClassification(String imgPath) async {
    final imageTemp = File(imgPath);
    List<int> imageBytes = imageTemp.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    print(base64Image);
    var bodyData = FormData.fromMap({'image': base64Image});
    var dio = Dio();
    String access_token =
        '24.983c17b83b03e9b6125eaa3efa8e771b.2592000.1659623436.282335-26630446';
    var resp = await dio.post(
        'https://aip.baidubce.com/rest/2.0/image-classify/v1/plant?access_token=' +
            access_token,
        data: bodyData,
        options:
            Options(contentType: "application/x-www-form-urlencoded")); //这里没有返回

    print(resp);
    return resp.data['result'][0]['name'];
  }

  Future<void> showAlertDialog(String imgPath) async {
    String plantclass = await getClassification(imgPath);
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '图片识别结果:' + plantclass,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0),
            ),
            //可滑动
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.file(File(imgPath)),
                  SizedBox(
                    height: 15.w,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text(
                  '确定',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text(
                  '取消',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget multipleList() {
    return ListView(
        children: multiplelistData.map((value) {
      return Column(
        children: <Widget>[
          ListTile(
            leading: Image.network(value['imageUrl']),
            subtitle: Text('lai值：' + getlai()),
            title: Text('批量拍摄：' + value['title']),
            selectedColor: Colors.grey,
            enabled: true,
            onTap: () {
              print('123');
            },
          ),
          const Divider(height: 1, indent: 0.0, color: Colors.grey)
        ],
      );
    }).toList());
  }

  String getlai() {
    var rng = new Random();
    var temp = rng.nextInt(10000) / 10000;
    return temp.toString();
  }
}
