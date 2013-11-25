//
//  PDTSimpleCalendarViewFlowLayout.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewFlowLayout.h"

const CGFloat PDTSimpleCalendarFlowLayoutMinInterItemSpacing = 0.0f;
const CGFloat PDTSimpleCalendarFlowLayoutMinLineSpacing = 0.0f;
const CGFloat PDTSimpleCalendarFlowLayoutInsetTop = 5.0f;
const CGFloat PDTSimpleCalendarFlowLayoutInsetLeft = 0.0f;
const CGFloat PDTSimpleCalendarFlowLayoutInsetBottom = 5.0f;
const CGFloat PDTSimpleCalendarFlowLayoutInsetRight = 0.0f;
const CGFloat PDTSimpleCalendarFlowLayoutHeaderHeight = 30.0f;

@implementation PDTSimpleCalendarViewFlowLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.minimumInteritemSpacing = PDTSimpleCalendarFlowLayoutMinInterItemSpacing;
        self.minimumLineSpacing = PDTSimpleCalendarFlowLayoutMinLineSpacing;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(PDTSimpleCalendarFlowLayoutInsetTop,
                                             PDTSimpleCalendarFlowLayoutInsetLeft,
                                             PDTSimpleCalendarFlowLayoutInsetBottom,
                                             PDTSimpleCalendarFlowLayoutInsetRight);
        self.headerReferenceSize = CGSizeMake(0, PDTSimpleCalendarFlowLayoutHeaderHeight);
        
        //Note: Item Size is defined using the delegate to take into account the width of the view and calculate size dynamically
    }

    return self;
}

@end
