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
 *  Asks the delegate for the text color for a specific date.
 *
 *  @param cell the current cell
 *  @param date the date associated with the cell
 *
 *  @return The text desired color
 */
- (UIColor *)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell textColorForDate:(NSDate *)date;

/**
 *  Asks the delegate for the circle color for a specific date.
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

/*
 *  Define if the cell is able to be selected.
 */
@property (nonatomic, assign) BOOL isEnabled;

/**
 *  Define if the cell is today in the calendar.
 */
@property (nonatomic, assign) BOOL isToday;

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
 * Sets the day text for this cell
 *
 * @param dayText  text to show for this cell
 */
- (void)setDayText:(NSString*)dayText;

/**
 *  Force the refresh of the colors for the circle and the text
 */
- (void)refreshCellColors;

@end
