import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/about.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/contact_support.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/edit_profile.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/settings.dart'
    as custom;
import 'package:logistics_express/src/services/authentication/auth_service.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late CollectionReference _firestore;

  String _userName = "User Name";
  String _userEmail = "Email Id";
  String _profileImage = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final User? user = _auth.currentUser;

    try {
      final userInfo = await _authService.getUserRole(user!.uid, context);
      final String role = userInfo['role'] ?? 'Customer';
      setState(() {
        _firestore = FirebaseFirestore.instance
            .collection(role == 'Customer' ? 'customers' : 'agents');
      });

      await _fetchUserData();
    } catch (e) {
      if (!mounted) return;
      showErrorSnackBar(context, "Error initializing user data: $e");
    }
  }

  Future<void> _fetchUserData() async {
    final User? user = _auth.currentUser;

    try {
      final doc = await _firestore.doc(user!.uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        setState(() {
          _userName = data?['Name'] ?? 'User Name';
          _userEmail = data?['Email'] ?? 'Email Id';
          _profileImage = data?['ProfileImageUrl'] ?? '';
          isLoading = false;
        });
      } else {
        if (mounted) {
          showErrorSnackBar(context, 'User document not found.');
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, "Error fetching user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Drawer(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.onPrimaryFixedVariant.withOpacity(0.4),
                  theme.colorScheme.onPrimaryFixedVariant.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.colorScheme.onPrimaryContainer,
                    backgroundImage: _profileImage.isNotEmpty
                        ? NetworkImage(_profileImage)
                        : null,
                    child: _profileImage.isEmpty
                        ? Icon(
                            FontAwesomeIcons.user,
                            size: 50,
                            color: theme.colorScheme.primary,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    _userName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    _userEmail,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(
                  color: theme.colorScheme.onPrimary.withOpacity(0.7),
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      CustomListTile(
                        icon: FontAwesomeIcons.penToSquare,
                        text: 'Edit Profile',
                        onTap: () => _navigateTo(const EditProfile()),
                      ),
                      CustomListTile(
                        icon: FontAwesomeIcons.circleInfo,
                        text: 'About',
                        onTap: () => _navigateTo(const About()),
                      ),
                      CustomListTile(
                        icon: FontAwesomeIcons.headset,
                        text: 'Contact Support',
                        onTap: () => _navigateTo(const ContactSupport()),
                      ),
                      CustomListTile(
                        icon: FontAwesomeIcons.gear,
                        text: 'Settings',
                        onTap: () => _navigateTo(custom.Settings()),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Divider(
                  color: theme.colorScheme.onPrimary.withOpacity(0.7),
                  thickness: 1,
                ),
                CustomListTile(
                  icon: FontAwesomeIcons.rightFromBracket,
                  text: 'Log Out',
                  onTap: () => _authService.signOut(context),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextButton(
                        icon: FontAwesomeIcons.envelope, onPressed: () {}),
                    CustomTextButton(
                        icon: FontAwesomeIcons.github, onPressed: () {}),
                    CustomTextButton(
                        icon: FontAwesomeIcons.linkedin, onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'App Version 1.0',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(0.6),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CustomLoader(),
              ),
            ),
          ),
      ],
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: theme.colorScheme.onPrimary,
      ),
      title: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      onTap: onTap,
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: theme.colorScheme.onPrimary,
      ),
    );
  }
}
