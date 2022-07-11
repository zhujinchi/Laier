import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/system_info.dart';
import 'dart:convert';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';

class MeasureScreen extends StatefulWidget {
  const MeasureScreen({Key? key}) : super(key: key);

  @override
  _MeasureScreenState createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  File? image;

  @override
  void initState() {
    super.initState();
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
            '测量',
            style: TextStyle(
                color: SystemInfo.shared().themeColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        //内容区域
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: CustomScrollView(
            slivers: <Widget>[_buildsingleView(), _buildmultipleView()],
          ),
        ));
  }

  SliverToBoxAdapter _buildsingleView() {
    return SliverToBoxAdapter(
        child: Container(
      height: 155.w,
      margin: EdgeInsets.only(left: 16.w, top: 20.w, right: 16.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          boxShadow: [
            BoxShadow(
                color:
                    const Color.fromRGBO(192, 192, 192, 0.5).withOpacity(0.2),
                offset: Offset(0, 2.2.w), //阴影xy轴偏移量
                blurRadius: 7.7.w, //阴影模糊程度
                spreadRadius: 0 //阴影扩散程度
                )
          ]),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 20.w),
            child: const Image(
                image: AssetImage("assets/images/single_camera.png"),
                width: 45,
                height: 45,
                fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80.w, top: 20.w),
            child: Text(
              '说明：单次采样并分析处理',
              style: TextStyle(
                fontSize: 16.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80.w, top: 45.w),
            child: Text(
              '点击记录单次Lai采集数据',
              style: TextStyle(fontSize: 16.w, color: Colors.grey),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 95.w),
              child: Divider(
                color: Colors.grey.withOpacity(0.4),
                height: 0.w,
                thickness: 0.5.w,
                indent: 11.w,
                endIndent: 11.w,
              )),
          Padding(
            padding: EdgeInsets.only(left: 250.w, top: 100.w),
            child: OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 140,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("拍照"),
                            onTap: () {
                              getImage(true);
                              Navigator.pop(context);
                            },
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("相册"),
                            onTap: () {
                              getImage(false);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.w),
                ),
                backgroundColor: SystemInfo.shared().themeColor,
                side: BorderSide(
                  width: 0.5.w,
                  color: SystemInfo.shared().themeColor,
                ),
              ),
              child: Text(
                "单次拍摄",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 0),
              ),
            ),
          )
        ],
      ),
    ));
  }

  SliverToBoxAdapter _buildmultipleView() {
    return SliverToBoxAdapter(
        child: Container(
      height: 155.w,
      margin: EdgeInsets.only(left: 16.w, top: 20.w, right: 16.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          boxShadow: [
            BoxShadow(
                color:
                    const Color.fromRGBO(192, 192, 192, 0.5).withOpacity(0.2),
                offset: Offset(0, 2.2.w), //阴影xy轴偏移量
                blurRadius: 7.7.w, //阴影模糊程度
                spreadRadius: 0 //阴影扩散程度
                )
          ]),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 20.w),
            child: const Image(
                image: AssetImage("assets/images/multiple_camera.png"),
                width: 45,
                height: 45,
                fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80.w, top: 20.w),
            child: Text(
              '说明：批量采样后统一分析处理',
              style: TextStyle(
                fontSize: 16.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80.w, top: 45.w),
            child: Text(
              '点击记录批量Lai采集数据',
              style: TextStyle(fontSize: 16.w, color: Colors.grey),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 95.w),
              child: Divider(
                color: Colors.grey.withOpacity(0.4),
                height: 0.w,
                thickness: 0.5.w,
                indent: 11.w,
                endIndent: 11.w,
              )),
          Padding(
            padding: EdgeInsets.only(left: 250.w, top: 100.w),
            child: OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 140,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("拍照"),
                            onTap: () {
                              getImage(true);
                              Navigator.pop(context);
                            },
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("相册"),
                            onTap: () {
                              getImage(false);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.w),
                ),
                backgroundColor: SystemInfo.shared().themeColor,
                side: BorderSide(
                  width: 0.5.w,
                  color: SystemInfo.shared().themeColor,
                ),
              ),
              child: Text(
                "多次拍摄",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 0),
              ),
            ),
          )
        ],
      ),
    ));
  }

  getImage(bool istakephoto) async {
    try {
      // 拍照 or 本地相册
      final image = await ImagePicker().pickImage(
          source: istakephoto ? ImageSource.camera : ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      Uint8List img = imageTemp.readAsBytesSync();
      //保存图片到本地相册
      final result =
          await ImageGallerySaver.saveImage(img, quality: 60, name: "k");

      var imgpath =
          await LecleFlutterAbsolutePath.getAbsolutePath(result['filePath']);
      // print(img);
      // var bodyData = FormData.fromMap({'file': img});
      // var dio = Dio();

      // var resp = await dio.post('http://43.134.47.8:5000/lai',
      //     data: bodyData,
      //     options: Options(contentType: "multipart/form-data")); //这里没有返回
      // print(resp.data);
      // print(resp.data['lai']);
      // var lai = (resp.data)['lai'];
      // var newImgInfo = result['filePath'] + '@' + lai + ';';
      var newImgInfo = '123';
      showAlertDialog(imgpath!);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void showAlertDialog(String imgPath) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              '图片是否满足需求？',
              style: TextStyle(
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
                  const Text(
                    '  ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        letterSpacing: 0),
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
                  showAlertDialog2(imgPath);
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

  void showAlertDialog2(String imgPath) {
    DateTime dateTime = DateTime.now();
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              '处理后的图片',
              style: TextStyle(
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
                  Text(
                    'lai值：3.14\n经纬度：北纬 N31.37  东经E121.80\n时间：' +
                        dateTime.toString().substring(0, 19),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        letterSpacing: 0),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text(
                  '保存',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 0),
                ),
                onPressed: () {
                  _save(imgPath, dateTime.toString().substring(0, 19));
                  Fluttertoast.showToast(msg: '保存成功');
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text(
                  '放弃',
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

  _save(String newImgInfo, String datatime) async {
    //保存图片地址和lai值到本地
    var imageinformation = newImgInfo + '@' + datatime + ';';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('imageInfo') != null) {
      var oldData = prefs.getString('imageInfo');
      var data = oldData! + imageinformation;
      prefs.setString('imageInfo', data);
    } else {
      prefs.setString('imageInfo', imageinformation);
    }
  }

  Future<Uint8List?> _fun(image) async {
    ByteData? byteData = await image.toByteData();
    if (byteData != null) {
      Uint8List bytes = byteData.buffer.asUint8List();
      return bytes;
    }
    return null;
  }
}
