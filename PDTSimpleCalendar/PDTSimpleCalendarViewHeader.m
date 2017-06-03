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

+ (void)initialize {
    // Set the UIAppearance default values.
    if (self == [PDTSimpleCalendarViewHeader class]) {
        PDTSimpleCalendarViewHeader *proxy = [PDTSimpleCalendarViewHeader appearance];

        [proxy setSeparatorColor: [UIColor lightGrayColor]];

        [proxy setTextColor: [UIColor blackColor]];
        [proxy setTextFont: [UIFont systemFontOfSize: PDTSimpleCalendarHeaderTextSize]];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:self.textFont];
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

@end
