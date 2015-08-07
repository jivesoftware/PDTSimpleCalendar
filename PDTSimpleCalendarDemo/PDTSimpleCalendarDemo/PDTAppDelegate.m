//
//  PDTAppDelegate.m
//  PDTSimpleCalendarDemo
//
//  Created by Jerome Miglino on 10/14/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import "PDTAppDelegate.h"
#import "PDTSimpleCalendarViewController.h"
#import "PDTSimpleCalendarViewCell.h"
#import "PDTSimpleCalendarViewHeader.h"

@interface PDTAppDelegate () <PDTSimpleCalendarViewDelegate>

@property (nonatomic, strong) NSArray *customDates;

@end

@implementation PDTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self initCustomDates];

    PDTSimpleCalendarViewController *calendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    //This is the default behavior, will display a full year starting the first of the current month
    [calendarViewController setDelegate:self];
    calendarViewController.weekdayHeaderEnabled = YES;
    calendarViewController.weekdayTextType = PDTSimpleCalendarViewWeekdayTextTypeVeryShort;

    PDTSimpleCalendarViewController *hebrewCalendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    //Example of how you can change the default calendar
    //Other options you can try NSPersianCalendar, NSIslamicCalendar, NSIndianCalendar, NSJapaneseCalendar, NSRepublicOfChinaCalendar
    NSCalendar *hebrewCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
    hebrewCalendar.locale = [NSLocale currentLocale];
    [hebrewCalendarViewController setCalendar:hebrewCalendar];

    PDTSimpleCalendarViewController *dateRangeCalendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    //For this calendar we're gonna allow only a selection between today and today + 3months.
    dateRangeCalendarViewController.firstDate = [NSDate date];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    offsetComponents.month = 3;
    NSDate *lastDate =[dateRangeCalendarViewController.calendar dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
    dateRangeCalendarViewController.lastDate = lastDate;

    //Set the edgesForExtendedLayout to UIRectEdgeNone
    if ([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)]) {
        [calendarViewController setEdgesForExtendedLayout:UIRectEdgeNone];
        [hebrewCalendarViewController setEdgesForExtendedLayout:UIRectEdgeNone];
        [dateRangeCalendarViewController setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    //Create Navigation Controller
    UINavigationController *defaultNavController = [[UINavigationController alloc] initWithRootViewController:calendarViewController];
    [calendarViewController setTitle:@"SimpleCalendar"];

    UINavigationController *hebrewNavController = [[UINavigationController alloc] initWithRootViewController:hebrewCalendarViewController];
    [hebrewCalendarViewController setTitle:@"Hebrew Calendar"];

    UINavigationController *dateRangeNavController = [[UINavigationController alloc] initWithRootViewController:dateRangeCalendarViewController];
    [dateRangeCalendarViewController setTitle:@"Custom Range"];

    //Create the Tab Bar Controller
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[defaultNavController, hebrewNavController, dateRangeNavController]];


    //Example of how you can now customize the calendar colors
//    [[PDTSimpleCalendarViewCell appearance] setCircleDefaultColor:[UIColor whiteColor]];
//    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor orangeColor]];
//    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor blueColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextDefaultColor:[UIColor redColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextSelectedColor:[UIColor purpleColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextTodayColor:[UIColor magentaColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextDisabledColor:[UIColor purpleColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextDefaultFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]];
//
//    [[PDTSimpleCalendarViewHeader appearance] setTextColor:[UIColor redColor]];
//    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];
//    [[PDTSimpleCalendarViewHeader appearance] setTextFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:8.0]];

    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - PDTSimpleCalendarViewDelegate

- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    NSLog(@"Date Selected : %@",date);
    NSLog(@"Date Selected with Locale %@", [date descriptionWithLocale:[NSLocale systemLocale]]);
}

- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller shouldUseCustomColorsForDate:(NSDate *)date
{
    if ([self.customDates containsObject:date]) {
        return YES;
    }

    return NO;
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller circleColorForDate:(NSDate *)date
{
    return [UIColor whiteColor];
}

- (UIColor *)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller textColorForDate:(NSDate *)date
{
    return [UIColor orangeColor];
}

#pragma mark - Private

//Add 3 custom dates, the 15th for the current & 2 next months.
- (void)initCustomDates
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    components.day = 15;
    NSDate *date1 = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSDateComponents *addOneMonthComponents = [[NSDateComponents alloc] init];
    addOneMonthComponents.month =1;
    NSDate *date2 = [[NSCalendar currentCalendar] dateByAddingComponents:addOneMonthComponents toDate:date1 options:0];
    NSDate *date3 = [[NSCalendar currentCalendar] dateByAddingComponents:addOneMonthComponents toDate:date2 options:0];
    self.customDates = @[date1, date2, date3];
}


@end
