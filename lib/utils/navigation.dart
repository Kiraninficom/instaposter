import 'package:click/subscription_page.dart';
import 'package:click/utils/styles.dart';
import 'package:click/widgets/walletpage.dart';
import 'package:flutter/material.dart';

toScreen(BuildContext context, page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

replaceScreen(BuildContext context, page) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

backscreen(BuildContext context) {
  Navigator.pop(context);
}

nosubscriptiondialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    backscreen(context);
                  },
                  child: Icon(Icons.close),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "No Subscription Plan Found",
                textScaleFactor: 1.5,
                textAlign: TextAlign.center,
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: appBarColor,
              onPressed: () {
                toScreen(context, Subscriptionpage());
              },
              child: Text(
                "Buy Subscription",
                style: TextStyle(color: whitecolor),
              ),
            )
          ],
        ),
      );
    },
  );
}

noamountbottomsheet(BuildContext context, var name) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    context: context,
    builder: (context) {
      return Container(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                    onTap: () {
                      backscreen(context);
                    },
                    child: Icon(Icons.close)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'You have Insufficient amount to $name',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
            ),
            MaterialButton(
              color: appBarColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                toScreen(context, Walletpage());
              },
              child: Text(
                "Add Amount",
                style: TextStyle(color: whitecolor),
              ),
            )
          ],
        ),
      );
    },
  );
}

dialog(BuildContext context, var text) {
  return showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 4), () {
          backscreen(context);
        });
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
      });
}

notificationdialog(BuildContext context, {var text, var onpress}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      backscreen(context);
                    },
                    icon: Icon(Icons.close)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: onpress,
                child: Text(
                  "Next",
                  style: TextStyle(color: whitecolor),
                ),
              )
            ],
          ),
        );
      });
}
