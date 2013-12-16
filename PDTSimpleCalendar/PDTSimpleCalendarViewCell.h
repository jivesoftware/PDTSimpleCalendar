//
//  PDTSimpleCalendarViewCell.h
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The `PDTSimpleCalendarViewCell` class displays a day in the calendar.
 */
@interface PDTSimpleCalendarViewCell : UICollectionViewCell

/**
 *  Define if the cell is able to be selected.
 */
@property (nonatomic, assign) BOOL enabled;

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
 *  Set the day number to display for the cell
 *
 *  @param dayNumber from 1 to 31.
 */
- (void)setDayNumber:(NSString *)dayNumber;


@end
