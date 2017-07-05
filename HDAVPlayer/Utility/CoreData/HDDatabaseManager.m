//
//  HDDatabaseManager.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/5.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDDatabaseManager.h"
#import "AppDelegate.h"

@implementation HDDatabaseManager

+ (HDDatabaseManager *)shareInstance {
    static dispatch_once_t onceToken;
    static HDDatabaseManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[HDDatabaseManager alloc] init];
    });
    return manager;
}

-(NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];
    }
    return _managedObjectContext;
}

//- (NSArray *)objectsFromSourceWithTableName:(NSString *)tableName {
//    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:tableName inManagedObjectContext:self.managedObjectContext];
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:tableName];
//    [fetchRequest setEntity:entityDescription];
//    NSError *error;
//    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    if (error) {
//        NSLog(@"%@", error);
//    }
//    return array;
//}
//
//- (HDFileInfo *)insertFileBasicInfoIntoSource:(HDFileBasicInfoModel*)model tableName:(NSString *)tableName {
//    NSArray *insertedArray = [self objectsFromSourceWithTableName:tableName];
//    for (HDFileInfo *info in insertedArray) {
//        if ([info.filePath isEqualToString:model.filePath]) {
//            return info;
//        }
//    }
//    HDFileInfo *fileBasicInfo = (HDFileInfo *)[NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:self.managedObjectContext];
//    fileBasicInfo.fileName = model.fileName;
//    fileBasicInfo.filePath = model.filePath;
//    fileBasicInfo.isRead = model.isRead;
//    fileBasicInfo.lastProgress = model.lastProgress;
//    NSError *error;
//    if ([self.managedObjectContext save:&error]) {
//        NSLog(@"保存成功！");
//    }
//    return fileBasicInfo;
//}


@end
