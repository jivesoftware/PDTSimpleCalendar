//
//  PDTSimpleCalendarViewController.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/7/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewController.h"

#import "PDTSimpleCalendarViewFlowLayout.h"
#import "PDTSimpleCalendarViewCell.h"
#import "PDTSimpleCalendarViewHeader.h"


const CGFloat PDTSimpleCalendarOverlaySize = 14.0f;

static NSString *PDTSimpleCalendarViewCellIdentifier = @"com.producteev.collection.cell.identifier";
static NSString *PDTSimpleCalendarViewHeaderIdentifier = @"com.producteev.collection.header.identifier";


@interface PDTSimpleCalendarViewController () <PDTSimpleCalendarViewCellDelegate>

@property (nonatomic, strong) UILabel *overlayView;
@property (nonatomic, strong) NSDateFormatter *headerDateFormatter; //Will be used to format date in header view and on scroll.

// First and last date of the months based on the public properties first & lastDate
@property (nonatomic, readonly) NSDate *firstDateMonth;
@property (nonatomic, readonly) NSDate *lastDateMonth;

//Number of days per week
@property (nonatomic, assign) NSUInteger daysPerWeek;

// Store the cell color so we don't need to access the appearance
// selector each time we render the cells
@property (nonatomic, strong) UIColor *cellCircleDefaultColor;
@property (nonatomic, strong) UIColor *cellCircleTodayColor;
@property (nonatomic, strong) UIColor *cellCircleSelectedColor;
@property (nonatomic, strong) UIColor *cellTextDefaultColor;
@property (nonatomic, strong) UIColor *cellTextTodayColor;
@property (nonatomic, strong) UIColor *cellTextSelectedColor;
@property (nonatomic, strong) UIColor *cellTextDisabledColor;
@property (nonatomic, strong) UIFont *cellFont;

@end


@implementation PDTSimpleCalendarViewController

//Explicitly @synthesize the var (it will create the iVar for us automatically as we redefine both getter and setter)
@synthesize firstDate = _firstDate;
@synthesize lastDate = _lastDate;
@synthesize calendar = _calendar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //Force the creation of the view with the pre-defined Flow Layout.
    //Still possible to define a custom Flow Layout, if needed by using initWithCollectionViewLayout:
    self = [super initWithCollectionViewLayout:[[PDTSimpleCalendarViewFlowLayout alloc] init]];
    if (self) {
        // Custom initialization
        [self simpleCalendarCommonInit];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    //Force the creation of the view with the pre-defined Flow Layout.
    //Still possible to define a custom Flow Layout, if needed by using initWithCollectionViewLayout:
    self = [super initWithCollectionViewLayout:[[PDTSimpleCalendarViewFlowLayout alloc] init]];
    if (self) {
        // Custom initialization
        [self simpleCalendarCommonInit];
    }
    
    return self;
}

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        [self simpleCalendarCommonInit];
    }

    return self;
}

- (void)simpleCalendarCommonInit
{
    self.shouldDisplayOverlayView = YES;
    self.shouldDisplayScrollIndicator = YES;
    
    self.headerViewTextAlignment = NSTextAlignmentLeft;
    self.headerViewHeight = 30.0;
    
    self.backgroundColor = [UIColor whiteColor];
    self.overlayTextColor = [UIColor blackColor];
    self.daysPerWeek = 7;
    
    self.cellCircleDefaultColor = [self cellCircleDefaultColor];
    self.cellCircleTodayColor = [self cellCircleTodayColor];
    self.cellCircleSelectedColor = [self cellCircleSelectedColor];
    self.cellTextDefaultColor = [self cellTextDefaultColor];
    self.cellTextDisabledColor = [self cellTextDisabledColor];
    self.cellTextTodayColor = [self cellTextTodayColor];
    self.cellTextSelectedColor = [self cellTextSelectedColor];
}

#pragma mark - Accessors

