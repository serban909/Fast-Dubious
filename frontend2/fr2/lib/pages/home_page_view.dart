import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFF251B87),
          automaticallyImplyLeading: false,
          title: Text(
            'If you see this something is wrong MF!',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: 'Inter Tight',
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(
                context,
              ).headlineMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://www.watchmojo.com/uploads/thumbs720/WM-Film-Top10-Samuel-L-Jackson-Kills_N3L2O5-CJ1F.webp',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    'https://picsum.photos/seed/240/600',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
