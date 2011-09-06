//
//  InteractivityAppDelegate.m
//  MBTiles Interactivity Example
//
//  Created by Justin Miller on 8/23/11.
//  Copyright 2011 Development Seed. All rights reserved.
//

#import "InteractivityAppDelegate.h"

#import "InteractivityViewController.h"

@implementation InteractivityAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.viewController;

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    
    [super dealloc];
}

@end