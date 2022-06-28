import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/system_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            '我的',
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
            slivers: <Widget>[
              _buildBorrowView(),
            ],
          ),
        ));
  }

  SliverToBoxAdapter _buildBorrowView() {
    return SliverToBoxAdapter(
        child: Container(
      height: 155.w,
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          boxShadow: [
            BoxShadow(
                color:
                    const Color.fromRGBO(192, 192, 192, 0.5).withOpacity(0.2),
                offset: Offset(0, 2.2.w), //阴影xy轴偏移量
                blurRadius: 7.7.w, //阴影模糊程度
                spreadRadius: 0 //阴影扩散程度
                )
          ]),
    ));
  }
}
