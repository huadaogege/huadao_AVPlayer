//
//  HDDatabaseManager.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/5.
<<<<<<< HEAD
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

=======
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDFileBasicInfo+CoreDataClass.h"
#import "HDFileBasicInfoModel.h"
>>>>>>> origin/develop-cyg

@interface HDDatabaseManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (HDDatabaseManager *)shareInstance;

<<<<<<< HEAD
//- (HDFileInfo *)insertFileBasicInfoIntoSource:(HDFileBasicInfoModel*)model tableName:(NSString *)tableName;
//
//- (NSArray *)objectsFromSourceWithTableName:(NSString *)tableName;
=======
- (HDFileBasicInfo *)insertFileBasicInfoIntoSource:(HDFileBasicInfoModel*)model tableName:(NSString *)tableName;

- (NSArray *)objectsFromSourceWithTableName:(NSString *)tableName;
>>>>>>> origin/develop-cyg

@end
