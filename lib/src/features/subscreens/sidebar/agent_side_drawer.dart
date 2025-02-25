import 'package:flutter/material.dart';
import 'package:logistics_express/src/services/authentication/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
<<<<<<< HEAD:lib/src/features/subscreens/sidebar_DA/slide_drawer.dart
import 'package:logistics_express/src/features/subscreens/sidebar_DA/featured_screens_DA/edit_profile.dart';
import 'package:logistics_express/src/features/subscreens/sidebar_DA/featured_screens_DA/about.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/contact_support.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/settings.dart';
=======
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/agent_edit_profile.dart';
import 'featured_screens/about.dart';
import 'featured_screens/contact_support.dart';
>>>>>>> b5303af04ddcbcec3a9d1fc3efadf32bfeb106aa:lib/src/features/subscreens/sidebar/agent_side_drawer.dart

import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/settings.dart';

class AgentSideDrawer extends StatelessWidget {
  const AgentSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AuthService authService = AuthService();

    return Drawer(
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
                child: Icon(
                  FontAwesomeIcons.user,
                  size: 50,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'User Name',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
            Center(
              child: Text(
                'Email Id',
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgentEditProfile(),
                        ),
                      );
                    },
                  ),
                  CustomListTile(
                    icon: FontAwesomeIcons.circleInfo,
                    text: 'About',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => About(),
                        ),
                      );
                    },
                  ),
                  CustomListTile(
                      icon: FontAwesomeIcons.headset,
                      text: 'Contact Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactSupport(),
                          ),
                        );
                      }),
                  CustomListTile(
                      icon: FontAwesomeIcons.gear,
                      text: 'Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(),
                          ),
                        );
                      }),
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
              onTap: () => authService.signOut(context),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextButton(
                  icon: FontAwesomeIcons.envelope,
                  onPressed: () {},
                ),
                CustomTextButton(
                  icon: FontAwesomeIcons.circleInfo,
                  onPressed: () {},
                ),
                CustomTextButton(
                  icon: FontAwesomeIcons.instagram,
                  onPressed: () {},
                ),
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
    );
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
