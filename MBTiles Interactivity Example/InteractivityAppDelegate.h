//
//  InteractivityAppDelegate.h
//  MBTiles Interactivity Example
//
//  Created by Justin Miller on 8/23/11.
//  Copyright 2011 Development Seed. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InteractivityViewController;

@interface InteractivityAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet InteractivityViewController *viewController;

@end