- (NSDateFormatter *)headerDateFormatter;
{
    if (!_headerDateFormatter) {
        
        if (!self.headerDateFormat) {
            self.headerDateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy LLLL" options:0 locale:self.calendar.locale];
        }
        
        _headerDateFormatter = [[NSDateFormatter alloc] init];
        _headerDateFormatter.calendar = self.calendar;
        _headerDateFormatter.dateFormat = self.headerDateFormat;
    }
    return _headerDateFormatter;
}

- (NSCalendar *)calendar
{
    if (!_calendar) {
        [self setCalendar:[NSCalendar currentCalendar]];
    }
    return _calendar;
}

-(void)setCalendar:(NSCalendar*)calendar
{
    _calendar = calendar;
    self.headerDateFormatter.calendar = calendar;
    self.daysPerWeek = [_calendar maximumRangeOfUnit:NSWeekdayCalendarUnit].length;
}

- (NSDate *)firstDate
{
    if (!_firstDate) {
        NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                        fromDate:[NSDate date]];
        components.day = 1;
        _firstDate = [self.calendar dateFromComponents:components];
    }

    return _firstDate;
}

- (void)setFirstDate:(NSDate *)firstDate
{
    _firstDate = [self clampDate:firstDate toComponents:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay];
}

//TODO: Store the value in the variable to avoid calculation everytime.
- (NSDate *)firstDateMonth
{
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                    fromDate:self.firstDate];
    components.day = 1;

    return [self.calendar dateFromComponents:components];
}

- (NSDate *)lastDate
{
    if (!_lastDate) {
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        offsetComponents.year = 1;
        offsetComponents.day = -1;
        [self setLastDate:[self.calendar dateByAddingComponents:offsetComponents toDate:self.firstDateMonth options:0]];
    }

    return _lastDate;
}

- (void)setLastDate:(NSDate *)lastDate
{
    _lastDate = [self clampDate:lastDate toComponents:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay];
}

//TODO: Store the value in the variable to avoid calculation everytime.
- (NSDate *)lastDateMonth
{
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.lastDate];
    components.month++;
    components.day = 0;

    return [self.calendar dateFromComponents:components];
}

- (void)setSelectedDate:(NSDate *)newSelectedDate
{
    //if newSelectedDate is nil, unselect the current selected cell
    if (!newSelectedDate) {
        [[self cellForItemAtDate:_selectedDate] setSelected:NO];
        _selectedDate = newSelectedDate;

        return;
    }

    //Test if selectedDate between first & last date
    NSDate *startOfDay = [self clampDate:newSelectedDate toComponents:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit];
    if (([startOfDay compare:self.firstDateMonth] == NSOrderedAscending) || ([startOfDay compare:self.lastDateMonth] == NSOrderedDescending)) {
        //the newSelectedDate is not between first & last date of the calendar, do nothing.
        return;
    }


    [[self cellForItemAtDate:_selectedDate] setSelected:NO];
    [[self cellForItemAtDate:startOfDay] setSelected:YES];

    _selectedDate = startOfDay;

    NSIndexPath *indexPath = [self indexPathForCellAtDate:_selectedDate];
    [self.collectionView reloadItemsAtIndexPaths:@[ indexPath ]];

    //Notify the delegate
    if ([self.delegate respondsToSelector:@selector(simpleCalendarViewController:didSelectDate:)]) {
        [self.delegate simpleCalendarViewController:self didSelectDate:self.selectedDate];
    }
}

//Deprecated, You need to use setSelectedDate: and call scrollToDate:animated: or scrollToSelectedDate:animated:
//TODO: Remove this in next release
- (void)setSelectedDate:(NSDate *)newSelectedDate animated:(BOOL)animated
{
    [self setSelectedDate:newSelectedDate];
    [self scrollToSelectedDate:animated];
}

#pragma mark - Scroll to a specific date

- (void)scrollToSelectedDate:(BOOL)animated
{
    if (_selectedDate) {
        [self scrollToDate:_selectedDate animated:animated];
    }
}

