//
//  LunBoTu.h
//  Cartoon
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 YSZ. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol LunBoTuDelegate <NSObject>

- (void)didSelectCollectionView:(UICollectionView *)collectionView atItemImdexPath:(NSIndexPath *)indexPath;

@end

@interface LunBoTu : NSObject<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) id<LunBoTuDelegate> delegate;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat time;

@property (nonatomic, strong) NSMutableArray *labelTextArray;
@property (nonatomic, assign) CGRect labelFrame;
+ (LunBoTu *)shareCollection;
- (void)imageWithUrlArray:(NSMutableArray *)urlArray frame:(CGRect)frame;

@end
