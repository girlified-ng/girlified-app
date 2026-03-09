import 'dart:io';
import 'dart:ui' as ui;
import 'dart:developer';
import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:appcheck/appcheck.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/src/multipart_file.dart' as DioMultipart;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

String formatDate(DateTime date) {
  return DateFormat('d MMM y').format(date);
}

String formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'Just now';
  } else if (difference.inHours < 1) {
    final minutes = difference.inMinutes;
    return '$minutes minute${minutes != 1 ? 's' : ''} ago';
  } else if (difference.inDays < 1) {
    final hours = difference.inHours;
    return '$hours hour${hours != 1 ? 's' : ''} ago';
  } else if (difference.inDays < 7) {
    final days = difference.inDays;
    return '$days day${days != 1 ? 's' : ''} ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks week${weeks != 1 ? 's' : ''} ago';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months != 1 ? 's' : ''} ago';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years year${years != 1 ? 's' : ''} ago';
  }
}

Future<void> preCacheNetworkImages(List<String> imageUrls) async {
  try {
    debugPrint('[CACHED-IMAGES-PROCESSING]');

    final cacheManager = DefaultCacheManager();

    await Future.wait(imageUrls.map((url) async {
      try {
        final file = cacheManager.getFileStream(url);
        if (file != null) {
          // Image is cached, use the cached file
        } else {
          // Image is not cached, download and cache it
          await cacheManager.downloadFile(url);
        }
      } catch (e) {
        debugPrint('[CACHE-IMAGE-ERROR]: $url $e');
      }
    }));

    debugPrint('[CACHED-IMAGES-SUCCESS]');
  } catch (error) {
    debugPrint('[CACHED-IMAGES-ERROR]  :: $error');
  }
}

String formatStringToLength(int length, String productName) {
  if (productName.length > length) {
    return "${productName.substring(0, length)}...";
  } else {
    return productName;
  }
}

String formatNumber(int value) {
  if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}m';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1)}k';
  }
  return value.toString();
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }

  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

String formatStringToSubstring(String input, int maxLength,
    {String suffix = '...'}) {
  if (input.length <= maxLength) {
    return input;
  } else {
    return '${input.substring(0, maxLength - suffix.length)}$suffix';
  }
}

String calculateOutletRating(
    num rating1, num rating2, num rating3, num rating4, num rating5) {
  num rating = (rating1 + rating2 + rating3 + rating4 + rating5);

  return rating > 0 ? "$rating+" : "$rating";
}

String priceFormatter(double price, {bool showKobo = false}) {
  final formatter = NumberFormat.currency(locale: 'en-NG', symbol: '₦');
  return showKobo == true
      ? formatter.format(price)
      : formatter.format(price).split('.')[0];
}

String convertDateTimeTo12HourFormat(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  int hour = dateTime.hour;
  int minute = dateTime.minute;

  String period = hour >= 12 ? 'PM' : 'AM';

  hour = hour % 12;
  hour = hour == 0 ? 12 : hour;

  String formattedTime =
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

  return formattedTime;
}

DateTime parseDateTime(String dateTime) {
  return DateTime.parse(dateTime);
}

String formatScheduledOrderDateTime(String dateTime) {
  final DateFormat formatter = DateFormat('E, d MMM hh:mm a');

  String formatted = formatter.format(DateTime.parse(dateTime));

  formatted = formatted.replaceFirstMapped(
    RegExp(r'am|pm'),
    (Match match) => match.group(0)!.toUpperCase(),
  );

  List<String> parts = formatted.split(' ');
  parts[2] = capitalizeFirstLetter(parts[2]);

  return parts.join(' ');
}

bool isScheduleOrderTimeSlotAvailable(String timeString, String dateString) {
  DateTime now = DateTime.now();
  DateTime givenTime;
  DateTime givenDate;

  try {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    givenDate = dateFormat.parse(dateString);

    DateFormat timeFormat = DateFormat("h:mm a");
    givenTime = timeFormat.parse(timeString);

    DateTime nowTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    );

    DateTime slotTime = DateTime(
      givenDate.year,
      givenDate.month,
      givenDate.day,
      givenTime.hour,
      givenTime.minute,
    );

    Duration difference = slotTime.difference(nowTime);

    // log('[TIME_DIFF] :: ${difference.inMinutes}');

    return difference.inMinutes >= 30;
  } catch (e) {
    log("Error parsing time or date: $e");

    return false;
  }
}

