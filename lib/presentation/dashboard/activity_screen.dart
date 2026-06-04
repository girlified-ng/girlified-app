import 'package:get/get.dart';
import 'package:girlified/components/skeletons/insecure_dashboard_content.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';
import 'package:girlified/core/utilities/protection_metrics.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    ProtectionMetricsHelper.seedMockProtectionDurations();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getRelativeTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(timestamp);
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'High':
        return AppColors.dangerPrimaryColor;
      case 'Medium':
        return AppColors.orangeColor;
      case 'Low':
        return AppColors.greenColor;
      default:
        return AppColors.grayColor;
    }
  }

  IconData _getAppIcon(String app) {
    switch (app) {
      case 'TikTok':
        return FluentIcons.video_clip_24_filled;
      case 'Instagram':
        return FluentIcons.camera_24_filled;
      case 'Snapchat':
        return FluentIcons.chat_24_filled;
      case 'X/Twitter':
      case 'Twitter':
      case 'X':
        return FluentIcons.mention_24_filled;
      case 'YouTube':
        return FluentIcons.play_circle_24_filled;
      default:
        return FluentIcons.apps_24_filled;
    }
  }

  List<Map<String, dynamic>> getFilteredBlockedContent() {
    final accountInfo = ServiceRegistry.userRepository.accountInfo.value;
    final List<String> activeApps = [];

    if (accountInfo.instagramHandle.isNotEmpty) {
      activeApps.add('Instagram');
    }
    if (accountInfo.tiktokHandle.isNotEmpty) {
      activeApps.add('TikTok');
    }
    if (accountInfo.snapchatHandle.isNotEmpty) {
      activeApps.add('Snapchat');
    }
    if (accountInfo.xHandle.isNotEmpty) {
      activeApps.add('X/Twitter');
      activeApps.add('Twitter');
      activeApps.add('X');
    }

    final List<Map<String, dynamic>> baseItems = [
      {
        'id': 1,
        'app': 'TikTok',
        'type': 'Violence',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'description': 'Violent content detected in video',
      },
      {
        'id': 2,
        'app': 'Instagram',
        'type': 'Harassment',
        'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
        'description': 'Potentially harmful comment thread',
      },
      {
        'id': 3,
        'app': 'X/Twitter',
        'type': 'Cyberbullying',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
        'description': 'Targeted harassment in replies',
      },
      {
        'id': 4,
        'app': 'TikTok',
        'type': 'Explicit Content',
        'timestamp': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        'description': 'Explicit content detected',
      },
      {
        'id': 5,
        'app': 'Instagram',
        'type': 'Cyberbullying',
        'timestamp': DateTime.now().subtract(const Duration(days: 2)),
        'description': 'Cyberbullying detected in comments',
      },
      {
        'id': 6,
        'app': 'Snapchat',
        'type': 'Explicit Content',
        'timestamp': DateTime.now().subtract(const Duration(days: 3)),
        'description': 'Inappropriate snap detected',
      },
      {
        'id': 7,
        'app': 'Snapchat',
        'type': 'Harassment',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
        'description': 'Bullying in direct messages',
      },
      {
        'id': 8,
        'app': 'X/Twitter',
        'type': 'Violence',
        'timestamp': DateTime.now().subtract(const Duration(days: 4)),
        'description': 'Graphic threat blocked',
      },
    ];

    // Filter by handles
    final filtered =
        baseItems.where((item) => activeApps.contains(item['app'])).toList();

    // Dynamically calculate severity based on protection daily duration for the item's day
    for (var item in filtered) {
      final dt = item['timestamp'] as DateTime;
      final seconds = ProtectionMetricsHelper.getProtectionDurationForDay(dt);
      final hours = seconds / 3600.0;

      if (hours < 2.0) {
        item['severity'] = 'High';
      } else if (hours < 6.0) {
        item['severity'] = 'Medium';
      } else {
        item['severity'] = 'Low';
      }
    }

    // Apply selectedFilter
    if (selectedFilter == 'All') {
      return filtered;
    } else if (selectedFilter == 'Today') {
      final now = DateTime.now();
      return filtered.where((item) {
        final t = item['timestamp'] as DateTime;
        return t.year == now.year && t.month == now.month && t.day == now.day;
      }).toList();
    } else if (selectedFilter == 'This Week') {
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      return filtered
          .where((item) => (item['timestamp'] as DateTime).isAfter(weekAgo))
          .toList();
    } else if (selectedFilter == 'This Month') {
      final monthAgo = DateTime.now().subtract(const Duration(days: 30));
      return filtered
          .where((item) => (item['timestamp'] as DateTime).isAfter(monthAgo))
          .toList();
    } else {
      // Filter by type
      return filtered.where((item) => item['type'] == selectedFilter).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(
          child: Container(
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 48),
                    TitleText(
                      size: 16,
                      title: 'Activity',
                    ),
                    SizedBox(width: 48),
                    // IconButton(
                    //   icon: const Icon(
                    //     FluentIcons.filter_24_regular,
                    //     color: AppColors.blackColor,
                    //   ),
                    //   onPressed: _showFilterSheet,
                    // ),
                  ],
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.electricLilac,
                  unselectedLabelColor: AppColors.textTertiaryColor,
                  indicatorColor: AppColors.electricLilac,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro',
                  ),
                  tabs: const [
                    Tab(text: 'Blocked Content'),
                    Tab(text: 'Statistics'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        // Trigger Obx reactivity on accountInfo changes
        final _ = ServiceRegistry.userRepository.accountInfo.value;

        if (ServiceRegistry.localStorage
                .read(LocalStorageSecrets.authenticationMethod) ==
            'GUEST') {
          return SizedBox(
            height: Get.height * 0.7,
            child: const Center(
              child: InsecureDashboardContent(),
            ),
          );
        }
        return TabBarView(
          controller: _tabController,
          children: [
            _buildBlockedContentTab(),
            _buildStatisticsTab(),
          ],
        );
      }),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (int value) {
          ServiceRegistry.commonRepository.currentScreenIndex.value = value;
        },
        currentPage: ServiceRegistry.commonRepository.currentScreenIndex.value,
      ),
    );
  }

  Widget _buildBlockedContentTab() {
    final filteredList = getFilteredBlockedContent();
    return filteredList.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final item = filteredList[index];
              return _buildBlockedContentCard(item);
            },
          );
  }

  Widget _buildBlockedContentCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getSeverityColor(item['severity']).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // App Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.electricLilac.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _getAppIcon(item['app']),
                  color: AppColors.electricLilac,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item['app'],
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getSeverityColor(item['severity'])
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item['severity'],
                            style: TextStyle(
                              color: _getSeverityColor(item['severity']),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getRelativeTime(item['timestamp']),
                      style: TextStyle(
                        color: AppColors.textTertiaryColor,
                        fontSize: 13,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  FluentIcons.warning_16_filled,
                  color: _getSeverityColor(item['severity']),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['type'],
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['description'],
                        style: TextStyle(
                          color: AppColors.textTertiaryColor,
                          fontSize: 12,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 12),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton.icon(
          //       onPressed: () {
          //         // TODO: Show details
          //       },
          //       icon: const Icon(FluentIcons.info_16_regular, size: 14),
          //       label: const Text('Details'),
          //       style: TextButton.styleFrom(
          //         foregroundColor: AppColors.electricLilac,
          //         textStyle: const TextStyle(
          //           fontSize: 13,
          //           fontFamily: 'SF Pro',
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    final filteredContent = getFilteredBlockedContent();
    final now = DateTime.now();

    // Today count
    final todayCount = filteredContent.where((item) {
      final t = item['timestamp'] as DateTime;
      return t.year == now.year && t.month == now.month && t.day == now.day;
    }).length;

    // Yesterday count
    final yesterdayStart = DateTime(now.year, now.month, now.day - 1);
    final yesterdayEnd = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final yesterdayCount = filteredContent.where((item) {
      final t = item['timestamp'] as DateTime;
      return t.isAfter(yesterdayStart) && t.isBefore(yesterdayEnd);
    }).length;
    final todayDiff = todayCount - yesterdayCount;
    final todayChange = todayDiff >= 0 ? '+$todayDiff' : '$todayDiff';

    // Weekly count
    final weekAgo = now.subtract(const Duration(days: 7));
    final weekCount = filteredContent
        .where((item) => (item['timestamp'] as DateTime).isAfter(weekAgo))
        .length;

    final prevWeekStart = now.subtract(const Duration(days: 14));
    final prevWeekEnd = now.subtract(const Duration(days: 7));
    final prevWeekCount = filteredContent.where((item) {
      final t = item['timestamp'] as DateTime;
      return t.isAfter(prevWeekStart) && t.isBefore(prevWeekEnd);
    }).length;
    final weekDiff = weekCount - prevWeekCount;
    final weekChange = weekDiff >= 0 ? '+$weekDiff' : '$weekDiff';

    // Monthly count
    final monthAgo = now.subtract(const Duration(days: 30));
    final monthCount = filteredContent
        .where((item) => (item['timestamp'] as DateTime).isAfter(monthAgo))
        .length;

    final prevMonthStart = now.subtract(const Duration(days: 60));
    final prevMonthEnd = now.subtract(const Duration(days: 30));
    final prevMonthCount = filteredContent.where((item) {
      final t = item['timestamp'] as DateTime;
      return t.isAfter(prevMonthStart) && t.isBefore(prevMonthEnd);
    }).length;
    final monthDiff = monthCount - prevMonthCount;
    final monthChange = monthDiff >= 0 ? '+$monthDiff' : '$monthDiff';

    final dynamicStats = [
      {'label': 'Today', 'count': todayCount, 'change': todayChange},
      {'label': 'This Week', 'count': weekCount, 'change': weekChange},
      {'label': 'This Month', 'count': monthCount, 'change': monthChange},
    ];

    final violenceCount =
        filteredContent.where((item) => item['type'] == 'Violence').length;
    final harassmentCount =
        filteredContent.where((item) => item['type'] == 'Harassment').length;
    final explicitCount = filteredContent
        .where((item) => item['type'] == 'Explicit Content')
        .length;
    final cyberbullyingCount =
        filteredContent.where((item) => item['type'] == 'Cyberbullying').length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: dynamicStats.map((stat) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderSecondaryColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stat['count'].toString(),
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat['label'] as String,
                        style: TextStyle(
                          color: AppColors.textTertiaryColor,
                          fontSize: 11,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat['change'] as String,
                        style: TextStyle(
                          color: (stat['change'] as String).startsWith('-')
                              ? AppColors.dangerPrimaryColor
                              : AppColors.tealColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Daily Protection Coverage section
          _buildProtectionCoverageSection(),
          const SizedBox(height: 24),

          // Content Type Breakdown
          const Text(
            'Content Types Blocked',
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF Pro',
            ),
          ),
          const SizedBox(height: 16),
          _buildContentTypeCard('Violence', violenceCount,
              FluentIcons.shield_error_24_filled, AppColors.dangerPrimaryColor),
          _buildContentTypeCard('Harassment', harassmentCount,
              FluentIcons.person_prohibited_24_filled, AppColors.orangeColor),
          _buildContentTypeCard('Explicit Content', explicitCount,
              FluentIcons.eye_off_24_filled, AppColors.redColor),
          _buildContentTypeCard('Cyberbullying', cyberbullyingCount,
              FluentIcons.chat_warning_24_filled, AppColors.adBannerColor),
          const SizedBox(height: 24),

          // App Breakdown
          const Text(
            'Protection by App',
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF Pro',
            ),
          ),
          const SizedBox(height: 16),
          _buildAppBreakdownSection(filteredContent),
        ],
      ),
    );
  }

  Widget _buildProtectionCoverageSection() {
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Protection Coverage',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'SF Pro',
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderSecondaryColor),
          ),
          child: Column(
            children: List.generate(7, (index) {
              final day = now.subtract(Duration(days: index));
              final seconds =
                  ProtectionMetricsHelper.getProtectionDurationForDay(day);
              final hours = seconds / 3600.0;
              final percent = (hours / 24.0).clamp(0.0, 1.0);

              String dayLabel = index == 0
                  ? 'Today'
                  : index == 1
                      ? 'Yesterday'
                      : DateFormat('EEEE').format(day);

              return Padding(
                padding: EdgeInsets.only(bottom: index == 6 ? 0.0 : 12.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        dayLabel,
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percent,
                          backgroundColor:
                              AppColors.grayColor.withOpacity(0.15),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            hours >= 6.0
                                ? AppColors.greenColor
                                : hours >= 2.0
                                    ? AppColors.orangeColor
                                    : AppColors.dangerPrimaryColor,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${hours.toStringAsFixed(1)}h',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBreakdownSection(List<Map<String, dynamic>> filteredContent) {
    final accountInfo = ServiceRegistry.userRepository.accountInfo.value;
    final List<Widget> cards = [];

    if (accountInfo.tiktokHandle.isNotEmpty) {
      int blocked =
          filteredContent.where((item) => item['app'] == 'TikTok').length;
      cards.add(_buildAppStatCard('TikTok', blocked, blocked * 2 + 15));
    }
    if (accountInfo.instagramHandle.isNotEmpty) {
      int blocked =
          filteredContent.where((item) => item['app'] == 'Instagram').length;
      cards.add(_buildAppStatCard('Instagram', blocked, blocked * 3 + 12));
    }
    if (accountInfo.snapchatHandle.isNotEmpty) {
      int blocked =
          filteredContent.where((item) => item['app'] == 'Snapchat').length;
      cards.add(_buildAppStatCard('Snapchat', blocked, blocked * 2 + 8));
    }
    if (accountInfo.xHandle.isNotEmpty) {
      int blocked =
          filteredContent.where((item) => item['app'] == 'X/Twitter').length;
      cards.add(_buildAppStatCard('X/Twitter', blocked, blocked * 4 + 20));
    }

    if (cards.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'No social accounts protected yet. Add them in Protection settings.',
          style: TextStyle(
            color: AppColors.textTertiaryColor,
            fontSize: 14,
            fontFamily: 'SF Pro',
          ),
        ),
      );
    }

    return Column(
      children: cards,
    );
  }

  Widget _buildContentTypeCard(
      String type, int count, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSecondaryColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              type,
              style: const TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'SF Pro',
              ),
            ),
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppStatCard(String appName, int blocked, int viewed) {
    final percentage = viewed == 0 && blocked == 0
        ? 0
        : (blocked / (blocked + viewed) * 100).toInt();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSecondaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appName,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SF Pro',
                ),
              ),
              Text(
                '$blocked blocked',
                style: const TextStyle(
                  color: AppColors.dangerPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SF Pro',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: AppColors.grayColor.withOpacity(0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.electricLilac),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$percentage% of content flagged',
            style: TextStyle(
              color: AppColors.textTertiaryColor,
              fontSize: 12,
              fontFamily: 'SF Pro',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FluentIcons.shield_checkmark_48_filled,
            size: 80,
            color: AppColors.electricLilac.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Blocked Content',
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Great! SaifeAI hasn\'t detected any\nharmful content yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textTertiaryColor,
              fontSize: 14,
              fontFamily: 'SF Pro',
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter by',
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'SF Pro',
              ),
            ),
            const SizedBox(height: 20),
            _buildFilterOption('All'),
            _buildFilterOption('Today'),
            _buildFilterOption('This Week'),
            _buildFilterOption('This Month'),
            const SizedBox(height: 20),
            const Text(
              'Content Type',
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'SF Pro',
              ),
            ),
            const SizedBox(height: 12),
            _buildFilterOption('Violence'),
            _buildFilterOption('Harassment'),
            _buildFilterOption('Explicit Content'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String option) {
    final isSelected = selectedFilter == option;
    return ListTile(
      title: Text(
        option,
        style: TextStyle(
          color: isSelected ? AppColors.electricLilac : AppColors.blackColor,
          fontSize: 15,
          fontFamily: 'SF Pro',
        ),
      ),
      trailing: isSelected
          ? const Icon(FluentIcons.checkmark_16_filled,
              color: AppColors.electricLilac)
          : null,
      onTap: () {
        setState(() {
          selectedFilter = option;
        });
        Get.back();
      },
    );
  }
}
