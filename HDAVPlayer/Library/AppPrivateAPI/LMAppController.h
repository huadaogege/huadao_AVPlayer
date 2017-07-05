//
//  LMAppController.h
//  WatchSpringboard
//
//  Created by Andreas Verhoeven on 28-10-14.
//  Copyright (c) 2014 Lucas Menge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMApp.h"

@interface LMAppController : NSObject

@property (nonatomic, readonly) NSArray* installedApplications;

- (BOOL)openAppWithBundleIdentifier:(NSString*)bundleIdentifier;
- (NSArray*)privateURLSchemes;
- (NSArray*)publicURLSchemes;
- (BOOL)applicationIsInstalled:(id)arg1;
- (void)removeObserver:(id)arg1;
- (void)addObserver:(id)arg1;
- (NSArray*)placeholderApplications;

+ (instancetype)sharedInstance;

@end
