//
//  PubuCell.m
//  工具
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import "PubuCell.h"
#import "PubuModel.h"
#import <UIImageView+WebCache.h>
@implementation PubuCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgview = [[UIImageView alloc]init];
        [self.contentView addSubview:_imgview];
    
    }
    return self;
}
- (void)setModel:(PubuModel *)model
{
    _model = model;
    [_imgview sd_setImageWithURL:[NSURL URLWithString:_model.photo_url]];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    _imgview.frame = layoutAttributes.bounds;
}
@end
