//
//  PDTSimpleCalendarViewHeader.h
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/8/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The `PDTSimpleCalendarViewHeader` class displays the month name and year.
 */
@interface PDTSimpleCalendarViewHeader : UICollectionReusableView

/**
 *  Label that display the month and year
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  Month text text alignment.
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/** @name Customizing Appearance */

/**
 *  Customize the Month text font.
 */
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;

/**
 *  Customize the Month text color display.
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the separator color between the month name and the dates.
 */
@property (nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;

@end
