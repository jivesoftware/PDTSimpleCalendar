//
//  PDTSimpleCalendarDemoTests.m
//  PDTSimpleCalendarDemoTests
//
//  Created by Jerome Miglino on 3/10/14.
//  Copyright (c) 2014 Producteev. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "PDTSimpleCalendarViewController.h"
#import "PDTSimpleCalendarViewController+Private.h"

@interface PDTSimpleCalendarDemoTests : SenTestCase

@property (nonatomic, strong) PDTSimpleCalendarViewController *calendarController;

@end

@implementation PDTSimpleCalendarDemoTests

- (void)setUp
{
    [super setUp];
    _calendarController = [[PDTSimpleCalendarViewController alloc] init];
}

- (void)tearDown
{
    _calendarController = nil;
    [super tearDown];
}

- (void)testDatesDefaultBehavior
{
    NSDate *today = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
    //Force the day to the first of the month
    components.day = 1;
    NSDate *expectedFirstDate = [currentCalendar dateFromComponents:components];

    STAssertTrue([_calendarController.firstDate isEqualToDate:expectedFirstDate], @"firstDate should be equal to the first day of the month");
    STAssertTrue([_calendarController.firstDateMonth isEqualToDate:expectedFirstDate], @"firstDateMonth should be equal to the first day of the month");

    NSDateComponents *addOneYearComponents = [[NSDateComponents alloc] init];
    addOneYearComponents.year =1;
    addOneYearComponents.day = -1;
    NSDate *expectedLastDate = [currentCalendar dateByAddingComponents:addOneYearComponents toDate:expectedFirstDate options:0];

    STAssertTrue([_calendarController.lastDate isEqualToDate:expectedLastDate], @"lastDate should be equal to the last day of the month in one year");
    STAssertTrue([_calendarController.lastDateMonth isEqualToDate:expectedLastDate], @"lastDateMonth should be equal to the last day of the month in one year");
}

- (void)testSetFirstDate
{
    NSDate *today = [NSDate date];
    _calendarController.firstDate = today;

    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
    NSDate *clampedToday = [currentCalendar dateFromComponents:components];
    //Force the day to the first of the month
    components.day = 1;
    NSDate *expectedFirstDate = [currentCalendar dateFromComponents:components];

    STAssertTrue([_calendarController.firstDate isEqualToDate:clampedToday], @"firstDate should be today");
    STAssertTrue([_calendarController.firstDateMonth isEqualToDate:expectedFirstDate], @"firstDateMonth should be equal to the first day of the month");
    //Just to be sure
    NSDateComponents *firstDateMonthComponents = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_calendarController.firstDateMonth];
    NSDateComponents *firstDateComponents = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_calendarController.firstDate];
    STAssertTrue(firstDateComponents.month == firstDateMonthComponents.month, @"FirstDate & firstDateMonth should be in the same month");
    STAssertTrue(firstDateComponents.day >= firstDateMonthComponents.day, @"firstDate day should be >= firstDateMonth");
}

- (void)testSetLastDate
{
    NSDate *today = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
    NSDate *clampedToday = [currentCalendar dateFromComponents:components];

    //We set the last date in 3 months
    NSDateComponents *addComponents = [[NSDateComponents alloc] init];
    addComponents.month = 3;
    NSDate *lastDate = [currentCalendar dateByAddingComponents:addComponents toDate:clampedToday options:0];
    _calendarController.lastDate = lastDate;

    STAssertTrue([_calendarController.lastDate isEqualToDate:lastDate], @"lastDate should be in 3 months from today");

    //Calculate Last Day of Month
    components = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:lastDate];
    components.day = 0;
    components.month += 1;
    //Next month with day zero, gives the last day of month.
    NSDate *expectedLastDayMonthDate = [currentCalendar dateFromComponents:components];

    STAssertTrue([_calendarController.lastDateMonth isEqualToDate:expectedLastDayMonthDate], @"firstDateMonth should be equal to the first day of the month");
    //Just to be sure
    NSDateComponents *lastDateMonthComponents = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_calendarController.lastDateMonth];
    NSDateComponents *lastDateComponents = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_calendarController.lastDate];
    STAssertTrue(lastDateComponents.month == lastDateMonthComponents.month, @"LastDate & lastDateMonth should be in the same month");
    STAssertTrue(lastDateComponents.day <= lastDateMonthComponents.day, @"LastDate day should be < lastDateMonth");
}

- (void)testNumberOfDaysPerWeek
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [_calendarController setCalendar:gregorianCalendar];
    //We know that the gregorian calendar has 7 days per week
    //If you know a calendar who doesn't have 7 days per week and is supported by iOS let me know ;-)

    STAssertTrue(_calendarController.daysPerWeek == 7, @"Should be 7 days a week");
}

@end
