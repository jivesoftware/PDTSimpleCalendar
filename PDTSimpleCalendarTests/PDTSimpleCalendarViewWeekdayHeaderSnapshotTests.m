//
//  PDTSimpleCalendarViewWeekdayHeaderSnapshotTests.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 8/7/15.
//  Copyright 2015 Jive Software. All rights reserved.
//

#import "PDTSimpleCalendarViewWeekdayHeader.h"
#import "FBSnapshotTestCase.h"

@interface PDTSimpleCalendarViewWeekdayHeaderSnapshotTests : FBSnapshotTestCase

@end

@implementation PDTSimpleCalendarViewWeekdayHeaderSnapshotTests

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
    [PDTSimpleCalendarViewWeekdayHeader appearance].headerBackgroundColor = nil;
    [PDTSimpleCalendarViewWeekdayHeader appearance].textFont = nil;
    [PDTSimpleCalendarViewWeekdayHeader appearance].textColor = nil;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testWeekdayTextTypeShort {
    PDTSimpleCalendarViewWeekdayHeader *weekdayHeaderView = [self weekdayHeaderViewWithType:PDTSimpleCalendarViewWeekdayTextTypeShort];
    FBSnapshotVerifyView(weekdayHeaderView, nil);
}

- (void)testWeekdayTextTypeVeryShort {
    PDTSimpleCalendarViewWeekdayHeader *weekdayHeaderView = [self weekdayHeaderViewWithType:PDTSimpleCalendarViewWeekdayTextTypeVeryShort];
    FBSnapshotVerifyView(weekdayHeaderView, nil);
}

- (void)testWeekdayTextTypeStandAlone {
    PDTSimpleCalendarViewWeekdayHeader *weekdayHeaderView = [self weekdayHeaderViewWithType:PDTSimpleCalendarViewWeekdayTextTypeStandAlone];
    FBSnapshotVerifyView(weekdayHeaderView, nil);
}

- (void)testHeaderBackgroundColor {
    [PDTSimpleCalendarViewWeekdayHeader appearance].headerBackgroundColor = [UIColor lightGrayColor];
    PDTSimpleCalendarViewWeekdayHeader *weekdayHeaderView = [self weekdayHeaderViewWithType:PDTSimpleCalendarViewWeekdayTextTypeVeryShort];
    FBSnapshotVerifyView(weekdayHeaderView, nil);
}

- (void)testHeaderTextFont {
    [PDTSimpleCalendarViewWeekdayHeader appearance].textFont = [UIFont boldSystemFontOfSize:8];
    PDTSimpleCalendarViewWeekdayHeader *weekdayHeaderView = [self weekdayHeaderViewWithType:PDTSimpleCalendarViewWeekdayTextTypeVeryShort];
    FBSnapshotVerifyView(weekdayHeaderView, nil);
}

- (void)testHeaderTextColor {
    [PDTSimpleCalendarViewWeekdayHeader appearance].textColor = [UIColor orangeColor];
    PDTSimpleCalendarViewWeekdayHeader *weekdayHeaderView = [self weekdayHeaderViewWithType:PDTSimpleCalendarViewWeekdayTextTypeVeryShort];
    FBSnapshotVerifyView(weekdayHeaderView, nil);
}

#pragma mark - Helpers

- (PDTSimpleCalendarViewWeekdayHeader *)weekdayHeaderViewWithType:(PDTSimpleCalendarViewWeekdayTextType)type {
    PDTSimpleCalendarViewWeekdayHeader *weekdayHeaderView = [[PDTSimpleCalendarViewWeekdayHeader alloc] initWithCalendar:[NSCalendar currentCalendar] weekdayTextType:type];
    [weekdayHeaderView setFrame:CGRectMake(0, 0, 320, PDTSimpleCalendarWeekdayHeaderHeight)];

    return  weekdayHeaderView;
}

@end