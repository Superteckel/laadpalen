//
//  LaadpalenDetailVC.h
//  Laadpalen
//
//  Created by Max van Doren on 16-02-15.
//  Copyright (c) 2015 Max van Doren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface LaadpalenDetailVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) AppDelegate *appDelegate;
@property (nonatomic, retain) NSMutableArray *laadpalenAttributesArray;
@end
