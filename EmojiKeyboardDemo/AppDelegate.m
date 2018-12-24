//
//  AppDelegate.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/12.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RootViewController *rootVC = [RootViewController new];
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = rootNC;
    [self.window makeKeyAndVisible];
    
//    NSString *emojiBundlePath = [[NSBundle mainBundle] pathForResource:@"EmojiPackage" ofType:@"bundle"];
//    NSBundle *emojiBundle = [NSBundle bundleWithPath:emojiBundlePath];
//    NSString *emojiPath = [emojiBundle pathForResource:@"EmojiPackageList" ofType:@"plist"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:emojiPath];
//
//    NSMutableArray *arrM = [NSMutableArray array];
//    for (int i = 0; i < array.count; i ++) {
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//        NSMutableArray *emojis = [NSMutableArray array];
//        NSArray *arr = array[i][@"emojis"];
//        for (int i = 0; i < arr.count; i ++) {
//            NSDictionary *emojiDict = arr[i];
//            NSString *imageStr = emojiDict[@"image"];
//            imageStr = [imageStr stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
//            if (!([imageStr hasSuffix:@"gif"] || [imageStr hasSuffix:@"png"])) {
//                imageStr = [NSString stringWithFormat:@"%@.png", imageStr];
//            }
//            [emojis addObject:@{@"desc":emojiDict[@"desc"], @"image":imageStr}];
//        }
//        [dict setValue:array[i][@"cover_pic"] forKey:@"cover_pic"];
//        [dict setValue:array[i][@"folderName"] forKey:@"folderName"];
//        [dict setValue:array[i][@"title"] forKey:@"title"];
//        [dict setValue:array[i][@"isLargeEmoji"] forKey:@"isLargeEmoji"];
//        [dict setValue:emojis forKey:@"emojis"];
//        [arrM addObject:dict];
//    }
//    [arrM writeToFile:@"/Users/yangyibo/Desktop/Emoji/EmojiPackageList.plist" atomically:YES];
    return YES;
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


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
