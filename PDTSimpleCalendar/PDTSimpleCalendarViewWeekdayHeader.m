//
//  PDTSimpleCalendarViewWeekdayHeader.m
//  MorningCall
//
//  Created by Yuwen Yan on 3/8/15.
//  Copyright (c) 2015 MorningCall. All rights reserved.
//

#import "PDTSimpleCalendarViewWeekdayHeader.h"

const CGFloat PDTSimpleCalendarWeekdayHeaderSize = 12.0f;
const CGFloat PDTSimpleCalendarWeekdayHeaderHeight = 20.0f;

@implementation PDTSimpleCalendarViewWeekdayHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCalendar:(NSCalendar *)calendar weekdayTextType:(PDTSimpleCalendarViewWeekdayTextType)textType
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = self.headerBackgroundColor;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.calendar = calendar;
        NSArray *weekdaySymbols = nil;
        
        switch (textType) {
            case PDTSimpleCalendarViewWeekdayTextTypeVeryShort:
                weekdaySymbols = [dateFormatter veryShortWeekdaySymbols];
                break;
            case PDTSimpleCalendarViewWeekdayTextTypeShort:
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
        
        NSMutableArray *weekdaySymbolLabelNameArr = [NSMutableArray array];
        NSMutableDictionary *weekdaySymbolLabelDict = [NSMutableDictionary dictionary];
        for (NSInteger index = 0; index < adjustedSymbols.count; index++)
        {
            NSString *labelName = [NSString stringWithFormat:@"weekdaySymbolLabel%d", (int)index];
            [weekdaySymbolLabelNameArr addObject:labelName];
            
            UILabel *weekdaySymbolLabel = [[UILabel alloc] init];
            weekdaySymbolLabel.font = self.textFont;
            weekdaySymbolLabel.text = [adjustedSymbols[index] uppercaseString];
            weekdaySymbolLabel.textColor = self.textColor;
            weekdaySymbolLabel.textAlignment = NSTextAlignmentCenter;
            weekdaySymbolLabel.backgroundColor = [UIColor clearColor];
            weekdaySymbolLabel.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self addSubview:weekdaySymbolLabel];
            
            [weekdaySymbolLabelDict setObject:weekdaySymbolLabel forKey:labelName];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[%@]|", labelName] options:0 metrics:nil views:weekdaySymbolLabelDict]];
            
            if (firstWeekdaySymbolLabel == nil) {
                firstWeekdaySymbolLabel = weekdaySymbolLabel;
            } else {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:weekdaySymbolLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:firstWeekdaySymbolLabel attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
            }
        }
        
        NSString *layoutString = [NSString stringWithFormat:@"|[%@(>=0)]|", [weekdaySymbolLabelNameArr componentsJoinedByString:@"]["]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutString options:NSLayoutFormatAlignAllCenterY metrics:nil views:weekdaySymbolLabelDict]];

    }
    
    return self;
}

- (UIColor *)textColor
{
    if(_textColor == nil) {
        _textColor = [[[self class] appearance] textColor];
    }
    
    if(_textColor != nil) {
        return _textColor;
    }
    
    return [UIColor blackColor];
}

- (UIFont *)textFont
{
    if(_textFont == nil) {
        _textFont = [[[self class] appearance] textFont];
    }
    
    if(_textFont != nil) {
        return _textFont;
    }
    
    return [UIFont systemFontOfSize:PDTSimpleCalendarWeekdayHeaderSize];
}

- (UIColor *)headerBackgroundColor
{
    if(_headerBackgroundColor == nil) {
        _headerBackgroundColor = [[[self class] appearance] headerBackgroundColor];
    }
    
    if(_headerBackgroundColor != nil) {
        return _headerBackgroundColor;
    }
    
    return [UIColor whiteColor];
}

@end
