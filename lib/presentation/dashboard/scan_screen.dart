import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:girlified/components/appbar/default_appbar.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    // Request camera permission
    final status = await Permission.camera.request();
    if (status.isDenied) {
      if (mounted && context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Camera Access Required'),
            content: const Text(
                'We need camera access to scan test strips. Please grant camera permission to continue.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      }
      return;
    }

    // Get available cameras
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      if (mounted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No cameras available on this device'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Initialize controller with the first back camera
    final camera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller?.value.isInitialized ?? false) {
      try {
        final newFlashMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
        await _controller!.setFlashMode(newFlashMode);
        setState(() {
          _isFlashOn = !_isFlashOn;
        });
      } catch (e) {
        debugPrint('Flash toggle error: $e');
      }
    }
  }

  Future<void> _takePicture() async {
    if (_controller?.value.isInitialized ?? false) {
      try {
        final image = await _controller!.takePicture();
        // TODO: Handle the captured image
        debugPrint('Picture taken: ${image.path}');
      } catch (e) {
        debugPrint('Picture capture error: $e');
      }
    }
  }

  Future<void> _switchCamera() async {
    if (_controller?.value.isInitialized ?? false) {
      final cameras = await availableCameras();
      final currentCamera = _controller!.description;
      final newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection != currentCamera.lensDirection,
        orElse: () => currentCamera,
      );

      if (newCamera != currentCamera) {
        await _controller!.dispose();
        _controller = CameraController(
          newCamera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        try {
          await _controller!.initialize();
          if (mounted) {
            setState(() {});
          }
        } catch (e) {
          debugPrint('Camera switch error: $e');
        }
      }
    }
  }

  Widget _buildScanStep({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Number circle
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.orangeColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(width: AppSizes.horizontal_12),

        // Step text
        Expanded(
          child: BodyText(
            text: text,
            size: 16,
            weight: FontWeight.w400,
            lineHeight: 1.5,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppbar(
          title: 'Scan Test Strip',
          showBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontal_10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // How to Scan Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with question icon and title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.orangeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.help_outline,
                          color: AppColors.orangeColor,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: AppSizes.horizontal_8),
                      TitleText(
                        title: 'How to Scan',
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_20),

                  // Step 1
                  _buildScanStep(
                    number: '1',
                    text: 'Remove the test strip from your smart pad after use',
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Step 2
                  _buildScanStep(
                    number: '2',
                    text: 'Place the strip flat on a clean, well-lit surface',
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Step 3
                  _buildScanStep(
                    number: '3',
                    text:
                        'Align the strip within the camera frame and tap scan',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_20),

            // Camera Frame Container
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 1.3,
              decoration: BoxDecoration(
                color: const Color(0xFF0A0F1C),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Camera Preview
                    if (_isCameraInitialized)
                      Transform.scale(
                        scaleX: 1,
                        scaleY: 1.5,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: CameraPreview(_controller!),
                          ),
                        ),
                      ),

                    // Center Frame Indicator
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                AppColors.contentTertiaryColor.withOpacity(0.5),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    // Instruction Text
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
                          BodyText(
                            text: 'Position test strip in frame',
                            color: AppColors.contentTertiaryColor,
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),

                    // Bottom Controls
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Flash Toggle
                          IconButton(
                            onPressed: _toggleFlash,
                            icon: Icon(
                              _isFlashOn ? Icons.flash_on : Icons.flash_off,
                              color: AppColors.whiteColor,
                              size: 24,
                            ),
                          ),

                          // Capture Button
                          InkWell(
                            onTap: _takePicture,
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: AppColors.orangeColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: AppColors.whiteColor,
                                size: 30,
                              ),
                            ),
                          ),

                          // Switch Camera
                          IconButton(
                            onPressed: _switchCamera,
                            icon: const Icon(
                              Icons.flip_camera_ios,
                              color: AppColors.whiteColor,
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

            const SizedBox(height: AppSizes.vertical_20),

            // Test Strip Types Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    title: 'Test Strip Types',
                    size: 20,
                    weight: FontWeight.w700,
                  ),
                  const SizedBox(height: AppSizes.vertical_20),

                  // Hormone Panel
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.orangeColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'H',
                            style: TextStyle(
                              color: AppColors.orangeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.horizontal_16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: 'Hormone Panel',
                              weight: FontWeight.w600,
                              size: 16,
                            ),
                            const SizedBox(height: 4),
                            BodyText(
                              text: 'Ovulation & pregnancy',
                              color: AppColors.contentTertiaryColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.horizontal_12,
                          vertical: AppSizes.vertical_4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F6FD),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: BodyText(
                          text: 'Most Common',
                          color: AppColors.blueColor,
                          size: 12,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Cancer Screening
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.orangeColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'C',
                            style: TextStyle(
                              color: AppColors.orangeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.horizontal_16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: 'Cancer Screening',
                              weight: FontWeight.w600,
                              size: 16,
                            ),
                            const SizedBox(height: 4),
                            BodyText(
                              text: 'Early detection markers',
                              color: AppColors.contentTertiaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Metabolic Panel
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.orangeColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'M',
                            style: TextStyle(
                              color: AppColors.orangeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.horizontal_16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: 'Metabolic Panel',
                              weight: FontWeight.w600,
                              size: 16,
                            ),
                            const SizedBox(height: 4),
                            BodyText(
                              text: 'Blood sugar & health markers',
                              color: AppColors.contentTertiaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_20),

            // Important Notice
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.orangeColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.orangeColor,
                    size: 24,
                  ),
                  const SizedBox(width: AppSizes.horizontal_12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyText(
                          text: 'Important',
                          weight: FontWeight.w600,
                          color: AppColors.orangeColor,
                          size: 16,
                        ),
                        const SizedBox(height: 4),
                        BodyText(
                          text:
                              'Always dispose of used test strips safely according to local medical waste guidelines. Do not reuse strips.',
                          color: AppColors.orangeColor,
                          lineHeight: 1.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_30),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (int value) {
          ServiceRegistry.commonRepository.currentScreenIndex.value = value;
        },
        currentPage: ServiceRegistry.commonRepository.currentScreenIndex.value,
      ),
    );
  }
}
