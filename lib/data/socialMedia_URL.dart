import 'package:url_launcher/url_launcher.dart';

launchURL(String socialMedia) async {
  const facebookURL = 'https://www.facebook.com/profile.php?id=100010760566739';
  const instagramURL = 'https://www.instagram.com/amaan.0605';
  const twitterURL = 'https://twitter.com/nawab_amaan1';
  const youtubeURL = 'https://www.youtube.com/';
  if (socialMedia == 'instagram') {
    if (await canLaunch(instagramURL)) {
      await launch(instagramURL);
    } else {
      throw 'Could not launch $instagramURL';
    }
  } else if (socialMedia == 'facebook') {
    if (await canLaunch(facebookURL)) {
      await launch(facebookURL);
    } else {
      throw 'Could not launch $facebookURL';
    }
  } else if (socialMedia == 'twitter') {
    if (await canLaunch(twitterURL)) {
      await launch(twitterURL);
    } else {
      throw 'Could not launch $twitterURL';
    }
  } else if (socialMedia == 'youtube') {
    if (await canLaunch(youtubeURL)) {
      await launch(youtubeURL);
    } else {
      throw 'Could not launch $youtubeURL';
    }
  }
}
