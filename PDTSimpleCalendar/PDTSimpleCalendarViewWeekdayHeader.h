//
//  PDTSimpleCalendarViewWeekdayHeader.h
//  PDTSimpleCalendarDemo
//
//  Created by Jeroen Houtzager on 23-03-14.
//  Copyright (c) 2014 Producteev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDTSimpleCalendarViewWeekdayHeader : UIView

// Array of strings with weekday abbreviations
@property (nonatomic, copy) NSArray *weekdays;

@property (nonatomic, copy) UIColor *textColor UI_APPEARANCE_SELECTOR;;
@property (nonatomic, copy) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;;
@property (nonatomic, copy) UIColor *separatorColor UI_APPEARANCE_SELECTOR;;

@end
