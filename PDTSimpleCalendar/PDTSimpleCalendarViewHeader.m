//
//  PDTSimpleCalendarViewHeader.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/8/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewHeader.h"

const CGFloat kPDTSimpleCalendarHeaderTextSize = 12.0f;

@interface PDTSimpleCalendarViewHeader ()

@property (nonatomic, nonnull, retain) UIView *separatorView;

@end

@implementation PDTSimpleCalendarViewHeader

+ (void)initialize {
    if (self == [PDTSimpleCalendarViewHeader class]) {
        // Set the UIAppearance default values.
        PDTSimpleCalendarViewHeader *proxy = [PDTSimpleCalendarViewHeader appearance];

        [proxy setSeparatorColor: [UIColor lightGrayColor]];

        [proxy setTextColor: [UIColor blackColor]];
        [proxy setTextFont: [UIFont systemFontOfSize: kPDTSimpleCalendarHeaderTextSize]];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

        _separatorView = [[UIView alloc] init];
        [self addSubview: _separatorView];
        [_separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];

        CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
        NSDictionary *metricsDictionary = @{@"onePixel" : [NSNumber numberWithFloat:onePixel]};
        NSDictionary *viewsDictionary = @{@"titleLabel" : _titleLabel, @"separatorView" : _separatorView};

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(==10)-[titleLabel]-(==10)-|" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]|" options:0 metrics:nil views:viewsDictionary]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[separatorView]|" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorView(==onePixel)]|" options:0 metrics:metricsDictionary views:viewsDictionary]];
    }

    return self;
}

- (void) didMoveToWindow {

    [super didMoveToWindow];

    if (self.window) {
        // Use the UIAppearance properties only after they been finalized by being
        // inserted into a live window.
        self.separatorView.backgroundColor = self.separatorColor;

        self.titleLabel.font = self.textFont;
        self.titleLabel.textColor = self.textColor;
        self.titleLabel.backgroundColor = UIColor.clearColor;
    }
}

@end
