//
//  PDTSimpleCalendarViewHeader.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/8/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewHeader.h"

const CGFloat PDTSimpleCalendarHeaderTextSize = 12.0f;

@implementation PDTSimpleCalendarViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:self.font];
        [_titleLabel setTextColor:self.textColor];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_titleLabel];
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

        UIView *separatorView = [[UIView alloc] init];
        [separatorView setBackgroundColor:self.separatorColor];
        [self addSubview:separatorView];
        [separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];

        CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
        NSDictionary *metricsDictionary = @{@"onePixel" : [NSNumber numberWithFloat:onePixel]};
        NSDictionary *viewsDictionary = @{@"titleLabel" : self.titleLabel, @"separatorView" : separatorView};

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(==10)-[titleLabel]-(==10)-|" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]|" options:0 metrics:nil views:viewsDictionary]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[separatorView]|" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorView(==onePixel)]|" options:0 metrics:metricsDictionary views:viewsDictionary]];
    }

    return self;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    [_titleLabel setTextAlignment:self.textAlignment];
}

#pragma mark - Colors

- (UIFont *)font
{
    if(_font == nil) {
        _font = [[[self class] appearance] font];
    }
    
    if(_font != nil) {
        return _font;
    }
    
    return [UIFont systemFontOfSize:PDTSimpleCalendarHeaderTextSize];
}

- (UIColor *)textColor
{
    if(_textColor == nil) {
        _textColor = [[[self class] appearance] textColor];
    }

    if(_textColor != nil) {
        return _textColor;
    }

    return [UIColor grayColor];
}

- (UIColor *)separatorColor
{
    if(_separatorColor == nil) {
        _separatorColor = [[[self class] appearance] separatorColor];
    }

    if(_separatorColor != nil) {
        return _separatorColor;
    }

    return [UIColor lightGrayColor];
}


@end
