# space_x_tracker

SpaceX launch tracker app that shows a list of launches with rocket details for every launch.

## Responsiveness

The application is build for mobile devices with support for tablets and web, however use a phone for the best user experience. As the application is developed using a Windows
machine the application has not been tested on an iPhone emulator or a physical Iphone. The application has been tested on a pixel 5 emulator and a physical Android device (Samsung S21).

The responsiveness has been tested for all devices with the use of the `device_preview` package: https://pub.dev/packages/device_preview.

## Git hooks

In order to use the git hook scripts execute the following command in the terminal on your local machine:
`git config core.hooksPath .githooks/`

## Integration testing

The integration tests can be run by executing the `integration_test.sh` file. Make sure that there is an emulator available.
