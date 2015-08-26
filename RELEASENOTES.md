##PDTSimpleCalendar Release Notes

###0.9.1
- Fix bug on iOS7 related to week calculation and resulting on a crash (#69)
- Fix Carthage build

###0.9.0
Last version compatible with iOS6. Following versions will be compatible iOS7+. Regarding the adoption rate of iOS8 & 7. I doubt this is gonna be an issue.

You can now display a fixed-header with the days of the week. Set `weekdayHeaderEnabled = YES` to display it. For Backward compatibility, the default behavior is NO. Although having it visible might become the default behavior in 1.0.
You can also tweak the style of the weekdays by setting the property `weekdayTextType`;

`setSelectedDate:animated:` has been removed. If you were still using it, use the `selectedDate` property +  `scrollToDate:animated:` (or `scrollToSelectedDate:`)

More Tests (but still many more needed specially for date calculation)!!! If you wanna contribute run pod install before opening the Workspace.

###0.8.0
Bug fixes and small improvements

Carthage compatible

###0.7.1

New delegate method to disable specific dates

`- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller isEnabledDate:(NSDate *)date;`

Accessibility Labels on Cell will return a proper formatted date.

Change Header and Day font using appearance proxy

###0.7.0

####Behavior change

`setSelectedDate:animated:` is now deprecated and will be removed in next version. Selecting a date in the calendar shouldn't be tied to scrolling to it.

Use `setSelectedDate:` & `scrollToSelectedDate:` instead.

####Spring Cleaning:

Old delegates methods have been removed from the code base.

````
- (void)simpleCalendarViewDidSelectDate:(NSDate *)date;
- (BOOL)simpleCalendarShouldUseCustomColorsForDate:(NSDate *)date;
- (UIColor *)simpleCalendarCircleColorForDate:(NSDate *)date;
- (UIColor *)simpleCalendarTextColorForDate:(NSDate *)date;
````

You should now use:

````
- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date;
- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForDate:(NSDate *)date;
- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForDate:(NSDate *)date;
- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForDate:(NSDate *)date;
````

`PDTSimpleCalendarDaysPerWeek` has been removed from the code base. Days per week are automatically retrieve from the `calendar` property.

Fix: `scrollToDate` takes into account `contentInset`
Fix: Respect Calendar's locale formatting for days number

###0.6

if you specify a `firstDate` and/or `lastDate` the calendar will display the full month, but dates < `firstDate` or > `lastDate` will be disabled. You can see this behavior in the demo app.

You will notice that the delegate format have changed. Previous delegate definitions (and also a static variable) have been deprecated. They will be removed in the next release.
