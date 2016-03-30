//
//  AotuLayout.h
//  工具类,张中烨
//
//  Created by 张张烨 on 16/3/25.
//  Copyright © 2016年 张中烨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QpLayout;

@protocol LayoutItemHeightDelegate <NSObject>

// 参数1:layout
// 参数2: 位置信息
// 参数3: item宽度
- (CGFloat)layout:(QpLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexpath width:(CGFloat)width;

@end



@interface AotuLayout : UICollectionViewLayout

// 影响item (x, y, w, h)的布局属性
@property (nonatomic, assign)NSInteger columCounts;/**< 列数   */
@property (nonatomic, assign)NSInteger columSpace;/**< 列间距 */
@property (nonatomic, assign) NSInteger rowSpace;/**< 行间距 */
@property (nonatomic ,assign) UIEdgeInsets edgeInsets; /**< 边距 */

@property (nonatomic, assign) id<LayoutItemHeightDelegate>delegate;
@end
