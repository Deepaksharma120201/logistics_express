import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/edit_profile.dart';
import 'package:logistics_express/src/services/authentication/auth_service.dart';

class SlideDrawer extends StatelessWidget {
  const SlideDrawer({super.key});

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
                  Icons.person,
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
                    icon: Icons.edit,
                    text: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(),
                        ),
                      );
                    },
                  ),
                  CustomListTile(
                    icon: Icons.info,
                    text: 'About',
                    onTap: () {},
                  ),
                  CustomListTile(
                    icon: Icons.contact_page,
                    text: 'Contact Support',
                    onTap: () {},
                  ),
                  CustomListTile(
                    icon: Icons.settings,
                    text: 'Settings',
                    onTap: () {},
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
              icon: Icons.logout,
              text: 'Log Out',
              onTap: () => authService.signOut(context),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextButton(
                  icon: Icons.mail,
                  onPressed: () {},
                ),
                CustomTextButton(
                  icon: Icons.info,
                  onPressed: () {},
                ),
                CustomTextButton(
                  icon: Icons.image,
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
