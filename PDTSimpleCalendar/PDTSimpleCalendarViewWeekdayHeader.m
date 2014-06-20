//
//  PDTSimpleCalendarViewWeekdayHeader.m
//  PDTSimpleCalendarDemo
//
//  Created by Jeroen Houtzager on 23-03-14.
//  Copyright (c) 2014 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewWeekdayHeader.h"

@interface PDTSimpleCalendarViewWeekdayHeader ()

// Array of strings with weekday abbreviations
@property (nonatomic, copy) NSArray *weekdayLabels;

@end


@implementation PDTSimpleCalendarViewWeekdayHeader

@synthesize backgroundColor = _backgroundColor;
@synthesize textColor = _textColor;
@synthesize separatorColor = _separatorColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundColor = self.backgroundColor;
        _textColor = self.textColor;
        _separatorColor = self.separatorColor;
    }

    return self;
}

#pragma mark - Fill weekdays

-(void)fillWeekdays {
    if (![self.weekdays count]) {
        return;
    }

    // Create constraint dictionary
    CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] initWithCapacity:[self.weekdays count] + 1];
    NSDictionary *metricsDictionary = @{@"onePixel" : [NSNumber numberWithFloat:onePixel]};

    // Add separator view
    UIView *separatorView = [[UIView alloc] init];
    [separatorView setBackgroundColor:self.separatorColor];
    [self addSubview:separatorView];
    [separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [viewsDictionary setObject:separatorView forKey:@"separatorView"];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[separatorView]|" options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorView(==onePixel)]|" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    // Fill weekdayView with labels
    for (NSUInteger index = 0; index < [self.weekdays count]; index++) {
        UILabel *weekdayLabel = [[UILabel alloc] init];
        weekdayLabel.font = [UIFont systemFontOfSize:12.0];
        weekdayLabel.text = self.weekdays[index];
        weekdayLabel.textColor = self.textColor;
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.backgroundColor = self.backgroundColor;
        [self addSubview:weekdayLabel];
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [viewsDictionary setObject:weekdayLabel forKey:[NSString stringWithFormat:@"weekdayLabel%lu", (unsigned long)index]];
    }

    // Construct horizontal layout string to "|[weekdayLabel0] ... [weekdayLabelN]|"
    NSString *layoutString = @"|[weekdayLabel0]";
    for (NSUInteger index = 1; index < [self.weekdays count]; index++) {
        layoutString = [layoutString stringByAppendingFormat:@"[weekdayLabel%lu(==weekdayLabel0)]", (unsigned long)index];
    }
    layoutString = [layoutString stringByAppendingString:@"|"];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutString options:0 metrics:nil views:viewsDictionary]];

    // Construct vertical layout strings for each label
    for (NSUInteger index = 0; index < [self.weekdays count]; index++) {
        layoutString = [NSString stringWithFormat:@"V:|[weekdayLabel%lu][separatorView]|", (unsigned long)index];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutString options:0 metrics:nil views:viewsDictionary]];
    }
}


#pragma mark - Accessors

-(void)setWeekdays:(NSArray *)weekdays {
    _weekdays = [weekdays copy];
    [self fillWeekdays];
}


-(void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;

    // set own background color and that of the labels
    [super setBackgroundColor:backgroundColor];
    for (UILabel *label in self.weekdayLabels) {
        label.backgroundColor = backgroundColor;
    }
}


-(void)setTextColor:(UIColor *)weekdayHeaderTextColor {
    for (UILabel *label in self.weekdayLabels) {
        label.textColor = weekdayHeaderTextColor;
    }
}


- (UIColor *)textColor
{
    if (!_textColor) {
        _textColor = [[[self class] appearance] textColor];
    }

    if (_textColor) {
        return _textColor;
    }

    return [UIColor grayColor];
}

- (UIColor *)separatorColor
{
    if (!_separatorColor) {
        _separatorColor = [[[self class] appearance] separatorColor];
    }

    if (_separatorColor) {
        return _separatorColor;
    }

    return [UIColor lightGrayColor];
}

- (UIColor *)backgroundColor
{
    if (!_backgroundColor) {
        _backgroundColor = [[[self class] appearance] backgroundColor];
    }

    if (_backgroundColor) {
        return _backgroundColor;
    }

    return [UIColor colorWithWhite:0.97 alpha:1.0];
}



@end