- (void)scrollToDate:(NSDate *)date animated:(BOOL)animated
{
    @try {
        NSIndexPath *selectedDateIndexPath = [self indexPathForCellAtDate:date];

        if (![[self.collectionView indexPathsForVisibleItems] containsObject:selectedDateIndexPath]) {
            //First, tried to use [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:selectedDateIndexPath]; but it causes the header to be redraw multiple times (X each time you use scrollToDate:)
            //TODO: Investigate & eventually file a radar.

            NSIndexPath *sectionIndexPath = [NSIndexPath indexPathForItem:0 inSection:selectedDateIndexPath.section];
            UICollectionViewLayoutAttributes *sectionLayoutAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:sectionIndexPath];
            CGPoint origin = sectionLayoutAttributes.frame.origin;
            origin.x = 0;
            origin.y -= (PDTSimpleCalendarFlowLayoutHeaderHeight + PDTSimpleCalendarFlowLayoutInsetTop + self.collectionView.contentInset.top);
            [self.collectionView setContentOffset:origin animated:animated];
        }
    }
    @catch (NSException *exception) {
        //Exception occured (it should not according to the documentation, but in reality...) let's scroll to the IndexPath then
        NSInteger section = [self sectionForDate:date];
        NSIndexPath *sectionIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        [self.collectionView scrollToItemAtIndexPath:sectionIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:animated];
    }
}

- (void)setOverlayTextColor:(UIColor *)overlayTextColor
{
    _overlayTextColor = overlayTextColor;
    if (self.overlayView) {
        [self.overlayView setTextColor:self.overlayTextColor];
    }
}

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //Configure the Collection View
    [self.collectionView registerClass:[PDTSimpleCalendarViewCell class] forCellWithReuseIdentifier:PDTSimpleCalendarViewCellIdentifier];
    [self.collectionView registerClass:[PDTSimpleCalendarViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PDTSimpleCalendarViewHeaderIdentifier];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = self.shouldDisplayScrollIndicator;
    [self.collectionView setBackgroundColor:self.backgroundColor];

    if (self.shouldDisplayOverlayView == YES) {
        
        self.overlayView = [[UILabel alloc] init];
        
        //Configure the Overlay View
        [self.overlayView setBackgroundColor:[self.backgroundColor colorWithAlphaComponent:0.90]];
        [self.overlayView setFont:[UIFont boldSystemFontOfSize:PDTSimpleCalendarOverlaySize]];
        [self.overlayView setTextColor:self.overlayTextColor];
        [self.overlayView setAlpha:0.0];
        [self.overlayView setTextAlignment:NSTextAlignmentCenter];
    
        [self.view addSubview:self.overlayView];
        [self.overlayView setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSDictionary *viewsDictionary = @{@"overlayView": self.overlayView};
        NSDictionary *metricsDictionary = @{@"overlayViewHeight": @(PDTSimpleCalendarFlowLayoutHeaderHeight)};
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[overlayView]|" options:NSLayoutFormatAlignAllTop metrics:nil views:viewsDictionary]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[overlayView(==overlayViewHeight)]" options:NSLayoutFormatAlignAllTop metrics:metricsDictionary views:viewsDictionary]];
    }
}

#pragma mark - Rotation Handling

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView.collectionViewLayout invalidateLayout];
}


