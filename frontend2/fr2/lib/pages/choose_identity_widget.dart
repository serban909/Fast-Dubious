import 'package:flutter/material.dart';

import 'display_passport_widget.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import 'enter_indetity_data_widget.dart' show EnterIndetityDataWidget;
import '../services/auth_api.dart';
import '../services/profile_api.dart';

class ChooseIdentityWidget extends StatefulWidget {
  const ChooseIdentityWidget({super.key});

  static String routeName = 'ChooseIdentity';
  static String routePath = '/chooseIdentity';

  @override
  State<ChooseIdentityWidget> createState() => _ChooseIdentityWidgetState();
}

class _ChooseIdentityWidgetState extends State<ChooseIdentityWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIdentityIndex = -1;
  List<Map<String, dynamic>> _identities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

  Future<void> _fetchProfiles() async {
    final user = AuthApi.currentUser;
    if (user != null && user['id'] != null) {
      final profiles = await ProfileApi.getMyProfiles(userId: user['id']);
      if (mounted) {
        setState(() {
          _identities = profiles;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
         setState(() => _isLoading = false);
      }
    }
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 30,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Identity',
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            font: 'Inter Tight',
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .displaySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .displaySmall
                                .fontStyle,
                          ),
                    ),
                    const Divider(
                      height: 24,
                      thickness: 1,
                      color: Color(0xFFE0E3E7),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: Text(
                        'Team Members',
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                              font: 'Inter Tight',
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    _isLoading 
                    ? const Center(child: CircularProgressIndicator())
                    : _identities.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("No identities found. Create one below."),
                        )
                      : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _identities.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final identity = _identities[index];
                        final isSelected = _selectedIdentityIndex == index;
                        final name = "${identity['first_name']} ${identity['last_name']}";
                        final subtitle = identity['id_code'] ?? 'No Code';
                        final photoUrl = identity['profile_photo'];
                        final badgeUrl = identity['generated_badge'];

                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _selectedIdentityIndex = index;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? FlutterFlowTheme.of(context)
                                      .primary
                                      .withValues(alpha: 0.08)
                                  : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x32171717),
                                  offset: Offset(0.0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (badgeUrl != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        badgeUrl.startsWith('http') 
                                            ? badgeUrl 
                                            : "http://localhost:8000$badgeUrl",
                                        width: 80,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => Container(color: Colors.grey, width: 80, height: 50, child: const Icon(Icons.badge)),
                                      ),
                                    )
                                  else 
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: photoUrl != null 
                                        ? Image.network(
                                            photoUrl.startsWith('http') 
                                              ? photoUrl 
                                              : "http://localhost:8000$photoUrl",
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                            errorBuilder: (c, e, s) => Container(color: Colors.grey, width: 40, height: 40, child: const Icon(Icons.person)),
                                          )
                                        : Container(
                                            width: 40, 
                                            height: 40, 
                                            color: Colors.grey.shade300, 
                                            child: const Icon(Icons.person),
                                          ),
                                    ),
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            0,
                                            16,
                                            0,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                      font: 'Inter Tight',
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  4,
                                                  0,
                                                  0,
                                                ),
                                                child: Text(
                                                  subtitle,
                                                  style: FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: 'Inter Tight',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                          onPressed: () async {
                                            final confirm = await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Delete Identity?'),
                                                content: const Text('Are you sure you want to remove this identity? This cannot be undone.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, true),
                                                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                                  ),
                                                ],
                                              ),
                                            );
                                            
                                            if (confirm == true) {
                                              final success = await ProfileApi.deleteProfile(profileId: identity['id']);
                                              if (success) {
                                                _fetchProfiles();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Identity removed')),
                                                );
                                              } else {
                                                 ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Failed to delete identity')),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                        if (isSelected)
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: FlutterFlowTheme.of(context).primary,
                                                size: 24,
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (_selectedIdentityIndex == -1) {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select an identity first.')),
                    );
                    return;
                  }
                  final identity = _identities[_selectedIdentityIndex];
                  final photoUrl = identity['profile_photo'];
                  final badgeUrl = identity['generated_badge'];
                  
                  final urlToUse = badgeUrl ?? photoUrl;

                  if (urlToUse == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No photo or badge for this identity.')),
                    );
                    return;
                  }

                  String fullUrl = urlToUse;
                  if (!urlToUse.startsWith('http')) {
                      // Adjust base URL for your environment
                      final baseUrl = 'http://localhost:8000'; 
                      // For Android emulator use 'http://10.0.2.2:8000'
                      fullUrl = '$baseUrl$urlToUse';
                  }

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPassportWidget(
                        photoUrl: fullUrl,
                      ),
                    ),
                  );
                },
                text: 'Display Selected Identity',
                options: FFButtonOptions(
                  width: 270,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: 'Inter Tight',
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontStyle,
                      ),
                  elevation: 3,
                  borderSide: const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (_selectedIdentityIndex == -1) {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select an identity first.')),
                    );
                    return;
                  }
                  final identity = _identities[_selectedIdentityIndex];
                  
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnterIndetityDataWidget(
                        identityToEdit: identity,
                      ),
                    ),
                  );
                  // Refresh list on return
                  _fetchProfiles();
                },
                text: 'Edit Selected Identity',
                options: FFButtonOptions(
                  width: 270,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: 'Inter Tight',
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontStyle,
                      ),
                  elevation: 3,
                  borderSide: const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  await Navigator.pushNamed(
                    context,
                    EnterIndetityDataWidget.routePath,
                  );
                  // Refresh the list after returning from the creation page
                  _fetchProfiles();
                },
                text: 'Make  a new Identity',
                options: FFButtonOptions(
                  width: 270,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: 'Inter Tight',
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontStyle,
                      ),
                  elevation: 3,
                  borderSide: const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
