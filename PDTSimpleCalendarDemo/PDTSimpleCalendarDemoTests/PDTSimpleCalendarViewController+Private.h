//
//  PDTSimpleCalendarViewController+Private.h
//  PDTSimpleCalendarDemo
//
//  Created by Jerome Miglino on 3/10/14.
//  Copyright (c) 2014 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewController.h"

@interface PDTSimpleCalendarViewController (Private)

@property (nonatomic, readonly) NSDate *firstDateMonth;
@property (nonatomic, readonly) NSDate *lastDateMonth;
@property (nonatomic, assign) NSUInteger daysPerWeek;

@end
