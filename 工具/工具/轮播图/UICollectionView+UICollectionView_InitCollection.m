//
//  UICollectionView+UICollectionView_InitCollection.m
//  娱
//
//  Created by dllo on 15/9/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "UICollectionView+UICollectionView_InitCollection.h"

@implementation UICollectionView (UICollectionView_InitCollection)
+ (UICollectionView *)collectionViewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];

    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    
    return collectionView;
}

@end
