//
//  PDTSimpleCalendarViewControllerSnapshotTests.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 8/9/15.
//  Copyright 2015 Jive Software. All rights reserved.
//

#import "PDTSimpleCalendarViewController.h"
#import "FBSnapshotTestCase.h"

@interface PDTSimpleCalendarViewControllerSnapshotTests : FBSnapshotTestCase
@property (nonatomic, strong) PDTSimpleCalendarViewController *calendarViewController;
@end

@implementation PDTSimpleCalendarViewControllerSnapshotTests

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
    self.calendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    self.calendarViewController.firstDate = [[self dateFormatter] dateFromString:@"01/05/2015"];
}

- (void)tearDown {
    self.calendarViewController = nil;
    [super tearDown];
}

- (void)testWithCustomFirstDate {
    [self prepareCalendarViewControllerForTest];
    FBSnapshotVerifyView(self.calendarViewController.view, nil);
}

- (void)testWithFirstDateNotTheFirst {
    self.calendarViewController.firstDate = [[self dateFormatter] dateFromString:@"09/05/2015"];
    [self prepareCalendarViewControllerForTest];
    FBSnapshotVerifyView(self.calendarViewController.view, nil);
}

- (void)testWithWeekDayHeaderEnabled {
    self.calendarViewController.weekdayHeaderEnabled = YES;
    [self prepareCalendarViewControllerForTest];
    FBSnapshotVerifyView(self.calendarViewController.view, nil);
}

- (void)testWithCustomLastDate {
    self.calendarViewController.lastDate = [[self dateFormatter] dateFromString:@"23/05/2015"];
    [self prepareCalendarViewControllerForTest];
    FBSnapshotVerifyView(self.calendarViewController.view, nil);
}

- (void)testWithCustomFirstAndLastDate {
    self.calendarViewController.firstDate = [[self dateFormatter] dateFromString:@"09/05/2015"];
    self.calendarViewController.lastDate = [[self dateFormatter] dateFromString:@"23/05/2015"];
    [self prepareCalendarViewControllerForTest];
    FBSnapshotVerifyView(self.calendarViewController.view, nil);
}

- (void)testWithSelectedDate {
    [self prepareCalendarViewControllerForTest];
    self.calendarViewController.selectedDate = [[self dateFormatter] dateFromString:@"10/05/2015"];
    FBSnapshotVerifyView(self.calendarViewController.view, nil);
}

#pragma mark - Helpers

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"dd/MM/yyyy";
    });

    return formatter;
}

- (void)prepareCalendarViewControllerForTest {
    //As a convenience, force the test on iPhone 5 screen size.
    //We could also have device-specific folders using FBSnapshotVerifyViewWithOptions
    [self.calendarViewController beginAppearanceTransition:YES animated:NO];
    [self.calendarViewController.view setFrame:CGRectMake(0, 0, 320, 568)];
    [self.calendarViewController endAppearanceTransition];
}

@end