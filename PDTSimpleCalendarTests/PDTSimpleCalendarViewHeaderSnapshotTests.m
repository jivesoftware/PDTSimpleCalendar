//
//  PDTSimpleCalendarViewHeaderSnapshotTests.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 8/9/15.
//  Copyright 2015 Jive Software. All rights reserved.
//

#import "PDTSimpleCalendarViewHeader.h"
#import "PDTSimpleCalendarViewFlowLayout.h"
#import "FBSnapshotTestCase.h"

@interface PDTSimpleCalendarViewHeaderSnapshotTests : FBSnapshotTestCase
@end

@implementation PDTSimpleCalendarViewHeaderSnapshotTests

- (void)setUp {
    [super setUp];
    self.recordMode = NO;

    //Reset Appearance
    [[PDTSimpleCalendarViewHeader appearance] setTextColor:nil];
    [[PDTSimpleCalendarViewHeader appearance] setTextFont:nil];
    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:nil];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDefaultSettings {
    PDTSimpleCalendarViewHeader *headerView = [self headerView];
    FBSnapshotVerifyView(headerView, nil);
}

- (void)testTextColorAppearance {
    [[PDTSimpleCalendarViewHeader appearance] setTextColor:[UIColor lightGrayColor]];
    PDTSimpleCalendarViewHeader *headerView = [self headerView];
    FBSnapshotVerifyView(headerView, nil);
}

- (void)testTextFontAppearance {
    [[PDTSimpleCalendarViewHeader appearance] setTextFont:[UIFont boldSystemFontOfSize:9]];
    PDTSimpleCalendarViewHeader *headerView = [self headerView];
    FBSnapshotVerifyView(headerView, nil);
}

- (void)testSeparatorColorAppearance {
    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];
    PDTSimpleCalendarViewHeader *headerView = [self headerView];
    FBSnapshotVerifyView(headerView, nil);
}

#pragma mark - Helpers

- (PDTSimpleCalendarViewHeader *)headerView {
    PDTSimpleCalendarViewHeader *headerView = [[PDTSimpleCalendarViewHeader alloc] init];
    headerView.frame = CGRectMake(0, 0, 320, PDTSimpleCalendarFlowLayoutHeaderHeight);
    headerView.titleLabel.text = @"AUGUST 2015";

    return headerView;
}


@end