//
//  AppDelegate.m
//  Hypnosister
//
//  Created by Fernando Castor on 07/01/15.
//  Copyright (c) 2015 Fernando Castor. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    // In the line above, "bounds" has type CGRect.
    
    CGRect firstFrame = self.window.bounds;
/*    firstFrame.origin.x = 160;
    firstFrame.origin.y = 240;
    firstFrame.size.height = 150;
    firstFrame.size.width = 100;
*/
//    CGRect secondFrame = CGRectMake(20, 30, 50, 50);
    
    // Alternatively, we could have used the CGRectMake
    // C function, defined in CGGeometry.h.
    // firstFrame = CGRectMake(160, 240, 100, 150);
    
    HypnosisView *hypView = [[HypnosisView alloc] initWithFrame:firstFrame];
    
//    HypnosisView *secondView = [[HypnosisView alloc] initWithFrame:secondFrame];
    
//    secondView.backgroundColor = [UIColor blueColor];

//    hypView.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:hypView];
//    [hypView addSubview:secondView];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
