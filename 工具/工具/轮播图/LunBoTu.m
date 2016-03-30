//
//  LunBoTu.m
//  Cartoon
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 YSZ. All rights reserved.
//

#import "LunBoTu.h"
#import "UICollectionView+UICollectionView_InitCollection.h"
#import "UIImageView+WebCache.h"
#import "LunBoTuCollectionViewCell.h"
#import "NSTimer+Pausing.h"

@interface LunBoTu ()
@property (nonatomic, assign) CGRect myFrame;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation LunBoTu
+ (LunBoTu *)shareCollection
{
    
    static LunBoTu *lunBoYu = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        lunBoYu = [[LunBoTu alloc]init];
        
    });

    return lunBoYu;
}

- (void)imageWithUrlArray:(NSMutableArray *)urlArray frame:(CGRect)frame;
{
    if (urlArray.count > 1) {
        [urlArray insertObject:[urlArray lastObject] atIndex:0];
        [urlArray addObject:[urlArray objectAtIndex:1]];
        if (self.labelTextArray) {
            [_labelTextArray insertObject:[_labelTextArray lastObject] atIndex:0];
            [_labelTextArray addObject:[_labelTextArray objectAtIndex:1]];
        }
    }else{
        _pageControl.numberOfPages = urlArray.count;
    }
    self.array = [NSMutableArray arrayWithArray:urlArray];
    self.myFrame = frame;
    [self.collectionView reloadData];
    if (self.array.count > 1) {
        _collectionView.contentOffset = CGPointMake(self.myFrame.size.width, 0);
    }
    if (self.time) {
       self.timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(changeSet) userInfo:nil repeats:YES];
    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeSet) userInfo:nil repeats:YES];
    }
    
}
- (void)changeSet
{
    if (self.array.count > 1) {
    CGFloat x = (self.pageControl.currentPage + 2) * self.myFrame.size.width;
    [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
        }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        CGFloat x = self.collectionView.contentOffset.x;
        NSInteger page = x / self.myFrame.size.width;
        NSInteger xInt = x / 1;
        NSInteger width = self.myFrame.size.width;
        NSInteger remainder = xInt % width;
        if (page == self.array.count - 1) {
            self.collectionView.contentOffset = CGPointMake(self.myFrame.size.width, 0);
            _pageControl.currentPage = 0;
        }
        else if (x == 0) {
            self.collectionView.contentOffset = CGPointMake(_pageControl.numberOfPages * self.myFrame.size.width, 0);
            _pageControl.currentPage = _pageControl.numberOfPages - 1;
        }
        else if(remainder < 140){
            
            _pageControl.currentPage = page - 1;
        }
    
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.timer pause];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.timer resume];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        self.collectionView = [UICollectionView collectionViewWithFrame:self.myFrame];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [_collectionView registerClass:[LunBoTuCollectionViewCell class] forCellWithReuseIdentifier:@"LunBoTu"];
    }
    return _collectionView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,self.myFrame.size.height + self.myFrame.origin.y - 30, self.myFrame.size.width, 30)];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        if (_array.count > 3) {
            _pageControl.numberOfPages = self.array.count - 2;
        }else{
            _pageControl.numberOfPages = self.array.count;
        }
    }
    return _pageControl;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LunBoTuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LunBoTu" forIndexPath:indexPath];
    if ([[self.array objectAtIndex:indexPath.item] isKindOfClass:[UIImage class]]) {
        cell.myImageView.image = [self.array objectAtIndex:indexPath.item];
    }else if([[[self.array objectAtIndex:indexPath.item] substringToIndex:4] isEqualToString:@"http"]){
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:[self.array objectAtIndex:indexPath.item]] placeholderImage:[UIImage imageNamed:@"5"]];
    }else{
        cell.myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.array objectAtIndex:indexPath.item]]];
    }
    if (self.labelTextArray) {
        
        cell.myLabel.frame = _labelFrame;
        cell.myLabel.text = [self.labelTextArray objectAtIndex:indexPath.item];
        cell.myLabel.numberOfLines = 0;
        [cell.myLabel sizeToFit];
        cell.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.5];
    }

    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCollectionView:atItemImdexPath:)]) {
        
        if (self.array.count > 2) {
            if (self.array.count == indexPath.item + 1) {
                
                NSIndexPath *myIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                [self.delegate didSelectCollectionView:collectionView atItemImdexPath:myIndexPath];
                
            }else if (indexPath.item == 0){
                
                NSIndexPath *myIndexPath = [NSIndexPath indexPathForItem:self.array.count - 3 inSection:0];
                [self.delegate didSelectCollectionView:collectionView atItemImdexPath:myIndexPath];
                
            }else{
                NSIndexPath *myIndexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:0];
               [self.delegate didSelectCollectionView:collectionView atItemImdexPath:myIndexPath];
            }
        }else{
            
            NSIndexPath *myIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
           [self.delegate didSelectCollectionView:collectionView atItemImdexPath:myIndexPath];
            
        }
        
    }
}
@end
