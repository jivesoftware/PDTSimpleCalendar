//
//  PDTSimpleCalendarViewCell.h
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

@protocol PDTSimpleCalendarViewCellDelegate <NSObject>

@required

/**
 * Asks the delegate for the circle color for a custom added date
 *
 * @param date the date (Midnight GMT).
 */
- (UIColor*)circleColorForDate:(NSDate*)date;

/**
 * Asks the delegate for the text color for a custom added date
 *
 * @param date the date (Midnight GMT).
 */
- (UIColor*)textColorForDate:(NSDate*)date;

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
 *  Define if the cell is today in the calendar.
 */
@property (nonatomic, assign) BOOL isOtherDate;

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
 * Sets the date for this cell
 *
 * @param date the date (Midnight GMT).
 *
 * @param calendar the calendar.
 */
- (void) setDate:(NSDate*)date calendar:(NSCalendar*)calendar;
@end
