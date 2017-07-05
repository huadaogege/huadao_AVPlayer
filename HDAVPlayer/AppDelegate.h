//
//  AppDelegate.h
//  HDAVPlayer
//
//  Created by huadao on 17/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

