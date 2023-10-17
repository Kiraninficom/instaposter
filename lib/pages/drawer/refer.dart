import 'package:click/helpers/color_extension.dart';
import 'package:click/utils/constants.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/button.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Refer extends StatefulWidget {
  const Refer({Key? key}) : super(key: key);

  @override
  State<Refer> createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  String referCode = 'vakxi';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: TextButton(
                child: Row(
                  children: [
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 18,
                        color: '#53438A'.toColor(),
                      ),
                    ),
                    w(3),
                    Icon(
                      Icons.help_outline_outlined,
                      color: '#53438A'.toColor(),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Refer a friend',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                h(10),
                const Text(
                  'And you can earn 20 coins',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                h(5),
                // Icon(
                //   FontAwesomeIcons.c,
                //   color: '#53438A'.toColor(),
                // ),
                // w(5),
                Text(
                  'How it works',
                  style: TextStyle(
                    color: '#53438A'.toColor(),
                    fontSize: 16,
                  ),
                ),
                Stepper(
                  currentStep: 2,
                  controlsBuilder: (x, y) {
                    return const SizedBox();
                  },
                  steps: const [
                    Step(
                      title: Text('Invite your Friends'),
                      content: SizedBox(),
                      isActive: true,
                    ),
                    Step(
                      title: Text('They hit first recharge'),
                      content: SizedBox(),
                      isActive: true,
                    ),
                    Step(
                      title: Text('You earn 20 coins'),
                      content: SizedBox(),
                      isActive: true,
                    ),
                  ],
                ),
                h(5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Refer Code - ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        referCode,
                        style: TextStyle(
                          color: '#53438A'.toColor(),
                          fontSize: 18,
                        ),
                      ),
                      w(5),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: const Icon(Icons.copy_outlined),
                        onPressed: () {
                          FlutterClipboard.copy(referCode).then((value) {
                            Fluttertoast.showToast(msg: 'Copied to clipboard');
                          });
                        },
                      ),
                    ],
                  ),
                ),
                h(10),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: Button(
                    text: 'Refer friends now',
                    radius: 5,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    onPressed: () {
                      // todo: refer friends
                    },
                    primaryColor: primaryColor,
                  ),
                ),
                Divider(
                  color: Colors.grey.shade500,
                ),
                const Text(
                  'Refer History',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
