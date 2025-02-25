import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/password_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedMenu = "All"; // Tracks which menu option is selected

  @override
  void initState() {
    super.initState();
    // Automatically load all passwords when we init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<PasswordProvider>(context, listen: false).applicationNames.isEmpty) {
        Provider.of<PasswordProvider>(context, listen: false).fetchAllPasswords();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Password Manager")),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  "",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            _buildDrawerItem("All", Icons.list),
            _buildDrawerItem("Favorites", Icons.star),
            _buildDrawerItem("Security Recommendations", Icons.security),
            _buildDrawerItem("Settings", Icons.settings),
          ],
        ),
      ),
      body: _buildScreenContent(), // Show selected content
    );
  }

  Widget _buildDrawerItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedMenu == title,
      onTap: () {
        setState(() {
          _selectedMenu = title;
        });
        Navigator.pop(context); // Close drawer after selection
      },
    );
  }

  Widget _buildScreenContent() {
    switch (_selectedMenu) {
      case "All":
        return AllPasswordsView();
      case "Favorites":
        return Center(child: Text("Favorites (Coming Soon)"));
      case "Security Recommendations":
        return Center(child: Text("Security Recommendations (Coming Soon)"));
      case "Settings":
        return Center(child: Text("Settings (Coming Soon)"));
      default:
        return Center(child: Text("Select an option from the menu"));
    }
  }

}


class AllPasswordsView extends StatelessWidget {
  const AllPasswordsView({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordProvider>(context);
    final applicationNames = passwordProvider.applicationNames;

    return Column(
      children: [
        _buildAddPasswordButton(context),
        Expanded(
          child: ListView.builder(
            itemCount: applicationNames.length,
            itemBuilder: (ctx, index) {
              final appName = applicationNames[index];
              return ListTile(
                title: Text(appName),
                onTap: () async {
                  // Fetch full details from /getPassword
                  await passwordProvider.getPasswordDetails(appName);

                  // Show details dialog
                  if (passwordProvider.selectedEntry != null) {
                    _showPasswordDetailsDialog(context, passwordProvider.selectedEntry!);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Button to add a new password
  Widget _buildAddPasswordButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            _showAddPasswordDialog(context);
          },
          child: Text("Add New Password"),
        ),
      ),
    );
  }

  // Show the add-new-password dialog
  void _showAddPasswordDialog(BuildContext context) {
    final passwordProvider = Provider.of<PasswordProvider>(context, listen: false);
    final appNameCtrl = TextEditingController();
    final urlCtrl = TextEditingController();
    final usernameCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final notesCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Add New Password"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: appNameCtrl,
                  decoration: InputDecoration(labelText: "Application Name"),
                ),
                TextField(
                  controller: urlCtrl,
                  decoration: InputDecoration(labelText: "Application URL"),
                ),
                TextField(
                  controller: usernameCtrl,
                  decoration: InputDecoration(labelText: "Username"),
                ),
                TextField(
                  controller: passCtrl,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                TextField(
                  controller: notesCtrl,
                  decoration: InputDecoration(labelText: "Notes (optional)"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final success = await passwordProvider.createNewPassword(
                  applicationName: appNameCtrl.text,
                  applicationURL: urlCtrl.text,
                  username: usernameCtrl.text,
                  password: passCtrl.text,
                  notes: notesCtrl.text.isEmpty ? null : notesCtrl.text,
                );

                if (success) {
                  Navigator.pop(ctx); // close dialog
                } else {
                  // Show error or handle failure
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Show details pop-up for a password
  void _showPasswordDetailsDialog(BuildContext context, passwordEntry) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(passwordEntry.applicationName),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("URL: ${passwordEntry.applicationURL}"),
                SizedBox(height: 6),
                Text("Username: ${passwordEntry.username}"),
                SizedBox(height: 6),
                Text("Password: ${passwordEntry.password}"),
                if (passwordEntry.notes != null && passwordEntry.notes.isNotEmpty) ...[
                  SizedBox(height: 6),
                  Text("Notes: ${passwordEntry.notes}"),
                ]
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}