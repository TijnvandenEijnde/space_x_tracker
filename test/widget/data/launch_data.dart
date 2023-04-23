import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/providers/models/link.dart';
import 'package:space_x_tracker/providers/models/patch.dart';

class LaunchData {
  static final Map<String, dynamic> launchData = {
    'links': {
      'patch': {
        'small': 'https://images2.imgbox.com/94/f2/NN6Ph45r_o.png',
        'large': 'https://images2.imgbox.com/5b/02/QcxHUb5V_o.png'
      }
    },
    'rocket': '5e9d0d95eda69955f709d1eb',
    'success': false,
    'crew': [],
    'ships': [],
    'capsules': [],
    'payloads': ['5eb0e4b5b6c3bb0006eeb1e1'],
    'flight_number': 1,
    'name': 'FalconZ',
    'date_local': '2006-03-25T10:30:00+12:00',
    'upcoming': false,
    'cores': [
      {
        'core': '5e9e289df35918033d3b2623',
        'flight': 1,
        'gridfins': false,
        'legs': false,
        'reused': false,
        'landing_attempt': false,
        'landing_success': null,
        'landing_type': null,
        'landpad': null
      }
    ],
    'tbd': false
  };

  static Launch get successLaunch {
    Map<String, dynamic> modifiedLaunchData = {...launchData};
    modifiedLaunchData['success'] = true;
    modifiedLaunchData['date_local'] = '2007-03-25T10:30:00+12:00';
    modifiedLaunchData['flight_number'] = 2;
    modifiedLaunchData['name'] = 'FalconY';

    return Launch.fromJson(modifiedLaunchData);
  }

  static Launch get failedLaunch {
    return Launch.fromJson(launchData);
  }

  static Launch get upcomingLaunch {
    Map<String, dynamic> modifiedLaunchData = {...launchData};
    modifiedLaunchData['upcoming'] = true;
    modifiedLaunchData['date_local'] = '2008-03-25T10:30:00+12:00';
    modifiedLaunchData['flight_number'] = 3;
    modifiedLaunchData['name'] = 'FalconX';
    modifiedLaunchData['links'] = {
      'patch': {
        'small': null,
        'large': null,
      }
    };

    return Launch.fromJson(modifiedLaunchData);
  }

  static List<Launch> get launches {
    return [
      failedLaunch,
      successLaunch,
      upcomingLaunch,
    ];
  }

  static List<Map<String, dynamic>> get launchesToJson {
    return [
      failedLaunch.toJson(),
      successLaunch.toJson(),
      upcomingLaunch.toJson(),
    ];
  }

  static Launch get launchWithoutPatch {
    Map<String, dynamic> modifiedLaunchData = {...launchData};
    modifiedLaunchData['links'] = {
      'patch': {
        'small': null,
        'large': null,
      }
    };

    return Launch.fromJson(modifiedLaunchData);
  }

  static List<Map<String, dynamic>> get launchesToJsonWithoutPatches {
    Map<String, dynamic> failedLaunchWithoutPatch = failedLaunch.toJson();
    failedLaunchWithoutPatch['links'] = Link(
      patch: Patch(
        small: null,
        large: null,
      ),
    );

    Map<String, dynamic> successLaunchWithoutPatch = successLaunch.toJson();
    successLaunchWithoutPatch['links'] = Link(
      patch: Patch(
        small: null,
        large: null,
      ),
    );

    return [
      failedLaunchWithoutPatch,
      successLaunchWithoutPatch,
      upcomingLaunch.toJson()
    ];
  }
}
