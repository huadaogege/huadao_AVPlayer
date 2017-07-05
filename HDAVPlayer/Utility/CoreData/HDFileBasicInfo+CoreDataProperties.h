//
//  HDFileBasicInfo+CoreDataProperties.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/5.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDFileBasicInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HDFileBasicInfo (CoreDataProperties)

+ (NSFetchRequest<HDFileBasicInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *fileName;
@property (nullable, nonatomic, copy) NSString *filePath;
@property (nullable, nonatomic, copy) NSString *isRead;
@property (nullable, nonatomic, copy) NSString *lastPro;

@end

NS_ASSUME_NONNULL_END
