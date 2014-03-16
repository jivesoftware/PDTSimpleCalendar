//
//  PDTFormatters.m
//  PDTSimpleCalendarDemo
//
//  Created by Jeroen Houtzager on 16-03-14.
//  Copyright (c) 2014 Producteev. All rights reserved.
//

#import "PDTSingleton.h"

@implementation PDTSingleton

+ (instancetype)sharedManager {
    static PDTSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;

    _numberFormatter = [NSNumberFormatter new];
    return self;
}

@end