Map<String, String> formatDayDateTime(
  String dateTime, {
  String dateFormat = 'd MMM y',
}) {
  // log('[DATE-TIME] :: $dateTime');

  final DateFormat dateFormatter = DateFormat(dateFormat);
  final DateFormat timeFormatter = DateFormat('hh:mm a');

  DateTime parsedDateTime =
      DateTime.parse(dateTime.isEmpty ? '2024-10-11' : dateTime);

  String formattedDate = dateFormatter.format(parsedDateTime);
  String formattedTime = timeFormatter.format(parsedDateTime);

  List<String> dateParts = formattedDate.split(' ');

  // log('[DATE-PARTS] :: $dateParts');

  if (dateFormat.contains('MMM')) {
    int monthIndex = dateFormat.split(' ').indexOf('MMM');
    if (monthIndex >= 0 && monthIndex < dateParts.length) {
      dateParts[monthIndex] = capitalizeFirstLetter(dateParts[monthIndex]);
    }
  }

  formattedDate = dateParts.join(' ');

  formattedTime = formattedTime.toUpperCase();

  return {
    'date': formattedDate,
    'time': formattedTime,
  };
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

Future<bool> copyToClipboard(String text) async {
  try {
    await Clipboard.setData(ClipboardData(text: text));

    customSuccessMessageSnackbar(
      title: 'Message',
      message: 'Copied to clipboard!',
    );

    return true;
  } catch (error) {
    log('[COPY-TO-CLIPBOARD-ERROR] :: $error');

    return false;
  }
}

int parseCurrencyAmount(String amount) {
  String digitsOnly = amount.replaceAll(RegExp(r'[^\d]'), '');

  return int.parse(digitsOnly);
}

void launchExternalBrowserUrl(String linkUrl) async {
  try {
    Uri url = Uri.parse(linkUrl);

    await canLaunchUrl(url);

    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (error) {
    log('[LAUNCH-HELP-URL-ERROR] :: [URL] -> $linkUrl [ERROR] -> ${error.toString()}');
  }
}

String getFileMimeType(String? extension) {
  switch (extension?.toLowerCase()) {
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'pdf':
      return 'application/pdf';
    // Add more cases as needed
    default:
      return 'application/octet-stream';
  }
}

Future<PlatformFile?> getImageFromDeviceStorage({
  String fileName = 'avatar',
}) async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100, // we'll do our own compression later
    );

    if (image == null) return null;

    File originalFile = File(image.path);

    log("[INITIAL-FILE-SIZE] :: ${originalFile.lengthSync()}");

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String targetPath =
        '${appDocDir.path}/${originalFile.path.split('/').last}';

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      originalFile.path,
      targetPath,
      quality: 15,
    );

    if (compressedFile == null) return null;

    File newImage = File(compressedFile.path);

    PlatformFile platformFile = PlatformFile(
      name: fileName,
      path: newImage.path,
      size: newImage.lengthSync(),
    );

    log("[COMPRESSED-FILE-SIZE] :: ${platformFile.size}");

    return platformFile;
  } catch (e) {
    log("Error picking image: $e");
    return null;
  }
}

Future<PlatformFile?> getFileFromDeviceStorage() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return null;

    PlatformFile file = result.files.first;

    // If it's an image, compress it
    if (file.extension?.toLowerCase() == 'jpg' ||
        file.extension?.toLowerCase() == 'jpeg') {
      log("[INITIAL-FILE-SIZE] :: ${file.size}");

      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String targetPath = '${appDocDir.path}/${file.name}';

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.path!,
        targetPath,
        quality: 15,
      );

      if (compressedFile == null) return null;

      File newFile = File(compressedFile.path);

      PlatformFile compressedPlatformFile = PlatformFile(
        name: file.name,
        path: newFile.path,
        size: newFile.lengthSync(),
      );

      log("[COMPRESSED-FILE-SIZE] :: ${compressedPlatformFile.size}");

      return compressedPlatformFile;
    }

    // If it's a PDF, return as is
    return file;
  } catch (e) {
    log("Error picking document: $e");
    return null;
  }
}

