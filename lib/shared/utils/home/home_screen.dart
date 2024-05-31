import 'package:chapa_tu_bus_app/account_management/presentation/screens/profile/profile_general_view.dart';
import 'package:chapa_tu_bus_app/shared/utils/home/home_view.dart';
import 'package:chapa_tu_bus_app/shared/widgets/bottom_nav_with_animated_icons.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/favorites_view.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/line_buses_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    _checkLoginMethod();
    pageController = PageController(
      initialPage: widget.pageIndex,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  String getViewNameForIndex(int index) {
    switch (index) {
      case 0:
        return HomeView.getViewName();
      case 1:
        return LineBusesView.getViewName();
      case 2:
        return FavoritesView.getViewName();
      case 3:
        return ProfileGeneralView.getViewName();
      default:
        return '';
    }
  }

  final viewRoutes = [
    const HomeView(),
    const LineBusesView(),
    const FavoritesView(),
    const ProfileGeneralView()
  ];

  void signUserOut() {
    context.go('/start');
    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser!;

  bool isGoogleLogin = false;
  String? photoURL;
  String? email;
  String? phoneNumber;
  String? name;

  Map<String, dynamic> data = {};

  Future getUserData() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.data());
              data = document.data();
              name = data['name'];
              email = data['email'];
              phoneNumber = data['numberPhone'];
              photoURL = data['photoURL'];
            },
          ),
        );
  }

  Future<void> _checkLoginMethod() async {
    final providerData = user.providerData;
    isGoogleLogin =
        providerData.any((userInfo) => userInfo.providerId == 'google.com');
    if (!isGoogleLogin) {
      getUserData();
    } else {
      name = user.displayName;
      email = user.email;
      phoneNumber = user.phoneNumber;
      photoURL = user.photoURL;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (pageController.hasClients) {
      pageController.animateToPage(widget.pageIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    }
    //final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      bottomNavigationBar: BottomNavWithAnimatedIcons(
        currentIndex: widget.pageIndex,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF556BDA),
        title: Text(getViewNameForIndex(widget.pageIndex)),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewRoutes,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
