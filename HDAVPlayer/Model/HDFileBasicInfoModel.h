//
//  HDFileBasicInfoModel.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/5.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDModel.h"

@interface HDFileBasicInfoModel : HDModel

@property (nullable, nonatomic, copy) NSString *fileName;
@property (nullable, nonatomic, copy) NSString *filePath;
@property (nullable, nonatomic, copy) NSString *isRead; //是否已读
@property (nullable, nonatomic, copy) NSString *lastPro; //上次观看的进度

@end
