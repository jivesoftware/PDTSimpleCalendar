//
//  PDTSimpleCalendarViewCell.h
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

@class PDTSimpleCalendarViewCell;

@protocol PDTSimpleCalendarViewCellDelegate <NSObject>

@optional

/**
 *  Asks the delegate if the Cell should use custom colors.
 *
 *  @param cell the current cell
 *  @param date the date associated with the cell
 *
 *  @return YES if the cell must ask the delegate for text and circle color, NO if it should use default values.
 */
- (BOOL)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell shouldUseCustomColorsForDate:(NSDate *)date;

/**
 *  Asks the delegate for the text color for a specific date.
 *  Will be called only if the delegate returns YES for `- (BOOL)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell shouldUseCustomColorsForDate:(NSDate *)date;`
 *
 *  @param cell the current cell
 *  @param date the date associated with the cell
 *
 *  @return The text desired color
 */
- (UIColor *)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell textColorForDate:(NSDate *)date;

/**
 *  Asks the delegate for the circle color for a specific date.
 *  Will be called only if the delegate returns YES for `- (BOOL)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell shouldUseCustomColorsForDate:(NSDate *)date;`
 *
 *  @param cell the current cell
 *  @param date the date associated with the cell
 *
 *  @return The circle desired color
 */
- (UIColor *)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell circleColorForDate:(NSDate *)date;

@end

#import <UIKit/UIKit.h>

/**
 *  The `PDTSimpleCalendarViewCell` class displays a day in the calendar.
 */
@interface PDTSimpleCalendarViewCell : UICollectionViewCell

/**
 *  The delegate of the cell.
 *  Must adopt the `PDTSimpleCalendarViewCellDelegate` protocol.
 *
 *  @see PDTSimpleCalendarViewCellDelegate
 */
@property (nonatomic, weak) id<PDTSimpleCalendarViewCellDelegate> delegate;

/**
 *  Define if the cell is today in the calendar.
 */
@property (nonatomic, assign) BOOL isToday;

/**
 *  Define if the cell is enabled.
 */
@property (nonatomic, assign) BOOL enabled;

/**
 *  Customize the circle behind the day's number color using UIAppearance.
 */
@property (nonatomic, strong) UIColor *circleDefaultColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the color of the circle for today's cell using UIAppearance.
 */
@property (nonatomic, strong) UIColor *circleTodayColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the color of the circle when cell is selected using UIAppearance.
 */
@property (nonatomic, strong) UIColor *circleSelectedColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the day's number using UIAppearance.
 */
@property (nonatomic, strong) UIColor *textDefaultColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize today's number color using UIAppearance.
 */
@property (nonatomic, strong) UIColor *textTodayColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the day's number color when cell is selected using UIAppearance.
 */
@property (nonatomic, strong) UIColor *textSelectedColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the day's number color when cell is disabled using UIAppearance.
 */
@property (nonatomic, strong) UIColor *textDisabledColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the day's font using UIAppearance.
 */
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;

/**
 * Set the date for this cell
 *
 * @param date the date (Midnight GMT).
 *
 * @param calendar the calendar.
 */
- (void) setDate:(NSDate*)date calendar:(NSCalendar*)calendar;

/**
 *  Force the refresh of the colors for the circle and the text
 */
- (void)refreshCellColors;

@end
