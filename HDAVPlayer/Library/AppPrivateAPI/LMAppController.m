//
//  LMAppController.m
//  WatchSpringboard
//
//  Created by Andreas Verhoeven on 28-10-14.
//  Copyright (c) 2014 Lucas Menge. All rights reserved.
//

#import "LMAppController.h"

@interface PrivateApi_LSApplicationWorkspace
- (NSArray*)allInstalledApplications;
- (bool)openApplicationWithBundleID:(id)arg1;
- (NSArray*)privateURLSchemes;
- (NSArray*)publicURLSchemes;
- (BOOL)applicationIsInstalled:(id)arg1;
- (void)removeObserver:(id)arg1;
- (void)addObserver:(id)arg1;
- (id)placeholderApplications;
@end


#pragma mark -

@implementation LMAppController
{
  PrivateApi_LSApplicationWorkspace* _workspace;
  NSArray* _installedApplications;
}

- (instancetype)init
{
	self = [super init];
	if(self != nil)
	{
		_workspace = [NSClassFromString(@"LSApplicationWorkspace") new];
	}
	
	return self;
}

- (NSArray*)privateURLSchemes
{
    return [_workspace privateURLSchemes];
}

- (NSArray*)publicURLSchemes
{
    return [_workspace publicURLSchemes];
}

- (NSArray*)readApplications
{
	NSArray* allInstalledApplications = [_workspace allInstalledApplications];
	NSMutableArray* applications = [NSMutableArray arrayWithCapacity:allInstalledApplications.count];
	for(id proxy in allInstalledApplications)
	{
		LMApp* app = [LMApp appWithPrivateProxy:proxy];
		if(!app.isHiddenApp)
		{
			[applications addObject:app];
		}
	}
	
	return applications;
}

- (NSArray*)installedApplications
{
//	if(nil == _installedApplications)
//	{
		_installedApplications = [self readApplications];
//	}
	
	return _installedApplications;
}

- (BOOL)openAppWithBundleIdentifier:(NSString *)bundleIdentifier
{
	return (BOOL)[_workspace openApplicationWithBundleID:bundleIdentifier];
}

- (BOOL)applicationIsInstalled:(id)arg1 {
    return [_workspace applicationIsInstalled:arg1];
}

- (void)addObserver:(id)arg1 {
    [_workspace addObserver:arg1];
}

- (void)removeObserver:(id)arg1 {
    [_workspace removeObserver:arg1];
}

- (NSArray*)placeholderApplications {
    NSArray* placeholderApplications = [_workspace placeholderApplications];
    NSMutableArray* applications = [NSMutableArray arrayWithCapacity:placeholderApplications.count];
    for(id proxy in placeholderApplications)
    {
        LMApp* app = [LMApp appWithPrivateProxy:proxy];
        if(!app.isHiddenApp)
        {
            [applications addObject:app];
        }
    }
    return applications;
}

+ (instancetype)sharedInstance
{
  static dispatch_once_t once;
  static id sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

@end
