//
//  AppDelegate.h
//  Laadpalen
//
//  Created by Max van Doren on 05-12-14.
//  Copyright (c) 2014 Max van Doren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMDatabase;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FMDatabase *database;
@property (nonatomic, retain) NSArray *laadpalen;
@property (nonatomic, retain) NSDictionary *LaadpalenVCLaadpalen;
@end


