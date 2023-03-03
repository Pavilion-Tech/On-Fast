import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';

import '../../../../shared/styles/colors.dart';
import '../../../../widgets/menu/contact_us/compaints.dart';
import '../../../../widgets/menu/contact_us/track_complaints.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController =  TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('contact_us')),
          Expanded(
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  indicatorColor: defaultColor,
                  indicatorPadding: EdgeInsets.zero,
                  labelStyle:const TextStyle(fontSize: 13),
                  tabs: [
                    Tab(
                      text: tr('complaints'),
                    ),
                    Tab(
                      text: tr('track_complaints'),
                    )
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        Compaints(),
                        TrackComplaints(),
                      ]
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
