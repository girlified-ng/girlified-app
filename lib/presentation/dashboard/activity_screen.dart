import 'package:get/get.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedFilter = 'All';

  // Mock data - will be replaced with actual data from database
  final List<Map<String, dynamic>> blockedContent = [
    {
      'id': 1,
      'app': 'TikTok',
      'type': 'Violence',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'severity': 'High',
      'description': 'Violent content detected in video',
    },
    {
      'id': 2,
      'app': 'Instagram',
      'type': 'Harassment',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      'severity': 'Medium',
      'description': 'Potentially harmful comment thread',
    },
    {
      'id': 3,
      'app': 'YouTube',
      'type': 'Violence',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'severity': 'High',
      'description': 'Graphic content in video thumbnail',
    },
    {
      'id': 4,
      'app': 'TikTok',
      'type': 'Explicit Content',
      'timestamp': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      'severity': 'High',
      'description': 'Explicit content detected',
    },
    {
      'id': 5,
      'app': 'Instagram',
      'type': 'Cyberbullying',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'severity': 'Medium',
      'description': 'Cyberbullying detected in comments',
    },
  ];

  final List<Map<String, dynamic>> stats = [
    {'label': 'Today', 'count': 12, 'change': '+3'},
    {'label': 'This Week', 'count': 45, 'change': '+8'},
    {'label': 'This Month', 'count': 187, 'change': '+22'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      case 'YouTube':
        return FluentIcons.play_circle_24_filled;
      default:
        return FluentIcons.apps_24_filled;
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 35),
                    TitleText(
                      size: 16,
                      title: 'Activity',
                    ),
                    SizedBox(width: 35),
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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBlockedContentTab(),
          _buildStatisticsTab(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (int value) {
          ServiceRegistry.commonRepository.currentScreenIndex.value = value;
        },
        currentPage: ServiceRegistry.commonRepository.currentScreenIndex.value,
      ),
    );
  }

  Widget _buildBlockedContentTab() {
    return blockedContent.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: blockedContent.length,
            itemBuilder: (context, index) {
              final item = blockedContent[index];
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  // TODO: Show details
                },
                icon: const Icon(FluentIcons.info_16_regular, size: 14),
                label: const Text('Details'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.electricLilac,
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: stats.map((stat) {
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
                        stat['label'],
                        style: TextStyle(
                          color: AppColors.textTertiaryColor,
                          fontSize: 11,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat['change'],
                        style: const TextStyle(
                          color: AppColors.tealColor,
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
          _buildContentTypeCard('Violence', 45,
              FluentIcons.shield_error_24_filled, AppColors.dangerPrimaryColor),
          _buildContentTypeCard('Harassment', 28,
              FluentIcons.person_prohibited_24_filled, AppColors.orangeColor),
          _buildContentTypeCard('Explicit Content', 15,
              FluentIcons.eye_off_24_filled, AppColors.redColor),
          _buildContentTypeCard('Cyberbullying', 12,
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
          _buildAppStatCard('TikTok', 52, 68),
          _buildAppStatCard('Instagram', 31, 32),
          _buildAppStatCard('YouTube', 17, 15),
        ],
      ),
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
    final percentage = (blocked / (blocked + viewed) * 100).toInt();
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
            'Great! Girlified hasn\'t detected any\nharmful content yet.',
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
