//
//  PDTSimpleCalendarViewCellSnapshotTests.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 8/10/15.
//  Copyright 2015 Jive Software. All rights reserved.
//

#import "PDTSimpleCalendarViewCell.h"
#import "FBSnapshotTestCase.h"

@interface PDTSimpleCalendarViewCellSnapshotTests : FBSnapshotTestCase
@property (nonatomic, strong) PDTSimpleCalendarViewCell *cell;
@end

@implementation PDTSimpleCalendarViewCellSnapshotTests

- (void)setUp {
    [super setUp];

    self.recordMode = NO;
}

- (void)tearDown {
    [self resetAppearanceProxy];
    [super tearDown];
}

- (void)testDefaultValue {
    FBSnapshotVerifyView([self testCell], nil);
}

- (void)testIsToday {
    PDTSimpleCalendarViewCell *testCell = [self testCell];
    testCell.isToday = YES;
    FBSnapshotVerifyView(testCell, nil);
}

- (void)testIsSelected {
    PDTSimpleCalendarViewCell *testCell = [self testCell];
    testCell.selected = YES;
    FBSnapshotVerifyView(testCell, nil);
}

- (void)testAppeareanceProxyDefault {
    [[PDTSimpleCalendarViewCell appearance] setCircleDefaultColor:[UIColor orangeColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextDefaultColor:[UIColor grayColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextDefaultFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]];
    PDTSimpleCalendarViewCell *testCell = [self testCell];
    FBSnapshotVerifyView(testCell, nil);
}

- (void)testAppeareanceProxyToday {
    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor yellowColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextTodayColor:[UIColor lightGrayColor]];
    PDTSimpleCalendarViewCell *testCell = [self testCell];
    testCell.isToday = YES;
    FBSnapshotVerifyView(testCell, nil);
}

- (void)testAppeareanceProxySelected {
    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor greenColor]];
    [[PDTSimpleCalendarViewCell appearance] setTextSelectedColor:[UIColor blackColor]];
    PDTSimpleCalendarViewCell *testCell = [self testCell];
    testCell.selected = YES;
    FBSnapshotVerifyView(testCell, nil);
}

#pragma mark - Helpers

- (void)resetAppearanceProxy {
    [[PDTSimpleCalendarViewCell appearance] setCircleDefaultColor:nil];
    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:nil];
    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:nil];
    [[PDTSimpleCalendarViewCell appearance] setTextDefaultColor:nil];
    [[PDTSimpleCalendarViewCell appearance] setTextSelectedColor:nil];
    [[PDTSimpleCalendarViewCell appearance] setTextTodayColor:nil];
    [[PDTSimpleCalendarViewCell appearance] setTextDisabledColor:nil];
    [[PDTSimpleCalendarViewCell appearance] setTextDefaultFont:nil];
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"dd/MM/yyyy";
    });

    return formatter;
}

- (PDTSimpleCalendarViewCell *)testCell {
    PDTSimpleCalendarViewCell *testCell = [[PDTSimpleCalendarViewCell alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [testCell setDate:[[self dateFormatter] dateFromString:@"28/10/2015"] calendar:[NSCalendar currentCalendar]];

    return testCell;
}

@end