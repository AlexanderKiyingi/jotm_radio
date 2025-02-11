import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jotm_radio/theme.dart'; // Ensure this is importing the correct theme file

import 'socialmedia_model.dart';
export 'socialmedia_model.dart';

class SocialmediaWidget extends StatefulWidget {
  const SocialmediaWidget({super.key});

  @override
  _SocialmediaWidgetState createState() => _SocialmediaWidgetState();
}

class _SocialmediaWidgetState extends State<SocialmediaWidget> {
  late SocialmediaModel _model;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _model = SocialmediaModel();
  }

  @override
  void dispose() {
    _disposed = true;
    _model.maybeDispose();
    super.dispose();
  }

  void safeSetState(VoidCallback fn) {
    if (!_disposed) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 50),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SafeArea(
                child: Container(
                  width: 100,
                  height: 240,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryBackgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () async {
                            await _model.launchURL(_model.instagramUrl);
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                               FaIcon(
                                FontAwesomeIcons.instagram,
                                color: AppTheme.secondaryTextColor,
                                size: 30,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
                                child: Text(
                                  'Follow us on Instagram',
                                  style: AppTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 0.5, indent: 20),
                        InkWell(
                          onTap: () async {
                            await _model.launchURL(_model.twitterUrl);
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                               FaIcon(
                                FontAwesomeIcons.squareTwitter,
                                color: AppTheme.secondaryTextColor,
                                size: 30,
                              ),
                              Padding(
                                padding:  EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
                                child: Text(
                                  'Follow us on Twitter',
                                  style: AppTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 0.5, indent: 20),
                        InkWell(
                          onTap: () async {
                            await _model.launchURL(_model.websiteUrl);
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.internetExplorer,
                                color: AppTheme.secondaryTextColor,
                                size: 30,
                              ),
                              Padding(
                                padding:  EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
                                child: Text(
                                  'Visit our website',
                                  style: AppTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'socialmedia_model.dart';
// import 'package:jotm_radio/theme.dart'; // Ensure this is importing the correct theme file
// import 'package:flutter/material.dart';
// import 'socialmedia_model.dart';

// class SocialmediaWidget extends StatefulWidget {
//   const SocialmediaWidget({super.key});

//   @override
//   State<SocialmediaWidget> createState() => _SocialmediaWidgetState();
// }

// class _SocialmediaWidgetState extends State<SocialmediaWidget> {
//   late SocialmediaModel _model;

//   @override
//   void initState() {
//     super.initState();
//     _model = SocialmediaModel();
//   }

//   @override
//   void dispose() {
//     _model.maybeDispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 50),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Expanded(
//             child: Material(
//               color: Colors.transparent,
//               elevation: 1,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: SafeArea(
//                 child: Container(
//                   width: 100,
//                   height: 240,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).secondaryHeaderColor,
//                     boxShadow: const [
//                       BoxShadow(
//                         blurRadius: 4,
//                         color: Color(0x33000000),
//                         offset: Offset(0, 2),
//                       )
//                     ],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         InkWell(
//                           onTap: () async {
//                             await _model.launchURL(_model.instagramUrl);
//                           },
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               // Icon(Icons.instagram, size: 30),
//                                FaIcon(
//                                 FontAwesomeIcons.instagram,
//                                 color:
//                                     AppTheme.secondaryTextColor,
//                                 size: 30,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
//                                 child: Text(
//                                   'Follow us on Instagram',
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(thickness: 0.5, indent: 20),
//                         InkWell(
//                           onTap: () async {
//                             await _model.launchURL(_model.twitterUrl);
//                           },
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               // Icon(Icons.twitter, size: 30),
//                               FaIcon(
//                                 FontAwesomeIcons.squareTwitter,
//                                 color:
//                                     AppTheme.secondaryTextColor,
//                                 size: 30,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
//                                 child: Text(
//                                   'Follow us on Twitter',
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(thickness: 0.5, indent: 20),
//                         InkWell(
//                           onTap: () async {
//                             await _model.launchURL(_model.websiteUrl);
//                           },
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Icon(Icons.web, size: 30),
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
//                                 child: Text(
//                                   'Visit our website',
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