Future<PlatformFile?> assetToPlatformFile(
  String assetPath, {
  String? fileName,
  int quality = 15,
}) async {
  try {
    final ByteData assetData = await rootBundle.load(assetPath);
    final Uint8List bytes = assetData.buffer.asUint8List();

    final Directory appDocDir = await getApplicationDocumentsDirectory();

    final String originalExtension = path.extension(assetPath).toLowerCase();
    final String baseFileName =
        fileName ?? path.basenameWithoutExtension(assetPath);

    String outputExtension;
    CompressFormat compressFormat;

    if (originalExtension == '.png') {
      outputExtension = '.jpg';
      compressFormat = CompressFormat.jpeg;
    } else if (originalExtension == '.jpg' || originalExtension == '.jpeg') {
      outputExtension = originalExtension;
      compressFormat = CompressFormat.jpeg;
    } else {
      throw Exception('Unsupported image format: $originalExtension');
    }

    final Directory tempDir = await getTemporaryDirectory();
    final String tempFilePath =
        path.join(tempDir.path, 'temp_$baseFileName$originalExtension');
    final String targetPath =
        path.join(appDocDir.path, '$baseFileName$outputExtension');

    final File tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(bytes);

    log("[INITIAL-FILE-SIZE] :: ${bytes.length}");

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      tempFilePath,
      targetPath,
      quality: quality,
      format: compressFormat,
    );

    if (compressedFile == null) {
      throw Exception('Failed to compress image');
    }

    final File newImage = File(compressedFile.path);

    PlatformFile platformFile = PlatformFile(
      name: path.basename(targetPath),
      path: newImage.path,
      size: newImage.lengthSync(),
    );

    log("[COMPRESSED-FILE-SIZE] :: ${platformFile.size}");

    await tempFile.delete();

    return platformFile;
  } catch (e) {
    log('Failed to convert asset to PlatformFile: $e');
    return null;
  }
}

Future<PlatformFile?> getAvatarImage({
  String? assetPath,
  String fileName = 'avatar',
}) async {
  if (assetPath != null) {
    return await assetToPlatformFile(
      assetPath,
      fileName: fileName,
    );
  } else {
    return await getImageFromDeviceStorage(
      fileName: fileName,
    );
  }
}

Future<Uint8List> getBytesFromAssetImage({
  required int width,
  required String path,
}) async {
  final ByteData data = await rootBundle.load(path);

  final ui.Codec codec = await ui.instantiateImageCodec(
    targetWidth: width,
    data.buffer.asUint8List(),
  );

  final ui.FrameInfo fi = await codec.getNextFrame();

  final Uint8List bytes =
      (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();

  return bytes;
}

Future<List<PlatformFile>?> getImagesFromGallery(
    String imageNamePrefix, int numberOfImagesToSelect) async {
  final ImagePicker picker = ImagePicker();

  final List<XFile> result = await picker.pickMultiImage(
    imageQuality: 15,
  );

  if (result.isEmpty) {
    return null;
  }

  List<PlatformFile> platformFiles = [];

  // Limit the number of selected images
  int count = 0;

  for (var file in result) {
    if (count >= numberOfImagesToSelect) {
      break;
    }

    debugPrint("[IMAGE-PATH] :: ${file.path}");
    debugPrint("[IMAGE-SIZE] :: ${File(file.path).lengthSync()}");

    // Generate unique name for each image
    String imageName =
        '$imageNamePrefix${DateTime.now().millisecondsSinceEpoch}_${file.name}';

    // Compress image
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String targetPath = '${appDocDir.path}/$imageName';

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 15,
    );

    if (compressedFile == null) continue;

    File newImage = File(compressedFile.path);

    // Create PlatformFile
    PlatformFile platformFile = PlatformFile(
      name: imageName,
      size: newImage.lengthSync(),
      path: newImage.path,
    );

    platformFiles.add(platformFile);

    count++;
  }

  return platformFiles;
}

Future<PlatformFile?> getVideoFromGallery() async {
  final ImagePicker picker = ImagePicker();

  final XFile? result = await picker.pickVideo(
    source: ImageSource.gallery,
  );

  if (result == null) {
    return null;
  }

  return PlatformFile(
    name: result.name,
    size: File(result.path).lengthSync(),
    path: result.path,
  );
}

Future<void> launchDefaultEmailApp() async {
  final appCheck = AppCheck();
  const String gmailUrlSchemeIOS = "googlegmail://";
  const String gmailPackageAndroid = "com.google.android.gm";

  try {
    if (Platform.isAndroid) {
      bool isGmailAvailable =
          await appCheck.checkAvailability(gmailPackageAndroid) != null;
      bool? isGmailEnabled = await appCheck.isAppEnabled(gmailPackageAndroid);

      if (isGmailAvailable && isGmailEnabled == true) {
        await appCheck.launchApp(gmailPackageAndroid);

        log('Gmail launched on Android');
      } else {
        await appCheck.launchApp('mailto:');

        log('Launched default email app on Android');
      }
    } else if (Platform.isIOS) {
      bool isGmailAvailable =
          await appCheck.checkAvailability(gmailUrlSchemeIOS) != null;

      if (isGmailAvailable) {
        await appCheck.launchApp(gmailUrlSchemeIOS);

        log('Gmail launched on iOS');
      } else {
        await appCheck.launchApp('mailto:');

        log('Launched default email app on iOS');
      }
    }
  } catch (e) {
    log('Error launching email app: $e');

    try {
      await appCheck.launchApp('mailto:');
      log('Launched default email app as fallback');
    } catch (e) {
      log('Failed to launch any email app: $e');
    }
  }
}

