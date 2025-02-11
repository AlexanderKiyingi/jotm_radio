import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialmediaModel extends ChangeNotifier {
  // Store links or any other data you want to manage in the model
  final String instagramUrl =
      'https://www.instagram.com/houseofjazzea/?igshid=MjEwN2IyYWYwYw%3D%3D';
  final String twitterUrl =
      'https://x.com/HouseOfJazzEA?t=Uac8ajYr6Nzk8mZuJADemQ&s=09&mx=2';
  final String websiteUrl = 'https://jazz-on-the-move.mixlr.com/';

  // Manage the launching of URLs
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Add any state or logic updates if needed
  void onUpdate() {
    notifyListeners();
  }

  // Disposing method to clean up resources
  void maybeDispose() {
    // Any necessary cleanup logic goes here
  }
}

// ElevatedButton.icon(
                                //  onPressed:() async {                              
                                //      showModalBottomSheet<void>(
                                //       context: context,
                                //       builder: (BuildContext context) {
                                //         return SizedBox(
                                //           height: 250,
                                //           child: Padding(
                                //             padding: MediaQuery.viewInsetsOf(context),
                                //             child: Padding(
                                //               padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 50),
                                //               child: Row(
                                //                 mainAxisSize: MainAxisSize.max,
                                //                 children: [
                                //                   Expanded(
                                //                     child: Material(
                                //                       color: Colors.transparent,
                                //                       elevation: 1,
                                //                       shape: RoundedRectangleBorder(
                                //                         borderRadius: BorderRadius.circular(16),
                                //                       ),
                                //                       child: SafeArea(
                                //                         child: Container(
                                //                           width: 100,
                                //                           height: 240,
                                //                           decoration: BoxDecoration(
                                //                             color: AppTheme.secondaryBackgroundColor,
                                //                             boxShadow: const [
                                //                               BoxShadow(
                                //                                 blurRadius: 4,
                                //                                 color: Color(0x33000000),
                                //                                 offset: Offset(0, 2),
                                //                               )
                                //                             ],
                                //                             borderRadius: BorderRadius.circular(16),
                                //                           ),
                                //                           child: Padding(
                                //                             padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                                //                             child: Column(
                                //                               mainAxisSize: MainAxisSize.max,
                                //                               children: [
                                //                                 InkWell(
                                //                                   onTap: () async {
                                //                                      _launchURL(instagramUrl);
                                //                                   },
                                //                                   child: const Row(
                                //                                     mainAxisSize: MainAxisSize.max,
                                //                                     children: [
                                //                                       FaIcon(
                                //                                         FontAwesomeIcons.instagram,
                                //                                         color: AppTheme.secondaryTextColor,
                                //                                         size: 30,
                                //                                       ),
                                //                                       Padding(
                                //                                         padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
                                //                                         child: Text(
                                //                                           'Follow us on Instagram',
                                //                                           style: AppTheme.bodyMedium,
                                //                                         ),
                                //                                       ),
                                //                                     ],
                                //                                   ),
                                //                                 ),
                                //                                 const Divider(thickness: 0.5, indent: 20),
                                //                                 InkWell(
                                //                                   onTap: () async {
                                //                                   _launchURL(twitterUrl);
                                //                                   },
                                //                                   child: const Row(
                                //                                     mainAxisSize: MainAxisSize.max,
                                //                                     children: [
                                //                                       FaIcon(
                                //                                         FontAwesomeIcons.squareTwitter,
                                //                                         color: AppTheme.secondaryTextColor,
                                //                                         size: 30,
                                //                                       ),
                                //                                       Padding(
                                //                                         padding:  EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
                                //                                         child: Text(
                                //                                           'Follow us on Twitter',
                                //                                           style: AppTheme.bodyMedium,
                                //                                         ),
                                //                                       ),
                                //                                     ],
                                //                                   ),
                                //                                 ),
                                //                                 const Divider(thickness: 0.5, indent: 20),
                                //                                 InkWell(
                                //                                   onTap: () async {
                                //                                    _launchURL(websiteUrl);
                                //                                   },
                                //                                   child: const Row(
                                //                                     mainAxisSize: MainAxisSize.max,
                                //                                     children: [
                                //                                       FaIcon(
                                //                                         FontAwesomeIcons.internetExplorer,
                                //                                         color: AppTheme.secondaryTextColor,
                                //                                         size: 30,
                                //                                       ),
                                //                                       Padding(
                                //                                         padding:  EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
                                //                                         child: Text(
                                //                                           'Visit our website',
                                //                                           style: AppTheme.bodyMedium,
                                //                                         ),
                                //                                       ),
                                //                                     ],
                                //                                   ),
                                //                                 ),
                                //                                 ElevatedButton(
                                //                                   child: const Text('CLose BottomSHeet'),
                                //                                   onPressed: ()=> Navigator.pop(context),
                                //                                   )
                                //                               ],
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     );
                                //     print('BottomSheet shown');
                                //     context.read<AppState>().toggleRadioLive();
                                  // },                                                          
                          
                              //   icon: const FaIcon(
                              //     FontAwesomeIcons.userPlus,
                              //     size: 16.0,
                              //   ),
                              //   label: Text(
                              //     'Follow',
                              //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              //       fontFamily: 'Readex Pro',
                              //       color: Colors.white,
                              //       letterSpacing: 0.0,
                              //     ),
                              //   ),
                              //   style: ButtonStyle(
                              //     backgroundColor: WidgetStateProperty.all(Colors.transparent),
                              //     padding: WidgetStateProperty.all(const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0)),
                              //     elevation: WidgetStateProperty.all(3.0),
                              //     shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20.0),
                              //       side: const BorderSide(
                              //         color: AppTheme.secondaryBackgroundColor,
                              //         width: 1.0,
                              //       ),
                              //     )),
                              //   ),
                              // )