#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //Each Section is a Month
    return [self.calendar components:NSMonthCalendarUnit fromDate:self.firstDateMonth toDate:self.lastDateMonth options:0].month + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:section];
    NSRange rangeOfWeeks = [self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:firstOfMonth];

    //We need the number of calendar weeks for the full months (it will maybe include previous month and next months cells)
    return (rangeOfWeeks.length * self.daysPerWeek);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PDTSimpleCalendarViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:PDTSimpleCalendarViewCellIdentifier
                                                                                     forIndexPath:indexPath];
    cell.circleDefaultColor = self.cellCircleDefaultColor;
    cell.circleTodayColor = self.cellCircleTodayColor;
    cell.circleSelectedColor = self.cellCircleSelectedColor;
    cell.textDefaultColor = self.cellTextDefaultColor;
    cell.textDisabledColor = self.cellTextDisabledColor;
    cell.textTodayColor = self.cellTextTodayColor;
    cell.textSelectedColor = self.cellTextSelectedColor;
    cell.font = self.cellFont;
    cell.delegate = self;
    cell.userInteractionEnabled = YES;
    
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];

    NSDateComponents *cellDateComponents = [self.calendar components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:cellDate];
    NSDateComponents *firstOfMonthsComponents = [self.calendar components:NSMonthCalendarUnit fromDate:firstOfMonth];

    BOOL isToday = NO;
    BOOL isSelected = NO;
    BOOL isCustomDate = NO;

    if (cellDateComponents.month == firstOfMonthsComponents.month) {
        isSelected = ([self isSelectedDate:cellDate] && (indexPath.section == [self sectionForDate:cellDate]));
        isToday = [self isTodayDate:cellDate];
        [cell setDate:cellDate calendar:self.calendar];

        //Ask the delegate if this date should have specific colors.
        if ([self.delegate respondsToSelector:@selector(simpleCalendarViewController:shouldUseCustomColorsForDate:)]) {
            isCustomDate = [self.delegate simpleCalendarViewController:self shouldUseCustomColorsForDate:cellDate];
        }
        
        if ([cellDate timeIntervalSinceNow] < 0.0 && !isToday) {
            cell.enabled = NO;
            cell.userInteractionEnabled = NO;
        }
        
    } else {
        [cell setDate:nil calendar:nil];
    }

    if (isToday) {
        [cell setIsToday:isToday];
    }

    if (isSelected) {
        [cell setSelected:isSelected];
    }

    [cell refreshCellColors];

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];

    //We don't want to select Dates that are "disabled"
    if (![self isEnabledDate:cellDate]) {
        return NO;
    }

    NSDateComponents *cellDateComponents = [self.calendar components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:cellDate];
    NSDateComponents *firstOfMonthsComponents = [self.calendar components:NSMonthCalendarUnit fromDate:firstOfMonth];

    return (cellDateComponents.month == firstOfMonthsComponents.month);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedDate = [self dateForCellAtIndexPath:indexPath];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        PDTSimpleCalendarViewHeader *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PDTSimpleCalendarViewHeaderIdentifier forIndexPath:indexPath];

        headerView.titleLabel.text = [self.headerDateFormatter stringFromDate:[self firstOfMonthForSection:indexPath.section]];
        headerView.textAlignment = self.headerViewTextAlignment;
        
        headerView.layer.shouldRasterize = YES;
        headerView.layer.rasterizationScale = [UIScreen mainScreen].scale;

        return headerView;
    }

    return nil;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake(self.view.bounds.size.width, self.headerViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = floorf(CGRectGetWidth(self.collectionView.bounds) / self.daysPerWeek);
    CGFloat itemHeight = itemWidth;
    
    if (self.cellHeight) {
        itemHeight = self.cellHeight;
    }
    
    return CGSizeMake(itemWidth, itemHeight);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.shouldDisplayOverlayView == YES) {
        // We only display the overlay view if there is a vertical velocity
        if ( fabsf(velocity.y) > 0.0f) {
            if (self.overlayView.alpha < 1.0) {
                [UIView animateWithDuration:0.25 animations:^{
                    [self.overlayView setAlpha:1.0];
                }];
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSTimeInterval delay = (decelerate) ? 1.5 : 0.0;
    [self performSelector:@selector(hideOverlayView) withObject:nil afterDelay:delay];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //Update Content of the Overlay View
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    //indexPaths is not sorted
    NSArray *sortedIndexPaths = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
    NSIndexPath *firstIndexPath = [sortedIndexPaths firstObject];

    if (self.shouldDisplayOverlayView == YES) {
        self.overlayView.text = [self.headerDateFormatter stringFromDate:[self firstOfMonthForSection:firstIndexPath.section]];
    }
}

- (void)hideOverlayView
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.overlayView setAlpha:0.0];
    }];
}

