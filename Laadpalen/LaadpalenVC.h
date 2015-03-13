//
//  FirstViewController.h
//  Laadpalen
//
//  Created by Max van Doren on 05-12-14.
//  Copyright (c) 2014 Max van Doren. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AppDelegate;
@class LaadpalenDetailVC;


@interface LaadpalenVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSMutableArray *laadpalenSql;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (nonatomic, retain) NSDictionary *laadpaalObject;
@property (nonatomic, retain) LaadpalenDetailVC *laadpalenDetailVC;


@end

