# PDTSimpleCalendar
=================

[![Pod version](https://img.shields.io/cocoapods/v/PDTSimpleCalendar.svg?style=flat)](http://cocoadocs.org/docsets/PDTSimpleCalendar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://img.shields.io/travis/jivesoftware/PDTSimpleCalendar.svg?style=flat)](https://travis-ci.org/jivesoftware/PDTSimpleCalendar)

PDTSimpleCalendar is a very simple calendar/date picker component for your iOS apps based on UICollectionView and a flowLayout. The application was inspired by the Square's TImeSquare and Apple Calendar. This application serves to be used within other iOS applications and supports multiple features to accommodate the users.

![Default](https://github.com/jivesoftware/PDTSimpleCalendar/raw/master/Documentation/default.png)
![Scrolling](https://github.com/jivesoftware/PDTSimpleCalendar/raw/master/Documentation/scrolling.png)
![Hebrew](https://github.com/jivesoftware/PDTSimpleCalendar/raw/master/Documentation/hebrew.png)

## Upgrade Note

You should read the [Release Notes](https://github.com/jivesoftware/PDTSimpleCalendar/blob/master/RELEASENOTES.md) when you upgrade to a newer version.

## Installation

### Cocoapods

In your `Podfile` just add:

`pod 'PDTSimpleCalendar', '~> 0.9.1'`

then run `pod install`

And finally in your project import `#import <PDTSimpleCalendar/PDTSimpleCalendar.h>`

### Carthage

In your `Cartfile` simply add:

`github "jivesoftware/PDTSimpleCalendar" ~> 0.9.1`

run `carthage update`

Finally you need to add the built framework to your project. For more information about Carthage : [github.com/Carthage/Carthage](https://github.com/Carthage/Carthage)

**Warning**: Carthage uses dynamic framework and will only work if your app targets iOS 8.0 or later.

### Old-School
If you don't like cocoapods or Carthage or Cocoapods-Rome, you can still import it using `git submodule` or simply copy/paste all the source files in `PDTSimpleCalendar` to your project.


## Features

### Calendar
* `firstDate` : When the calendar must starts. If you don't specify anything, it will default to the first day of the current month (based on `[NSDate date]`). If `firstDate` is not the 1st of the month, the calendar will display the full month, but dates < `firstDate` will be disabled.
* `lastDate` : When the calendar must ends. If you don't specify anything, it will default to the last day of the next year (based on `firstDate`). If `lastDate` is not the last day of the month, the calendar will display the full month, but dates > `lastDate` will be disabled.
* `calendar` : Which calendar to use for display and date calculations. You can set any calendar supported by `NSCalendar`. the default value will be `[NSCalendar currentCalendar]`.
* `weekdayHeaderEnabled`: If enabled, add an extra header on top of the calendar with the days of the week. Default is NO.
* `weekdayTextType`: If weekday header is enabled,  you can customize the format of the label. (Short (3 letters), VeryShort (1 letter), StandAlone (Full name of the day))


### Colors
You can change the display of the calendar using `backgroundColor` & `overlayTextColor` properties on `PDTSimpleCalendarViewController`.

Other colors can be set using UIAppearance on `PDTSimpleCalendarViewCell`, `PDTSimpleCalendarViewHeader` & `PDTSimpleCalendarViewWeekdayHeader`

    [[PDTSimpleCalendarViewCell appearance] setCircleDefaultColor:[UIColor whiteColor]];
    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor orangeColor]];
    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor blueColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextDefaultColor:[UIColor redColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextSelectedColor:[UIColor purpleColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextTodayColor:[UIColor magentaColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextDisabledColor:[UIColor yellowColor]];

    [[PDTSimpleCalendarViewHeader appearance] setTextColor:[UIColor redColor]];
    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];
    
    [[PDTSimpleCalendarViewWeekdayHeader appearance] setHeaderBackgroundColor:[UIColor lightGrayColor]];
    [[PDTSimpleCalendarViewWeekdayHeader appearance] setTextColor:[UIColor orangeColor]];

## Demo
*See the Demo for the full API and even more customization.*
https://github.com/jivesoftware/PDTSimpleCalendar/tree/master/PDTSimpleCalendarDemo 

A demo is included in the application to see how the calendar will appear based on the default selected options that the user can edit to determine a visual look they desire. An example of how the calendar application will look in an iOS application can be seen on the Producteev app:

![Producteev](https://github.com/jivesoftware/PDTSimpleCalendar/raw/master/Documentation/producteev.png)

## Testing
*See the Tests file for the full testing code.*
https://github.com/jivesoftware/PDTSimpleCalendar/blob/master/PDTSimpleCalendarTests/PDTSimpleCalendarTests.m

The application has undergone the testings for the necessities of a basic calendar:
- [x] Ensuring that the calendar is properly set up upon call and contains the correct data.
- [x] Ensuring that the calendar is dismissed when clicked out of.
- [x] The default behavior of the calendar should make sure the first day of the month is a one along with the first and last days.
- [x] The first day of the month should be set to the correct day according to the year.
- [x] The last day of the month should be set to the correct day according to the year.
- [x] The number of days a week should be the correct amount based on the type of calendar that the user selects.

## Contribution
If you find a bug or have any issues with the application please open an issue here: https://github.com/jivesoftware/PDTSimpleCalendar/issues.

## License

```
Copyright 2013-2015 Jive Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
