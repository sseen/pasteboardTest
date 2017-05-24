//
//  AppDelegate.m
//  pasteboardTest
//
//  Created by sseen on 2017/5/23.
//  Copyright © 2017年 sseen. All rights reserved.
//

#import "AppDelegate.h"


NSUInteger pasteboardChangeCount_;


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(pasteboardChangedNotification:)
     name:UIPasteboardChangedNotification
     object:nil]; // ios 10 有个bug 这里如果是 object:[UIPasteboard generalPasteboard]]; 就不会回掉
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(pasteboardChangedNotification:)
     name:UIPasteboardRemovedNotification
     object:[UIPasteboard generalPasteboard]];
    
    return YES;
}

- (void)pasteboardChangedNotification:(NSNotification*)notification {
    pasteboardChangeCount_ = [UIPasteboard generalPasteboard].changeCount;
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
    if (pasteboardChangeCount_ != [UIPasteboard generalPasteboard].changeCount) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:UIPasteboardChangedNotification
         object:[UIPasteboard generalPasteboard]];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
