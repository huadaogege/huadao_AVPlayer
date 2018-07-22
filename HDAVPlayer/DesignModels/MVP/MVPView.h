//
//  MVPView.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/28.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVPView : UIView

@property (nonatomic, strong) UILabel *contentLabel;

- (void)printContent:(NSString *)content;

@end
