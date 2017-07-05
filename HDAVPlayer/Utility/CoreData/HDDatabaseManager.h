//
//  HDDatabaseManager.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/5.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HDDatabaseManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (HDDatabaseManager *)shareInstance;

//- (HDFileInfo *)insertFileBasicInfoIntoSource:(HDFileBasicInfoModel*)model tableName:(NSString *)tableName;
//
//- (NSArray *)objectsFromSourceWithTableName:(NSString *)tableName;

@end
