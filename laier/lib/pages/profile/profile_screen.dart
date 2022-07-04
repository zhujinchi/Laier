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
            child: getprotileView()));
  }

  Widget getprotileView() {
    return Column(
      children: <Widget>[
        Container(
          height: 100.w,
          width: 390.w,
          color: SystemInfo.shared().themeColor,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 15.w),
                child: ClipOval(
                    child: Image.network(
                        "https://bkimg.cdn.bcebos.com/pic/0b46f21fbe096b634c5ee7ef0c338744eaf8acce?x-bce-process=image/resize,m_lfit,w_536,limit_1/format,f_jpg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 100.w, top: 20.w),
                child: Text(
                  '用户：武汉大学001',
                  style: TextStyle(fontSize: 16.w, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            //列表视图
            children: <Widget>[
              ListTile(
                //列表块
                leading: Icon(
                  Icons.article_outlined,
                  color: SystemInfo.shared().themeColor,
                  size: 25,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                ),
                title: Text(
                  '数据导出',
                  style: TextStyle(
                    fontSize: 16.w,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.add_moderator_outlined,
                  color: SystemInfo.shared().themeColor,
                  size: 25,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                ),
                title: Text(
                  '账号安全',
                  style: TextStyle(
                    fontSize: 16.w,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: SystemInfo.shared().themeColor,
                  size: 25,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                ),
                title: Text(
                  '设置',
                  style: TextStyle(
                    fontSize: 16.w,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
