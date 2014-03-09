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

@end

@implementation PDTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

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

    // Enable 10th of current month until the 10th of next month
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    comps.day = 10;
    calendarViewController.firstDate = [calendar dateFromComponents:comps];
    comps.month += 14;
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

- (BOOL)simpleCalendarDateIsEnabled:(NSDate *)date {
  // Get day and month from date
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:date];

  // We do not want peopel to select the 20th do we?
  if (components.day == 20)
    return NO;

  // All others are enabled
  return YES;
}


- (UIColor *)simpleCalendarCircleColorForDate:(NSDate *)date
{
  // Get day and month from date
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSWeekdayCalendarUnit fromDate:date];

  // Return X-mas as green balls with red text
  if (components.month == 12 && (components.day == 25 || components.day == 26))
    return [UIColor colorWithRed:0 green:0.75 blue:0 alpha:1];

  // Default colour
  return nil;
}

- (UIColor *)simpleCalendarTextColorForDate:(NSDate *)date
{
  // Get day and month from date
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSWeekdayCalendarUnit fromDate:date];

  // Return New Year as blue
  if (components.month == 1 && components.day == 1)
    return [UIColor blueColor];

  // Return X-mas as green balls with red text
  if (components.month == 12 && (components.day == 25 || components.day == 26))
    return [UIColor redColor];

  // Return Sundays as red
  if (components.weekday == 1)
    return [UIColor redColor];

  // Default colour
  return nil;
}

@end
