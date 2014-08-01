//
//  PDTSimpleCalendarViewCell.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewCell.h"

const CGFloat PDTSimpleCalendarCircleSize = 32.0f;

@interface PDTSimpleCalendarViewCell ()

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, strong) UIColor *labelColor;

@end

@implementation PDTSimpleCalendarViewCell

#pragma mark - Class Method

+ (NSString *)formatDate:(NSDate *)date withCalendar:(NSCalendar *)calendar
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"d";
    });

    //Test if the calendar is different than the current dateFormatter calendar property
    if (![dateFormatter.calendar isEqual:calendar]) {
        dateFormatter.calendar = calendar;
    }

    return [dateFormatter stringFromDate:date];
}

#pragma mark - Instance Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _date = nil;
        _isToday = NO;
        _enabled = YES;
    }

    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self circleDefaultColor].CGColor);
    CGContextFillRect(context, self.bounds);

    CGContextSetFillColorWithColor(context, self.circleColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake((self.bounds.size.width - PDTSimpleCalendarCircleSize) / 2,
                                                   (self.bounds.size.height - PDTSimpleCalendarCircleSize) / 2,
                                                   PDTSimpleCalendarCircleSize,
                                                   PDTSimpleCalendarCircleSize));
    
    CGFloat inset = self.font.lineHeight;
    CGRect textBounds = CGRectMake(0, (self.bounds.size.height - inset) / 2, self.bounds.size.width, self.bounds.size.height - inset);
    
    CGContextSetFillColorWithColor(context, self.labelColor.CGColor);
    
    [[PDTSimpleCalendarViewCell formatDate:self.date withCalendar:self.calendar] drawInRect:textBounds withFont:self.font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
}

- (void)setDate:(NSDate *)date calendar:(NSCalendar *)calendar
{
    if (date && calendar) {
        _date = date;
        _calendar = calendar;
    }
}

- (void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    [self setCircleColor:isToday selected:self.selected];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setCircleColor:self.isToday selected:selected];
    
    if (selected == YES) {
        [self bounce];
    }
}

- (void)setCircleColor:(BOOL)today selected:(BOOL)selected
{
    self.circleColor = (today) ? [self circleTodayColor] : [self circleDefaultColor];
    self.labelColor = (today) ? [self textTodayColor] : [self textDefaultColor];

    if (self.date && self.delegate) {
        if ([self.delegate respondsToSelector:@selector(simpleCalendarViewCell:shouldUseCustomColorsForDate:)] && [self.delegate simpleCalendarViewCell:self shouldUseCustomColorsForDate:self.date]) {

            if ([self.delegate respondsToSelector:@selector(simpleCalendarViewCell:textColorForDate:)] && [self.delegate simpleCalendarViewCell:self textColorForDate:self.date]) {
                self.labelColor = [self.delegate simpleCalendarViewCell:self textColorForDate:self.date];
            }

            if ([self.delegate respondsToSelector:@selector(simpleCalendarViewCell:circleColorForDate:)] && [self.delegate simpleCalendarViewCell:self circleColorForDate:self.date]) {
                self.circleColor = [self.delegate simpleCalendarViewCell:self circleColorForDate:self.date];
            }
        }
    }
    
    if (selected) {
        self.circleColor = [self circleSelectedColor];
        self.labelColor = [self textSelectedColor];
    }
    
    if (self.enabled == NO) {
        self.circleColor = self.circleDefaultColor;
        self.labelColor = self.textDisabledColor;
    }
    
    [self setNeedsDisplay];
}


- (void)refreshCellColors
{
    [self setCircleColor:self.isToday selected:self.isSelected];
}

- (void)bounce
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
        
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                         } completion:nil];

    }
}

#pragma mark - Prepare for Reuse

- (void)prepareForReuse
{
    [super prepareForReuse];
    _date = nil;
    _circleColor = nil;
    _labelColor = nil;
    _isToday = NO;
    _enabled = YES;
}

@end
