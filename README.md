PDTSimpleCalendar
=================

PDTSimpleCalendar is a very simple calendar/date picker component for your iOS apps based on UICollectionView.

![Default](https://github.com/jivesoftware/PDTSimpleCalendar/raw/master/Documentation/default.png)
![Hebrew](https://github.com/jivesoftware/PDTSimpleCalendar/raw/master/Documentation/hebrew.png)
![Arab](https://github.com/jivesoftware/PDTSimpleCalendar/raw/master/Documentation/arab.png)


##Install

We recommend using Cocoapods, in your Podfile just add:

`pod 'PDTSimpleCalendar', '~> 0.4'`

then run `pod install`

And finally in your project import `#import <PDTSimpleCalendar/PDTSimpleCalendar.h>`

If you don't like cocoapods, you can still import it using `git submodule` or simply copy/paste all the files in `PDTSimpleCalendar` to your project.


##Customize it

###Calendar
* `firstDate` : When the calendar must starts. If you don't specify anything, it will default to the first day of the current month (based on `[NSDate date]`).
* `lastDate` : When the calendar must ends. If you don't specify anything, it will default to the last day of the next year (based on `firstDate`).
* `calendar` : Which calendar to use for display and date calculations. You can set any calendar supported by `NSCalendar`. the default value will be `[NSCalendar currentCalendar]`.

###Colors
You can change the display of the calendar using `backgroundColor` & `overlayTextColor` properties on `PDTSimpleCalendarViewController`.

Other colors can be set using UIAppearance on `PDTSimpleCalendarViewCell` & `PDTSimpleCalendarViewHeader`

    [[PDTSimpleCalendarViewCell appearance] setCircleDefaultColor:[UIColor whiteColor]];
    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor orangeColor]];
    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor blueColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextDefaultColor:[UIColor redColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextSelectedColor:[UIColor purpleColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextTodayColor:[UIColor magentaColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextDisabledColor:[UIColor yellowColor]];

    [[PDTSimpleCalendarViewHeader appearance] setTextColor:[UIColor redColor]];
    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];

Here is how it looks in the Producteev app:

![Producteev](https://github.com/jivesoftware/PDTSimpleCalendar/raw/master/Documentation/producteev.png)


##License

```
Copyright 2013 Jive Software, Inc.

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