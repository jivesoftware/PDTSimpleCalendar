##PDTSimpleCalendar Release Note

###0.7.0

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

###0.6

if you specify a `firstDate` and/or `lastDate` the calendar will display the full month, but dates < `firstDate` or > `lastDate` will be disabled. You can see this behavior in the demo app.