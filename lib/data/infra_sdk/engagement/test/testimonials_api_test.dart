import 'package:test/test.dart';
import 'package:engagement_sdk/engagement_sdk.dart';


/// tests for TestimonialsApi
void main() {
  final instance = EngagementSdk().getTestimonialsApi();

  group(TestimonialsApi, () {
    //Future<BuiltList<TestimonialInfo>> engagementControllerFetchTestimonialsFeed() async
    test('test engagementControllerFetchTestimonialsFeed', () async {
      // TODO
    });

  });
}
