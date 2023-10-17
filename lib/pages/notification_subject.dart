import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NotificationSubjectPage extends StatefulWidget {
  var subject;
  var title;
  NotificationSubjectPage({super.key, this.subject, this.title});

  @override
  State<NotificationSubjectPage> createState() =>
      _NotificationSubjectPageState();
}

class _NotificationSubjectPageState extends State<NotificationSubjectPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: HtmlWidget(widget.subject),
        ),
      ),
    );
  }
}
