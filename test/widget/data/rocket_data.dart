import 'package:space_x_tracker/providers/models/rocket.dart';

class RocketData {
  static final Map<String, dynamic> rocketData = {
    'active': true,
    'boosters': 0,
    'company': 'SpaceX',
    'cost_per_launch': 50000000,
    'country': 'United States',
    'description':
        'Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.',
    'diameter': {'meters': 3.7, 'feet': 12},
    'height': {'meters': 70, 'feet': 229.6},
    'mass': {'kg': 549054, 'lb': 1207920},
    'name': 'Falcon 9',
    'stages': 2,
    'success_rate_pct': 98,
    'flickr_images': [
      'https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg',
      'https://farm4.staticflickr.com/3955/32915197674_eee74d81bb_b.jpg',
      'https://farm1.staticflickr.com/293/32312415025_6841e30bf1_b.jpg',
      'https://farm1.staticflickr.com/623/23660653516_5b6cb301d1_b.jpg',
      'https://farm6.staticflickr.com/5518/31579784413_d853331601_b.jpg',
      'https://farm1.staticflickr.com/745/32394687645_a9c54a34ef_b.jpg'
    ],
    'payload_weights': [
      {'id': 'leo', 'name': 'Low Earth Orbit', 'kg': 22800, 'lb': 50265},
      {
        'id': 'gto',
        'name': 'Geosynchronous Transfer Orbit',
        'kg': 8300,
        'lb': 18300
      },
      {'id': 'mars', 'name': 'Mars Orbit', 'kg': 4020, 'lb': 8860}
    ],
  };

  static Rocket get rocket {
    return Rocket.fromJson(rocketData);
  }

  static Rocket get rocketWithoutImage {
    Map<String, dynamic> rocket = rocketData;
    rocket['flickr_images'] = [];

    return Rocket.fromJson(rocket);
  }
}
