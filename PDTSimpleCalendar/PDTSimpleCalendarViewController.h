//
//  PDTSimpleCalendarViewController.h
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

@import UIKit;

#import "PDTSimpleCalendarViewWeekdayHeader.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PDTSimpleCalendarViewDelegate;

/**
 *  `PDTSimpleCalendarViewController` is a `UICollectionViewController` subclass that displays a scrollable calendar view inspired by iOS7 Apple Cal App.
 */
@interface PDTSimpleCalendarViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout>

/** @name Calendar Setup */

/**
 *  The calendar used to generate the view.
 *
 *  If not set, the default value is `[NSCalendar currentCalendar]`
 */
@property (nonatomic, strong) NSCalendar *calendar;

/**
 *  First date enabled in the calendar. If not set, the default value is the first day of the current month (based on `[NSDate date]`).
 *  You can pass every `NSDate`, if the firstDate is not the first day of its month, the previous days will be automatically disabled.
 */
@property (nonatomic, strong) NSDate *firstDate;

/**
 *  Last date enabled in the calendar. If not set, the default value is the first day of the month of `firstDate` + one year using `calendar` for calculation
 *  You can pass every `NSDate`, if the lastDate is not the last day of its month, the following days will be automatically disabled.
 */
@property (nonatomic, strong) NSDate *lastDate;

/**
 *  Selected date displayed by the calendar.
 *  Changing this value will not cause the calendar to scroll to this date.
 *  You need to manually call scrollToSelectedDate:(BOOL)animated if you want this behavior.
 */
@property (nullable, nonatomic, strong) NSDate *selectedDate;

/** @name Customizing Appearance */

/**
 *  Background color of the Calendar. This will also affect the value of the background color for the overlay view.
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  Text color for the overlay view (Month and Year when the user scrolls the calendar)
 */
@property (nonatomic, strong) UIColor *overlayTextColor;

/**
 *  Setting this to YES shows an extra row in the header with acronymns for the the weekdays
 *
 *  Default value is NO.
 */
@property (nonatomic, assign) BOOL weekdayHeaderEnabled;

/**
 *  Setting Text type of weekday
 *
 *  Default value is Short.
 */
@property (nonatomic, assign) PDTSimpleCalendarViewWeekdayTextType weekdayTextType;


/** @name Getting Notified of changes */

/**
 *  The delegate of the calendar.
 *  Must adopt the `PDTSimpleCalendarViewDelegate` protocol.
 *
 *  @see PDTSimpleCalendarViewDelegate
 */
@property (nullable, nonatomic, weak) id<PDTSimpleCalendarViewDelegate> delegate;


/**
 *  Scroll to the current selected date in the calendar.
 *
 *  @param animated if you want to animate the scrolling
 */
- (void)scrollToSelectedDate:(BOOL)animated;

/**
 *  Scroll to a certain date in the calendar.
 *
 *  @param date     the date you wanna scroll to.
 *  @param animated if you want to animate the scrolling
 */
- (void)scrollToDate:(NSDate *)date animated:(BOOL)animated;

@end


/**
 *  The methods in `PDTSimpleCalendarViewDelegate` are all optional. It allows the delegate to be notified when the user interacts with the Calendar.
 */
@protocol PDTSimpleCalendarViewDelegate <NSObject>

@optional

/**
 *  Asks the delegate if the Calendar may enable selection for the specified date
 *
 *  @param controller the calendarView Controller
 *  @param date       the date (Midnight GMT)
 *
 *  @return YES if the calendar can select the specified date, NO otherwise.
 */
- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller isEnabledDate:(NSDate *)date;

/**
 *  Tells the delegate that a date was selected by the user.
 *
 *  @param controller the calendarView Controller
 *  @param date       the date being selected (Midnight GMT).
 */
- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date;

/** @name Color Customization */

/**
 *  Asks the delegate if the Calendar should use custom colors for the specified date.
 *
 *  @param controller the calendarView Controller
 *  @param date       the date (Midnight GMT)
 *
 *  @return YES if the calendar must ask the delegate for text and circle color, NO if it should use default values.
 */
- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForDate:(NSDate *)date;

/**
 *  Asks the delegate for the circle color for a custom added date
 *
 *  @param controller the calendarView Controller
 *  @param date       the date (Midnight GMT)
 */
- (nullable UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForDate:(NSDate *)date;

/**
 *  Asks the delegate for the text color for a custom added date
 *
 *  @param controller the calendarView Controller
 *  @param date       the date (Midnight GMT)
 */
- (nullable UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForDate:(NSDate *)date;

/**
 *  Asks the delegate for custom text for a date
 *
 *  @param controller the calendarView Controller
 *  @param date       the date (Midnight GMT)
 */
- (nullable NSString *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textForDate:(NSDate *)date;

@end;
NS_ASSUME_NONNULL_END
