import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/screens/profile/profile_screen.dart';
import 'package:teego/view/screens/trending/trending_screen.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../../parse/UserModel.dart';
import '../../utils/constants/app_constants.dart';
import 'chat/chat_screen.dart';
import 'home/home_screen.dart';
import 'live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';



class DashboardView extends StatefulWidget {
  const DashboardView({Key? key,}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  UserModel? currentUser;
  late final List<Widget> _screens;
  UserViewModel userViewModel= Get.find();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    currentUser = userViewModel.currentUser;

    _screens = [
      HomeView(currentUser: currentUser,),
      const TrendingView(),
      const ChatView(),
      // LiveScreen(preferences: null, currentUser: currentUser,),
      const ProfileView(),
      // HypeProfile(preferences: null, currentUser: currentUser,),
    ];

    super.initState();
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _getIconColor(int index) {
    return _selectedIndex == index ? const Color(0xffF9c034) : Colors.grey;
  }
//
  void goToLiveScreen(){
    Get.toNamed(AppRoutes.streamerLivePreview,  arguments: {"role":ZegoLiveRole.host})?.then((value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    });
  }




  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BaseScaffold(
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: size.width,
                height: 72,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomPainter(),
                    ),
                    Center(
                      heightFactor: 0.6,
                      child: FloatingActionButton(
                        onPressed: () {
                          goToLiveScreen();
                        },
                        backgroundColor: Color(0xffF9c034),
                        elevation: 0.1,
                        shape: const CircleBorder(),
                        child: Image.asset(
                          AppImagePath.cameraIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => _onItemTapped(0),
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                AppImagePath.homeIcon,
                                color: _getIconColor(0),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _onItemTapped(1),
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                AppImagePath.fireIcon,
                                color: _getIconColor(1),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.20,
                          ),
                          IconButton(
                            onPressed: () => _onItemTapped(2),
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                AppImagePath.chatIcon,
                                color: _getIconColor(2),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _onItemTapped(3),
                            icon: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _getIconColor(3),
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  Get.find<UserViewModel>().currentUser.getAvatar!.url!,
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff252626)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
