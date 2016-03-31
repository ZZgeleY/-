//
//  TopScView.h
//  UI_封装头部
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 张中烨. All rights reserved.
//  Created by 李锐 on 16/1/14.
//  Copyright © 李锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopScViewOriginDelegate <NSObject>

- (void)PassOriginWithX:(CGFloat)x;

@end

@interface TopScView : UIView

@property (nonatomic, retain) NSMutableArray *dataArr;

@property (nonatomic, assign) id<TopScViewOriginDelegate> delegate;

- (void)changeContentOffsetWithH:(CGFloat)h;

@end
