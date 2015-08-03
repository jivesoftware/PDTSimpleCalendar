//
//  PDTSimpleCalendarViewWeekdayHeader.m
//  MorningCall
//
//  Created by Yuwen Yan on 3/8/15.
//  Copyright (c) 2015 MorningCall. All rights reserved.
//

#import "PDTSimpleCalendarViewWeekdayHeader.h"

@interface PDTSimpleCalendarViewWeekdayHeader ()

/**
 *  Dictionary of weekday synbol label
 */
@property (nonatomic, strong) NSMutableDictionary *weekdaySymbolLabelDict;
@property (nonatomic, strong) NSMutableArray *weekdaySymbolLabelNameArr;

@end

@implementation PDTSimpleCalendarViewWeekdayHeader

@synthesize calendar = _calendar;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCalendar:(NSCalendar *)calendar weekdayTextType:(enum PDTSimpleCalendarViewWeekdayTextType)textType
{
    self = [super init];
    if (self)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.calendar = calendar;
        NSArray *weekdaySymbols = nil;
        
        switch (textType) {
            case PDTSimpleCalendarViewWeekdayTextType_VeryShort:
                weekdaySymbols = [dateFormatter veryShortWeekdaySymbols];
                break;
            case PDTSimpleCalendarViewWeekdayTextType_Short:
                weekdaySymbols = [dateFormatter shortWeekdaySymbols];
                break;
            default:
                weekdaySymbols = [dateFormatter standaloneWeekdaySymbols];
                break;
        }
        
        NSMutableArray *adjustedSymbols = [NSMutableArray arrayWithArray:weekdaySymbols];
        for (NSInteger index = 0; index < (1 - calendar.firstWeekday + weekdaySymbols.count); index++) {
            NSString *lastObject = [adjustedSymbols lastObject];
            [adjustedSymbols removeLastObject];
            [adjustedSymbols insertObject:lastObject atIndex:0];
        }
        
        if (adjustedSymbols.count == 0) {
            return self;
        }
        
        UILabel *firstWeekdaySymbolLabel = nil;
        
        self.weekdaySymbolLabelNameArr = [NSMutableArray array];
        self.weekdaySymbolLabelDict = [NSMutableDictionary dictionary];
        for (NSInteger index = 0; index < adjustedSymbols.count; index++)
        {
            NSString *labelName = [NSString stringWithFormat:@"weekdaySymbolLabel%d", (int)index];
            [self.weekdaySymbolLabelNameArr addObject:labelName];
            
            UILabel *weekdaySymbolLabel = [[UILabel alloc] init];
            weekdaySymbolLabel.font = [UIFont systemFontOfSize:12.0];
            weekdaySymbolLabel.text = [adjustedSymbols[index] uppercaseString];
            weekdaySymbolLabel.textColor = [UIColor blackColor];
            weekdaySymbolLabel.textAlignment = NSTextAlignmentCenter;
            weekdaySymbolLabel.backgroundColor = self.backgroundColor;
            weekdaySymbolLabel.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self addSubview:weekdaySymbolLabel];
            weekdaySymbolLabel.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self.weekdaySymbolLabelDict setObject:weekdaySymbolLabel forKey:labelName];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[%@]|", labelName] options:0 metrics:nil views:self.weekdaySymbolLabelDict]];
            
            if (firstWeekdaySymbolLabel == nil) {
                firstWeekdaySymbolLabel = weekdaySymbolLabel;
            } else {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:weekdaySymbolLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:firstWeekdaySymbolLabel attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
            }
        }
        
        NSString *layoutString = [NSString stringWithFormat:@"|[%@(>=0)]|", [self.weekdaySymbolLabelNameArr componentsJoinedByString:@"]["]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutString options:NSLayoutFormatAlignAllCenterY metrics:nil views:self.weekdaySymbolLabelDict]];

    }
    
    return self;
}

- (NSCalendar *)calendar
{
    if (!_calendar) {
        [self setCalendar:[NSCalendar currentCalendar]];
    }
    return _calendar;
}

- (void)setTextColor:(UIColor *)textColor
{
    for (NSString *labelName in self.weekdaySymbolLabelDict.keyEnumerator) {
        [(UILabel *)[self.weekdaySymbolLabelDict objectForKey:labelName] setTextColor:textColor];
    }
}

- (void)setFont:(UIFont *)font
{
    for (NSString *labelName in self.weekdaySymbolLabelDict.keyEnumerator) {
        [(UILabel *)[self.weekdaySymbolLabelDict objectForKey:labelName] setFont:font];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    for (NSString *labelName in self.weekdaySymbolLabelDict.keyEnumerator) {
        [(UILabel *)[self.weekdaySymbolLabelDict objectForKey:labelName] setBackgroundColor:backgroundColor];
    }
}

@end
