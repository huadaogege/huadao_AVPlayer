//
//  HDFileBasicInfo+CoreDataProperties.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/5.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDFileBasicInfo+CoreDataProperties.h"

@implementation HDFileBasicInfo (CoreDataProperties)

+ (NSFetchRequest<HDFileBasicInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HDFileBasicInfo"];
}

@dynamic fileName;
@dynamic filePath;
@dynamic isRead;
@dynamic lastPro;

@end
