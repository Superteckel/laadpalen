//
//  FirstViewController.m
//  Laadpalen
//
//  Created by Max van Doren on 05-12-14.
//  Copyright (c) 2014 Max van Doren. All rights reserved.
//

#import "LaadpalenVC.h"
#import "SQL.h"
#import "Globals.h"
#import "FMDatabase.h"
#import "AppDelegate.h"
#import "LaadpalenDetailVC.h"
#import "Localization.h"
#import "Images.h"


@interface LaadpalenVC ()
@end


@implementation LaadpalenVC
@synthesize laadpalenSql;
@synthesize appDelegate;
@synthesize laadpaal;
@synthesize laadpalenDetailVC;



#pragma model
- (void)initLaadpalen {
    laadpalenSql = [[NSMutableArray alloc] init];
}
#warning test
- (NSInteger)updateLaadpalen {
    [laadpalenSql removeAllObjects];
    //  hier gaan we het datamodel vullen
    //  eerst sql-statement uitvoeren
    //  n-rows krijg je terug
    //  je gaat n-NSDictionaries toeveogen met de velden: text en detailText
    BOOL snellader;
    NSDictionary *laadpaalDict;
    for (int i = 0; i < [[appDelegate laadpalen] count]; i++) {
        snellader = [[laadpaal objectForKey:SQL_COLUMN_TYPE_SNELLADER] integerValue];
        laadpaal = [[appDelegate laadpalen] objectAtIndex:i];
        laadpaalDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                        [laadpaal objectForKey:SQL_COLUMN_ADDRESS], @"text"
                        , [laadpaal objectForKey:SQL_COLUMN_TYPE], @"detailText"
                        , snellader ? IMAGE_STATION_2 : IMAGE_STATION_1, @"image"
                        ,nil
                        ];
        [laadpalenSql addObject:laadpaalDict];
    }
    return [laadpalenSql count];
}

#pragma delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [appDelegate setLaadpalenVCLaadpalen:[[appDelegate laadpalen] objectAtIndex:[indexPath row]]];
    [[self navigationController] pushViewController:laadpalenDetailVC animated:YES];
}


#pragma datasource


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [laadpalenSql count];
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@ %d"
            , LAADPALENVC_TABLEVIEW_HEADER
            , [laadpalenSql count]
            ];
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"bokkelul"];
    NSDictionary *laadpaalDict = [laadpalenSql objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[laadpaalDict objectForKey:@"text"]];
    [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:11]];
    
    [[cell detailTextLabel] setText:[laadpaalDict objectForKey:@"detailText"]];
    [[cell detailTextLabel] setFont:[UIFont systemFontOfSize:8]];
    [[cell detailTextLabel] setTextColor:[UIColor grayColor]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [[cell imageView] setImage:[UIImage imageNamed:[laadpaalDict objectForKey:@"image"]]];
    return cell;
}


#pragma view


- (void)initView {
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setTitle:LAADPALENVC_TITLE];
    laadpalenDetailVC  = [[self storyboard] instantiateViewControllerWithIdentifier:@"LaadpalenDetailVC"];
}


- (void)viewDidLoad {
    [self initView];
    [self initLaadpalen];
    [self updateLaadpalen];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
