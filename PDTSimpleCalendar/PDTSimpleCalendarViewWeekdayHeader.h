//
//  PDTSimpleCalendarViewWeekdayHeader.h
//  MorningCall
//
//  Created by Yuwen Yan on 3/8/15.
//  Copyright (c) 2015 MorningCall. All rights reserved.
//

#import <UIKit/UIKit.h>

enum PDTSimpleCalendarViewWeekdayTextType
{
    PDTSimpleCalendarViewWeekdayTextType_VeryShort,
    PDTSimpleCalendarViewWeekdayTextType_Short,
    PDTSimpleCalendarViewWeekdayTextType_StandAlone
};

@interface PDTSimpleCalendarViewWeekdayHeader : UIView

/**
 *  Init with calendar
 *
 *  @param calendar the calendar used to generate the view.
 *  @param textType
 */
- (id)initWithCalendar:(NSCalendar *)calendar weekdayTextType:(enum PDTSimpleCalendarViewWeekdayTextType)textType;


/**
 *  The calendar used to generate the view.
 *
 *  If not set, the default value is `[NSCalendar currentCalendar]`
 */
@property (nonatomic, strong) NSCalendar *calendar;

/**
 *  Customize the text color.
 */
- (void)setTextColor:(UIColor *)textColor;

/**
 *  Customize the text font.
 */
- (void)setFont:(UIFont *)font;

/**
 *  Customize the text color.
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor;

@end
