//
//  PDTSimpleCalendarViewCell.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewCell.h"

const CGFloat kPDTSimpleCalendarCircleSize = 32.0f;

@interface PDTSimpleCalendarViewCell ()

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) NSDate *date;

@end

@implementation PDTSimpleCalendarViewCell

#pragma mark - Class Methods

+ (void)initialize {
    if (self == [PDTSimpleCalendarViewCell class]) {
        // Set the UIAppearance default values.
        PDTSimpleCalendarViewCell *proxy = [PDTSimpleCalendarViewCell appearance];

        proxy.circleDefaultColor  = [UIColor whiteColor];
        proxy.circleTodayColor    = [UIColor grayColor];
        proxy.circleSelectedColor = [UIColor redColor];

        proxy.textDefaultColor  = [UIColor blackColor];
        proxy.textTodayColor    = [UIColor whiteColor];
        proxy.textSelectedColor = [UIColor whiteColor];
        proxy.textDisabledColor = [UIColor lightGrayColor];
        proxy.textDefaultFont   = [UIFont systemFontOfSize: 17.0];
    }
}

+ (NSString *)formatDate:(NSDate *)date withCalendar:(NSCalendar *)calendar
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    return [PDTSimpleCalendarViewCell stringFromDate:date withDateFormatter:dateFormatter withCalendar:calendar];
}

+ (NSString *)formatAccessibilityDate:(NSDate *)date withCalendar:(NSCalendar *)calendar
{
    NSDateFormatter *dateFormatter = [self accessibilityDateFormatter];
    return [PDTSimpleCalendarViewCell stringFromDate:date withDateFormatter:dateFormatter withCalendar:calendar];
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"d";
    });
    return dateFormatter;
}

+ (NSDateFormatter *)accessibilityDateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    });
    return dateFormatter;
}

+ (NSString *)stringFromDate:(NSDate *)date withDateFormatter:(NSDateFormatter *)dateFormatter withCalendar:(NSCalendar *)calendar {
    //Test if the calendar is different than the current dateFormatter calendar property
    if (![dateFormatter.calendar isEqual:calendar]) {
        dateFormatter.calendar = calendar;
    }
    return [dateFormatter stringFromDate:date];
}

#pragma mark - Instance Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _date = nil;
        _today = NO;
        _dayLabel = [[UILabel alloc] init];
        [_dayLabel setTextAlignment: NSTextAlignmentCenter];
        [self.contentView addSubview: _dayLabel];

        //Add the Constraints
        [_dayLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
        [_dayLabel setBackgroundColor:[UIColor clearColor]];
        _dayLabel.layer.cornerRadius = kPDTSimpleCalendarCircleSize/2;
        _dayLabel.layer.masksToBounds = YES;

        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem: _dayLabel attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual toItem: self.contentView attribute: NSLayoutAttributeCenterX multiplier: 1.0 constant: 0.0]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem: _dayLabel attribute: NSLayoutAttributeCenterY relatedBy: NSLayoutRelationEqual toItem: self.contentView attribute: NSLayoutAttributeCenterY multiplier: 1.0 constant: 0.0]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem: _dayLabel attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: kPDTSimpleCalendarCircleSize]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem: _dayLabel attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: kPDTSimpleCalendarCircleSize]];
    }
    return self;
}

- (void) didMoveToWindow {
    // Use the UIAppearance properties only after they been finalized by being
    // inserted into a live window.
    [super didMoveToWindow];

    if (self.window) {
        [self.dayLabel setFont: self.textDefaultFont];
        [self setCircleColor: self.isToday selected: self.selected];
    }
}

- (void)setDate:(NSDate *)date calendar:(NSCalendar *)calendar
{
    NSString* day = @"";
    NSString* accessibilityDay = @"";
    if (date && calendar) {
        _date = date;
        day = [PDTSimpleCalendarViewCell formatDate:date withCalendar:calendar];
        accessibilityDay = [PDTSimpleCalendarViewCell formatAccessibilityDate:date withCalendar:calendar];
    }
    self.dayLabel.text = day;
    self.dayLabel.accessibilityLabel = accessibilityDay;
}

@dynamic text;

- (NSString *) text {

    return self.dayLabel.text;
}

- (void) setText: (NSString *)text {

    self.dayLabel.text = text;
    self.dayLabel.accessibilityLabel = text;
}

- (void) setToday: (BOOL) today
{
    _today = today;
    [self setCircleColor: today selected: self.selected];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setCircleColor:self.isToday selected:selected];
}


- (void)setCircleColor:(BOOL)today selected:(BOOL)selected
{
    UIColor *circleColor = (today) ? [self circleTodayColor] : [self circleDefaultColor];
    UIColor *labelColor = (today) ? [self textTodayColor] : [self textDefaultColor];

    if (self.date && self.delegate) {
        if ([self.delegate respondsToSelector:@selector(simpleCalendarViewCell:shouldUseCustomColorsForDate:)] && [self.delegate simpleCalendarViewCell:self shouldUseCustomColorsForDate:self.date]) {

            if ([self.delegate respondsToSelector:@selector(simpleCalendarViewCell:textColorForDate:)] && [self.delegate simpleCalendarViewCell:self textColorForDate:self.date]) {
                labelColor = [self.delegate simpleCalendarViewCell:self textColorForDate:self.date];
            }

            if ([self.delegate respondsToSelector:@selector(simpleCalendarViewCell:circleColorForDate:)] && [self.delegate simpleCalendarViewCell:self circleColorForDate:self.date]) {
                circleColor = [self.delegate simpleCalendarViewCell:self circleColorForDate:self.date];
            }
        }
    }
    if (selected) {
        circleColor = [self circleSelectedColor];
        labelColor = [self textSelectedColor];
    }
    [self.dayLabel setBackgroundColor:circleColor];
    [self.dayLabel setTextColor:labelColor];
}

- (void)refreshCellColors
{
    [self setCircleColor:self.isToday selected:self.isSelected];
}

#pragma mark - Prepare for Reuse

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.date = nil;
    self.today = NO;

    // TODO: File a Doc bug, Thaddeus Cooper in DTS. Quinn & Larry, Kirby Turner.
    PDTSimpleCalendarViewCell *proxy = [PDTSimpleCalendarViewCell appearance];

    if (_circleDefaultColor)  { self.circleDefaultColor  = proxy.circleDefaultColor; }
    if (_circleTodayColor)    { self.circleTodayColor    = proxy.circleTodayColor; }
    if (_circleSelectedColor) { self.circleSelectedColor = proxy.circleSelectedColor; }

    if (_textDefaultColor)  { self.textDefaultColor  = proxy.textDefaultColor; }
    if (_textTodayColor)    { self.textTodayColor    = proxy.textTodayColor; }
    if (_textSelectedColor) { self.textSelectedColor = proxy.textSelectedColor; }
    if (_textDisabledColor) { self.textDisabledColor = proxy.textDisabledColor; }
    if (_textDefaultFont)   { self.textDefaultFont   = proxy.textDefaultFont; }

    self.dayLabel.text = @"";
    self.dayLabel.backgroundColor =  proxy.circleDefaultColor;
    self.dayLabel.textColor = proxy.textDefaultColor;
}

#pragma mark - Text Label Customizations Color

- (void) setTextDefaultColor: (UIColor *) textDefaultColor
{
    _textDefaultColor = textDefaultColor ?: [[[self class] appearance] textDefaultColor];
    self.dayLabel.textColor = _textDefaultColor;
}

@end
