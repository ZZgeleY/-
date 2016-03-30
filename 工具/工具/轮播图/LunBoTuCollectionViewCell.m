//
//  LunBoTuCollectionViewCell.m
//  Cartoon
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 YSZ. All rights reserved.
//

#import "LunBoTuCollectionViewCell.h"

@implementation LunBoTuCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myImageView = [[UIImageView alloc] init];
        self.myLabel = [[UILabel alloc] init];
        self.myLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.myLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_myImageView];
        [self.contentView addSubview:_myLabel];
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.myImageView.frame = self.contentView.bounds;
    
}
@end
