import 'dart:io';

import 'package:click/helpers/layout.dart';
import 'package:flutter/material.dart';

// ignore: prefer_typing_uninitialized_variables
// var uservalue;
var buisnessvalue = [];
var festivalprofilevalue = [];
var cscvalue = [];
var subscriptiondetail;
var weburl = 'https://inficom.instapost365.com';
var baseurl = "http://inficom.instapost365.com/api/api/";
var premiumtemplate = "${baseurl}premium_list";
var register = "${baseurl}user_signup";
var loginapi = "${baseurl}user_signin";
var cscservices = "${baseurl}cscservices_list";
var cscsubservices = "${baseurl}cscsubservices_list";
var cscimagelist = "${baseurl}cscsubservicesimages_list";
var cscvideolist = "${baseurl}cscsubservicesvideos_list";
var getlogo = "${baseurl}logoservices_list";
var getrequestedlogo = "${baseurl}all_logo_request";
var festivalposterlist = "${baseurl}festivalposter_list";
var festivalvideolist = "${baseurl}festivalvideos_list";
var quotescategorylist = "${baseurl}quotes_category_list";
var quoteslist = "${baseurl}quotes_list";
var stickerlist = "${baseurl}stickers_list";
var schemeservice = "${baseurl}schemeservices_list";
var schemesubservice = "${baseurl}schemessubservices_list";
var schemeimagelist = "${baseurl}schemesposter_list";
var schemevideolist = "${baseurl}schemevideos_list";
var buisnessservice = "${baseurl}businessservices_list";
var buisnessubservice = "${baseurl}businesssubservices_list";
var buisnessimagelist = "${baseurl}businesssubservicesimages_list";
var buisnessvideolist = "${baseurl}businessvideos_list";
var jobservice = "${baseurl}jobsposter_list";
var jobsubservice = "${baseurl}jobssubservices_list";
var jobimagelist = "${baseurl}jobssubservicesimages_list";
var greetingserviceurl = "${baseurl}greeting_category";
var greetingsubserviceurl = "${baseurl}greeting_subcategory";
var greetingimagelisturl = "${baseurl}greeting_posters";
var facebooklist = "${baseurl}facebookposter_list";
var bannerlist = "${baseurl}bannerslider_list";
var userprofile = "${baseurl}user_profile";
var cscprofile = "${baseurl}csc_profile";
var buisnessprofile = "${baseurl}business_profile";
var festivalprofile = "${baseurl}festival_profile";
var usersubscription = "${baseurl}subscription_details";
var popuplisturl = "${baseurl}popup_list";
var downloadandsharecounter = "${baseurl}action_counter";
var wallethistoryurl = "${baseurl}wallet_history";
var notification = "${baseurl}notificationList";
var downloadandsharevalue = "${baseurl}counterShareDownloads";
var balanceurl = "${baseurl}availableBalance";
var razorpaykeyurl = "${baseurl}razorpay_secret";
var policyurl = "${baseurl}pages";
var currentposter = "${baseurl}currentPosterCategory";

SizedBox h(double? height) {
  return SizedBox(height: AppLayout.getHeight(height!));
}

SizedBox w(double? width) {
  return SizedBox(width: AppLayout.getHeight(width!));
}

String url =
    'https://images.unsplash.com/photo-1599842057874-37393e9342df?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGdpcmx8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
DateTime todaydate = DateTime.now();
var currentposterimages;
var razorpaykeyvalue;
var privacypolicydata;
var termandservicedata;
bool alldataget = false;
var selectedvalue;
var userdata;
Map<String, dynamic> downloaddata = {};
Map<String, dynamic> balancedata = {};
String token = "";
List poster = [];
List wallethistory = [];
// var todayposter;
// var todaysubservice;
// var todayimage;
List notificationlist = [];
List popuplist = [];
List todaysfestival = [];
List todaysjob = [];
List todayscheme = [];
List todaysbuisness = [];
List tommorowfestival = [];
List festivalposter = [];
List festivalvideo = [];
List onlineserviceposter = [];
List onlinesubservice = [];
List onlineimage = [];
List buisnesscategory = [];
List buisnesssubservice = [];
List buisnessimage = [];
List greetingcategory = [];
List greetingssubservice = [];
List greetingimage = [];
List designlogo = [];
List facebookcover = [];
List jobcategory = [];
List jobsubservicelist = [];
List jobimage = [];
List schemecategory = [];
List schemesubservicelist = [];
List schemeimage = [];
List schemevideo = [];
List subscription = [];
List cscvideo = [];
List premiumtemplatelist = [];
List requestedpremiumtemplatelist = [];
List requestedlogo = [];
List quotescategory = [];
List quotesposterimages = [];

// var facebookimage;
// var designsubservice;
// var designimage;
// var facebooksubservice;

var fontlist = [
  {
    "fontname": "sample",
    "font": "EkMukta-Regular",
  },
  {
    "fontname": "sample",
    "font": " Mukta-Semibold",
  },
  {
    "fontname": "sample",
    "font": "EkMukta-Bold",
  },
  {
    "fontname": "sample",
    "font": "LaBelleAurore",
  },
  {
    "fontname": "sample",
    "font": "Poppins-Light",
  },
  {
    "fontname": "sample",
    "font": "Poppins-Regular",
  },
  {
    "fontname": "sample",
    "font": "Poppins-Bold",
  },
  {
    "fontname": "sample",
    "font": "Anek-Light",
  },
  {
    "fontname": "sample",
    "font": "Anek-Regular",
  },
  {
    "fontname": "sample",
    "font": "Anek-SemiBold",
  },
  {
    "fontname": "sample",
    "font": "Gotu-Regular",
  },
  {
    "fontname": "sample",
    "font": "Hind-Bold",
  },
  {
    "fontname": "sample",
    "font": "Hind-Regular",
  },
  {
    "fontname": "sample",
    "font": "Khand-Regular",
  },
  {
    "fontname": "sample",
    "font": "Khand-SemiBold",
  },
  {
    "fontname": "sample",
    "font": "NotoSerif-Regular",
  },
  {
    "fontname": "sample",
    "font": "NotoSerif-SemiBold",
  },
  {
    "fontname": "sample",
    "font": "TiroDevanagariMarathi-Regular",
  },
];

List<File> path1 = [];
List<File> path2 = [];
