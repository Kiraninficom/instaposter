import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  Widget detail({required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
        ),
        w(10),
        InkWell(
          onTap: () {},
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact Us'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20.0),
            child: Card(
              elevation: 1.5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detail(
                        icon: Icons.business,
                        title: 'Inficom Solutions Pvt Ltd'),
                    h(15),
                    detail(
                        icon: Icons.place_outlined,
                        title: ' Aurangabad Maharashtra'),
                    h(15),
                    detail(icon: Icons.call_outlined, title: '88888705875'),
                    h(15),
                    detail(
                        icon: Icons.alternate_email_outlined,
                        title: 'mujtaba@inficom.solutions.com'),
                    h(15),
                    detail(
                        icon: FontAwesomeIcons.globe, title: 'clickonadd.com'),
                    h(15),
                    detail(icon: Icons.call, title: '88888705875'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
