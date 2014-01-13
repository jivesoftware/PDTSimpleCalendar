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

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";

    _customDates = @[[dateFormatter dateFromString:@"01/02/2014"], [dateFormatter dateFromString:@"01/03/2014"], [dateFormatter dateFromString:@"01/04/2014"]];
    
    PDTSimpleCalendarViewController *calendarViewController = [[PDTSimpleCalendarViewController alloc] init];
    [calendarViewController setDelegate:self];
    //Example of how you can change the default calendar
    //#define TRY_ARAB
    //#define TRY_HEBREW
    //#define TRY_FARSI
    //#define TRY_INDIAN


#if defined(TRY_HEBREW)
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
#elif defined(TRY_FARSI)
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar];
#elif defined(TRY_ARAB)
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCalendar];
#elif defined(TRY_INDIAN)
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIndianCalendar];
#else
    NSCalendar *calendar = [NSCalendar currentCalendar];
#endif
    [calendarViewController setCalendar:calendar];
    NSLog(@"Calendar ID = %@", calendar.calendarIdentifier);
    NSLog(@"Language = %@", [[NSLocale preferredLanguages] firstObject]);

    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    comps.day = 10;
    calendarViewController.firstDate = [calendar dateFromComponents:comps];
    comps.month += 1;
    calendarViewController.lastDate = [calendar dateFromComponents:comps];

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:calendarViewController];
    [calendarViewController setTitle:@"SimpleCalendar"];
    //Example of how you can now customize the calendar colors
//    [[PDTSimpleCalendarViewCell appearance] setCircleDefaultColor:[UIColor whiteColor]];
//    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor orangeColor]];
//    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor blueColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextDefaultColor:[UIColor redColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextSelectedColor:[UIColor purpleColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextTodayColor:[UIColor magentaColor]];
//    [[PDTSimpleCalendarViewCell appearance] setTextDisabledColor:[UIColor purpleColor]];
//
//    [[PDTSimpleCalendarViewHeader appearance] setTextColor:[UIColor redColor]];
//    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];

    [self.window setRootViewController:navController];
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

- (void)simpleCalendarViewDidSelectDate:(NSDate *)date
{
    NSLog(@"Date Selected : %@",date);
}

- (BOOL)simpleCalendarShouldUseCustomColorsForDate:(NSDate *)date
{
    if ([self.customDates containsObject:date]) {
        return YES;
    }

    return NO;
}

- (UIColor *)simpleCalendarCircleColorForDate:(NSDate *)date
{
    return [UIColor whiteColor];
}

- (UIColor *)simpleCalendarTextColorForDate:(NSDate *)date
{
    return [UIColor orangeColor];
}

@end
