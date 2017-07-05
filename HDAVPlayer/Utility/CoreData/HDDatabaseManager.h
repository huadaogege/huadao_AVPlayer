//
//  HDDatabaseManager.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/5.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDFileBasicInfo+CoreDataClass.h"
#import "HDFileBasicInfoModel.h"

@interface HDDatabaseManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (HDDatabaseManager *)shareInstance;

- (HDFileBasicInfo *)insertFileBasicInfoIntoSource:(HDFileBasicInfoModel*)model tableName:(NSString *)tableName;

- (NSArray *)objectsFromSourceWithTableName:(NSString *)tableName;

@end
