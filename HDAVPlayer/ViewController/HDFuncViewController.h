//
//  HDFuncViewController.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDViewController.h"

typedef NS_ENUM(NSInteger, HD_FUNC_TYPE) {
    HD_FUNC_Video_Play,
    HD_FUNC_TYPE_QRC_Create,
    HD_FUNC_TYPE_QRC_Scan,
    HD_FUNC_TYPE_Voice_Speak
};

@interface HDFuncViewController : HDViewController <UITableViewDelegate, UITableViewDataSource>

@end
