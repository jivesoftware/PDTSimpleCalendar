//
//  PDTFormatters.h
//  PDTSimpleCalendarDemo
//
//  Created by Jeroen Houtzager on 16-03-14.
//  Copyright (c) 2014 Producteev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDTSingleton : NSObject

@property (nonatomic, readonly) NSNumberFormatter *numberFormatter;

+ (instancetype)sharedManager;

@end