#pragma mark -
#pragma mark - Calendar calculations

- (NSDate *)clampDate:(NSDate *)date toComponents:(NSUInteger)unitFlags
{
    NSDateComponents *components = [self.calendar components:unitFlags fromDate:date];
    return [self.calendar dateFromComponents:components];
}

- (BOOL)isTodayDate:(NSDate *)date
{
    return [self clampAndCompareDate:date withReferenceDate:[NSDate date]];
}

- (BOOL)isSelectedDate:(NSDate *)date
{
    if (!self.selectedDate) {
        return NO;
    }
    return [self clampAndCompareDate:date withReferenceDate:self.selectedDate];
}

- (BOOL)isEnabledDate:(NSDate *)date
{
    NSDate *clampedDate = [self clampDate:date toComponents:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];
    if (([clampedDate compare:self.firstDate] == NSOrderedAscending) || ([clampedDate compare:self.lastDate] == NSOrderedDescending)) {
        return NO;
    }

    return YES;
}

- (BOOL)clampAndCompareDate:(NSDate *)date withReferenceDate:(NSDate *)referenceDate
{
    NSDate *refDate = [self clampDate:referenceDate toComponents:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];
    NSDate *clampedDate = [self clampDate:date toComponents:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];

    return [refDate isEqualToDate:clampedDate];
}

#pragma mark - Collection View / Calendar Methods

- (NSDate *)firstOfMonthForSection:(NSInteger)section
{
    NSDateComponents *offset = [NSDateComponents new];
    offset.month = section;

    return [self.calendar dateByAddingComponents:offset toDate:self.firstDateMonth options:0];
}

- (NSInteger)sectionForDate:(NSDate *)date
{
    return [self.calendar components:NSMonthCalendarUnit fromDate:self.firstDateMonth toDate:date options:0].month;
}


- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *firstOfMonth = [self firstOfMonthForSection:indexPath.section];
    NSInteger ordinalityOfFirstDay = [self.calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:firstOfMonth];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = (1 - ordinalityOfFirstDay) + indexPath.item;

    return [self.calendar dateByAddingComponents:dateComponents toDate:firstOfMonth options:0];
}


- (NSIndexPath *)indexPathForCellAtDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }

    NSInteger section = [self sectionForDate:date];

    NSDate *firstOfMonth = [self firstOfMonthForSection:section];
    NSInteger ordinalityOfFirstDay = [self.calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:firstOfMonth];


    NSDateComponents *dateComponents = [self.calendar components:NSDayCalendarUnit fromDate:date];
    NSDateComponents *firstOfMonthComponents = [self.calendar components:NSDayCalendarUnit fromDate:firstOfMonth];
    NSInteger item = (dateComponents.day - firstOfMonthComponents.day) - (1 - ordinalityOfFirstDay);

    return [NSIndexPath indexPathForItem:item inSection:section];
}

- (PDTSimpleCalendarViewCell *)cellForItemAtDate:(NSDate *)date
{
    return (PDTSimpleCalendarViewCell *)[self.collectionView cellForItemAtIndexPath:[self indexPathForCellAtDate:date]];
}

#pragma mark PDTSimpleCalendarViewCellDelegate

- (BOOL)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell shouldUseCustomColorsForDate:(NSDate *)date
{
    //If the date is not enabled (aka outside the first/lastDate) return YES
    if (![self isEnabledDate:date]) {
        return YES;
    }

    //Otherwise we ask the delegate
    if ([self.delegate respondsToSelector:@selector(simpleCalendarViewController:shouldUseCustomColorsForDate:)]) {
        return [self.delegate simpleCalendarViewController:self shouldUseCustomColorsForDate:date];
    }

    return NO;
}

