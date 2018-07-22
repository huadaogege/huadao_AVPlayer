//
//  WaterFlowLayout.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/7/22.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^heightBlock)(NSIndexPath *indexPath);

@interface WaterFlowLayout : UICollectionViewFlowLayout

- (instancetype)initWithBlock:(heightBlock)heightblock;

@property (nonatomic, copy) heightBlock heightblock;

@end
