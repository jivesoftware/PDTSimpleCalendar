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

- (void)setCircleColor:(BOOL)today selected:(BOOL)selected otherDate:(BOOL)otherDate;

@end

@implementation PDTSimpleCalendarViewCell {
    NSDate* _date;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _date = nil;
        _isToday = NO;
        _isOtherDate = NO;
        _dayLabel = [[UILabel alloc] init];
        [self.dayLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.dayLabel];

        //Add the Constraints
        [self.dayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.dayLabel setBackgroundColor:[UIColor clearColor]];
        self.dayLabel.layer.cornerRadius = PDTSimpleCalendarCircleSize/2;
        self.dayLabel.layer.masksToBounds = YES;

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dayLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dayLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dayLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:PDTSimpleCalendarCircleSize]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dayLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:PDTSimpleCalendarCircleSize]];

        [self setCircleColor:NO selected:NO otherDate:NO];
    }

    return self;
}

- (void)setDate:(NSDate *)date calendar:(NSCalendar *)calendar
{
    NSString* day = @"";
    if (date && calendar) {
        _date = date;
        NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:_date];
        day = [NSString stringWithFormat:@"%@", @(dateComponents.day)];
    }
    self.dayLabel.text = day;
}

- (void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    [self setCircleColor:isToday selected:self.selected otherDate:self.isOtherDate];
}

- (void)setIsOtherDate:(BOOL)isOtherDate
{
    _isOtherDate = isOtherDate;
    [self setCircleColor:self.isToday selected:self.selected otherDate:isOtherDate];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setCircleColor:self.isToday selected:selected otherDate:self.isOtherDate];
}

- (void)setCircleColor:(BOOL)today selected:(BOOL)selected otherDate:(BOOL)otherDate
{
    UIColor *circleColor = (today) ? [self circleTodayColor] : [self circleDefaultColor];
    UIColor *labelColor = (today) ? [self textTodayColor] : [self textDefaultColor];
    
    if(otherDate && self.delegate) {
        UIColor* otherCircleColor = [self.delegate circleColorForDate:_date];
        if (otherCircleColor) {
            circleColor = otherCircleColor;
        }
        
        UIColor* otherLabelColor = [self.delegate textColorForDate:_date];
        if(otherLabelColor) {
            labelColor = otherLabelColor;
        }
    }
    
    if (selected) {
        circleColor = [self circleSelectedColor];
        labelColor = [self textSelectedColor];
    }

    [self.dayLabel setBackgroundColor:circleColor];
    [self.dayLabel setTextColor:labelColor];
}


#pragma mark - Prepare for Reuse

- (void)prepareForReuse
{
    [super prepareForReuse];
    _date = nil;
    _isToday = NO;
    _isOtherDate = NO;
    [self.dayLabel setText:@""];
    [self setCircleColor:NO selected:NO otherDate:NO];
}

#pragma mark - Circle Color Customization Methods

- (UIColor *)circleDefaultColor
{
    if(_circleDefaultColor == nil) {
        _circleDefaultColor = [[[self class] appearance] circleDefaultColor];
    }

    if(_circleDefaultColor != nil) {
        return _circleDefaultColor;
    }

    return [UIColor whiteColor];
}

- (UIColor *)circleTodayColor
{
    if(_circleTodayColor == nil) {
        _circleTodayColor = [[[self class] appearance] circleTodayColor];
    }

    if(_circleTodayColor != nil) {
        return _circleTodayColor;
    }

    return [UIColor grayColor];
}

- (UIColor *)circleSelectedColor
{
    if(_circleSelectedColor == nil) {
        _circleSelectedColor = [[[self class] appearance] circleSelectedColor];
    }

    if(_circleSelectedColor != nil) {
        return _circleSelectedColor;
    }

    return [UIColor redColor];
}

#pragma mark - Text Label Customizations Color

- (UIColor *)textDefaultColor
{
    if(_textDefaultColor == nil) {
        _textDefaultColor = [[[self class] appearance] textDefaultColor];
    }

    if(_textDefaultColor != nil) {
        return _textDefaultColor;
    }

    return [UIColor blackColor];
}

- (UIColor *)textTodayColor
{
    if(_textTodayColor == nil) {
        _textTodayColor = [[[self class] appearance] textTodayColor];
    }

    if(_textTodayColor != nil) {
        return _textTodayColor;
    }

    return [UIColor whiteColor];
}

- (UIColor *)textSelectedColor
{
    if(_textSelectedColor == nil) {
        _textSelectedColor = [[[self class] appearance] textSelectedColor];
    }

    if(_textSelectedColor != nil) {
        return _textSelectedColor;
    }

    return [UIColor whiteColor];
}

@end
