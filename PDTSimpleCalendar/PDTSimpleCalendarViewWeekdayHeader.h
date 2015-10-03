//
//  PDTSimpleCalendarViewWeekdayHeader.h
//  MorningCall
//
//  Created by Yuwen Yan on 3/8/15.
//  Copyright (c) 2015 MorningCall. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat PDTSimpleCalendarWeekdayHeaderSize;
extern const CGFloat PDTSimpleCalendarWeekdayHeaderHeight;

typedef NS_ENUM (NSInteger, PDTSimpleCalendarViewWeekdayTextType) {
    PDTSimpleCalendarViewWeekdayTextTypeVeryShort = 0,
    PDTSimpleCalendarViewWeekdayTextTypeShort,
    PDTSimpleCalendarViewWeekdayTextTypeStandAlone
};

@interface PDTSimpleCalendarViewWeekdayHeader : UIView

/**
 *  Init with calendar
 *
 *  @param calendar the calendar used to generate the view.
 *  @param textType
 */
- (id)initWithCalendar:(NSCalendar *)calendar weekdayTextType:(PDTSimpleCalendarViewWeekdayTextType)textType;

/**
 *  Customize the text color.
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the text font.
 */
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

/**
 *  Customize the header background color.
 */
@property (nonatomic, strong) UIColor *headerBackgroundColor UI_APPEARANCE_SELECTOR;

@end
