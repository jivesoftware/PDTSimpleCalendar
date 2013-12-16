//
//  PDTSimpleCalendarViewController.h
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDTSimpleCalendarViewDelegate;

/**
 *  Define the number of days in a week. Usually 7.
 */
extern const NSUInteger PDTSimpleCalendarDaysPerWeek;

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
 *  First date displayed by the calendar. If not set, the default value is the first day of the current month.
 *  You can pass every `NSDate`, the firstDate will be automatically set to the first day of its month.
 */
@property (nonatomic, strong) NSDate *firstDate;

/**
 *  Last date displayed by the calendar. If not set, the default value is `firstDate` + one year using `calendar` for calculation
 *  You can pass every `NSDate`, the lastDate will be automatically set to last first day of its month.
 */
@property (nonatomic, strong) NSDate *lastDate;

/**
 *  Selected date displayed by the calendar.
 *  Changing this value will cause the calendar to scroll to this date (without animation).
 */
@property (nonatomic, strong) NSDate *selectedDate;

/** @name Customizing Appearance */

/**
 *  Background color of the Calendar. This will also affect the value of the background color for the overlay view.
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  Text color for the overlay view (Month and Year when the user scrolls the calendar)
 */
@property (nonatomic, strong) UIColor *overlayTextColor;



/** @name Getting Notified of changes */

/**
 *  The delegate of the calendar.
 *  Must adopt the `PDTSimpleCalendarViewDelegate` protocol.
 *
 *  @see PDTSimpleCalendarViewDelegate
 */
@property (nonatomic, weak) id<PDTSimpleCalendarViewDelegate> delegate;


/**
 *  Change the selected date of the calendar, and scroll to it
 *
 *  @param newSelectedDate the date that will be selected
 *  @param animated        if you want to animate the scrolling
 */
- (void)setSelectedDate:(NSDate *)newSelectedDate animated:(BOOL)animated;

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

/** Tells the delegate that a date was selected by the user.

 @param date the date being selected (Midnight GMT).
 */
- (void)simpleCalendarViewDidSelectDate:(NSDate *)date;

/**
 *  Asks the delegate if the Calendar should use custom colors for the specified date.
 *
 *  @param date the date (Midnight GMT)
 *
 *  @return YES if the calendar must ask the delegate for text and circle color, NO if it should use default values.
 */
- (BOOL)simpleCalendarShouldUseCustomColorsForDate:(NSDate *)date;

/**
 * Asks the delegate for the circle color for a custom added date
 *
 * @param date the date (Midnight GMT).
 */
- (UIColor *)simpleCalendarCircleColorForDate:(NSDate *)date;

/**
 * Asks the delegate for the text color for a custom added date
 *
 * @param date the date (Midnight GMT).
 */
- (UIColor *)simpleCalendarTextColorForDate:(NSDate *)date;

@end;