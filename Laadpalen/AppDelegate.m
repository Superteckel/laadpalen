//
//  AppDelegate.m
//  Laadpalen
//
//  Created by Max van Doren on 05-12-14.
//  Copyright (c) 2014 Max van Doren. All rights reserved.
//

#import "AppDelegate.h"
#import "Globals.h"
#import "SQL.h"
#import "FMDatabase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize database;
@synthesize laadpalen, laadpaal, laadpalenPredicate;
@synthesize LaadpalenVCLaadpalen;
#pragma page SQL initialisatie

- (void)initSQL {
    NSString *pathName = [SQL pathToDB:VERSION
                          dbsDirectory:SQL_DBS_DIRECTORY
                               dbsName:SQL_DBS_NAME_DATABASE
                          dbsExtension:SQL_DBS_NAME_EXTENSION
                          ];
    database = [FMDatabase databaseWithPath:pathName];
    [database open];
    [database setLogsErrors:false];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    laadpalenPredicate = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @(2), SQL_COLUMN_COUNT
                                        , nil
                                        ];
    [self initSQL];
    laadpalen = [SQL sqlSelectLaadpalen:database laadpalenPredicate:laadpalenPredicate];
    NSLog(@"laadpalen = %zd", [laadpalen count]);
    for (NSInteger i = 0; i < [laadpalen count]; i++) {
        NSLog(@"-------------------------------");
        laadpaal = [laadpalen objectAtIndex:i];
        NSLog(@"laadpaal = %@", laadpaal);
        NSLog(@"longitude = %f", [[laadpaal objectForKey:SQL_COLUMN_LONGITUDE] floatValue]);

}
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