- (UIColor *)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell circleColorForDate:(NSDate *)date
{
    if (![self isEnabledDate:date]) {
        return cell.circleDefaultColor;
    }

    if ([self.delegate respondsToSelector:@selector(simpleCalendarViewController:circleColorForDate:)]) {
        return [self.delegate simpleCalendarViewController:self circleColorForDate:date];
    }

    return nil;
}

- (UIColor *)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell textColorForDate:(NSDate *)date
{
    if (![self isEnabledDate:date]) {
        return cell.textDisabledColor;
    }

    if ([self.delegate respondsToSelector:@selector(simpleCalendarViewController:textColorForDate:)]) {
        return [self.delegate simpleCalendarViewController:self textColorForDate:date];
    }
    
    return nil;
}

#pragma mark - Circle Color Customization Methods

- (UIColor *)cellCircleDefaultColor
{
    if(_cellCircleDefaultColor == nil) {
        _cellCircleDefaultColor = [[[PDTSimpleCalendarViewCell class] appearance] circleDefaultColor];
    }
    
    if(_cellCircleDefaultColor != nil) {
        return _cellCircleDefaultColor;
    }
    
    return [UIColor whiteColor];
}

- (UIColor *)cellCircleTodayColor
{
    if(_cellCircleTodayColor == nil) {
        _cellCircleTodayColor = [[[PDTSimpleCalendarViewCell class] appearance] circleTodayColor];
    }
    
    if(_cellCircleTodayColor != nil) {
        return _cellCircleTodayColor;
    }
    
    return [UIColor grayColor];
}

- (UIColor *)cellCircleSelectedColor
{
    if(_cellCircleSelectedColor == nil) {
        _cellCircleSelectedColor = [[[PDTSimpleCalendarViewCell class] appearance] circleSelectedColor];
    }
    
    if(_cellCircleSelectedColor != nil) {
        return _cellCircleSelectedColor;
    }
    
    return [UIColor redColor];
}

#pragma mark - Text Label Customizations Color

- (UIColor *)cellTextDefaultColor
{
    if(_cellTextDefaultColor == nil) {
        _cellTextDefaultColor = [[[PDTSimpleCalendarViewCell class] appearance] textDefaultColor];
    }
    
    if(_cellTextDefaultColor != nil) {
        return _cellTextDefaultColor;
    }
    
    return [UIColor blackColor];
}

- (UIColor *)cellTextTodayColor
{
    if(_cellTextTodayColor == nil) {
        _cellTextTodayColor = [[[PDTSimpleCalendarViewCell class] appearance] textTodayColor];
    }
    
    if(_cellTextTodayColor != nil) {
        return _cellTextTodayColor;
    }
    
    return [UIColor whiteColor];
}

- (UIColor *)cellTextSelectedColor
{
    if(_cellTextSelectedColor == nil) {
        _cellTextSelectedColor = [[[PDTSimpleCalendarViewCell class] appearance] textSelectedColor];
    }
    
    if(_cellTextSelectedColor != nil) {
        return _cellTextSelectedColor;
    }
    
    return [UIColor whiteColor];
}

- (UIColor *)cellTextDisabledColor
{
    if(_cellTextDisabledColor == nil) {
        _cellTextDisabledColor = [[[PDTSimpleCalendarViewCell class] appearance] textDisabledColor];
    }
    
    if(_cellTextDisabledColor != nil) {
        return _cellTextDisabledColor;
    }
    
    return [UIColor lightGrayColor];
}

- (UIFont *)cellFont
{
    if(_cellFont == nil) {
        _cellFont = [[[PDTSimpleCalendarViewCell class] appearance] font];
    }
    
    if(_cellFont != nil) {
        return _cellFont;
    }
    
    return [UIFont systemFontOfSize:19.f];
}

@end