bool isTextWiderThanScreen({
  required String text,
  required BuildContext context,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
      ),
      maxLines: 1,
      textDirection: ui.TextDirection.ltr)
    ..layout();

  return textPainter.size.width > screenWidth;
}

String getFittedText({
  int maxLines = 1,
  required String text,
  required double maxWidth,
  required double fontSize,
  String suffix = '...',
}) {
  final TextPainter textPainter = TextPainter(
    textDirection: ui.TextDirection.ltr,
    text: TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
    maxLines: maxLines,
    ellipsis: suffix,
  );

  textPainter.layout(maxWidth: maxWidth);

  if (!textPainter.didExceedMaxLines) {
    return text;
  }

  int low = 0;
  int high = text.length;
  int result = 0;

  while (low <= high) {
    int mid = (low + high) ~/ 2;
    String substr = text.substring(0, mid) + suffix;

    final TextPainter tp = TextPainter(
      textDirection: ui.TextDirection.ltr,
      text: TextSpan(text: substr, style: TextStyle(fontSize: fontSize)),
      maxLines: 1,
      ellipsis: suffix,
    );

    tp.layout(maxWidth: maxWidth);

    if (!tp.didExceedMaxLines) {
      result = mid;
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }

  if (result == 0) {
    return suffix;
  }

  return text.substring(0, result) + suffix;
}

String formatPhoneNumber(String dialCode, String phoneNumber) {
  return '$dialCode$phoneNumber';
}

Future<Uint8List> getBytesFromAsset(
    {required String path, required int width}) async {
  final ByteData data = await rootBundle.load(path);
  final ui.Codec codec = await ui
      .instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  final ui.FrameInfo fi = await codec.getNextFrame();

  // Use null-aware operators and provide a fallback
  final ByteData? byteData =
      await fi.image.toByteData(format: ui.ImageByteFormat.png);

  if (byteData == null) {
    // Return an empty Uint8List or handle the error as appropriate
    return Uint8List(0);
  }

  return byteData.buffer.asUint8List();
}

String checkDaysRemaining(String dateString) {
  DateTime targetDate = DateFormat('yyyy-MM-dd').parse(dateString);
  DateTime today = DateTime.now();

  if (today.isAfter(targetDate)) {
    return 'Expired';
  } else {
    int daysRemaining = targetDate.difference(today).inDays;
    return '$daysRemaining days remaining';
  }
}

String formatPromotionPlanTitle(String title) {
  String result = "";

  switch (title) {
    case "WEEKLY":
      result = "Weekly Plan";
    case "TWO_WEEKS":
      result = "Two Week Plan";
    case "MONTHLY":
      result = "Monthly Plan";
  }

  return result;
}

String formatStringToSentenceCase(String input) {
  if (input.isNotEmpty) {
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  } else {
    return "";
  }
}

String normalizePhoneNumber(String phone) {
  String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
  if (!cleaned.startsWith('+234') && cleaned.startsWith('0')) {
    cleaned = '+234${cleaned.substring(1)}';
  }
  if (!cleaned.startsWith('+') && cleaned.length == 10) {
    cleaned = '+234$cleaned';
  }
  return cleaned;
}

String formatTime(int seconds) {
  final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
  final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
  final secs = (seconds % 60).toString().padLeft(2, '0');
  return '$hours:$minutes:$secs';
}

String formatDayFromDate(DateTime date) {
  String day = 'Mon';

  switch (date.weekday) {
    case 1:
      day = 'Mon';
      break;
    case 2:
      day = 'Tue';
      break;
    case 3:
      day = 'Wed';
      break;
    case 4:
      day = 'Thu';
      break;
    case 5:
      day = 'Fri';
      break;
    case 6:
      day = 'Sat';
      break;
    case 7:
      day = 'Sun';
      break;
  }
  return day;
}

