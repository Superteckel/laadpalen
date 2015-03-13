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
@synthesize laadpaalObject;
@synthesize laadpalenDetailVC;


- (void)initView {
    [self setTitle:LAADPALENVC_TITLE];
    laadpalenDetailVC  = [[self storyboard] instantiateViewControllerWithIdentifier:@"LaadpalenDetailVC"];
}


#pragma model
- (void)initLaadpalen {
    laadpalenSql = [[NSMutableArray alloc] init];
}


- (NSInteger)updateLaadpalen {
    [laadpalenSql removeAllObjects];
    //  hier gaan we het datamodel vullen
    //  eerst sql-statement uitvoeren
    //  n-rows krijg je terug
    //  je gaat n-NSDictionaries toeveogen met de velden: text en detailText
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[appDelegate laadpalen] count];
    NSDictionary *laadpaalDic;
    for (int i = 0; i < [[appDelegate laadpalen] count]; i++) {
        laadpaalObject = [[appDelegate laadpalen] objectAtIndex:i];
        NSString *cellText = [laadpaalObject objectForKey:SQL_COLUMN_ADDRESS];
        NSString *cellDetailText = [laadpaalObject objectForKey:SQL_COLUMN_TYPE];
        bool typeSnellader = [[laadpaalObject objectForKey:@"typeSnellader"] integerValue];
        
        laadpaalDic = [[NSDictionary alloc] initWithObjectsAndKeys:cellText, @"text", cellDetailText, @"detailText", typeSnellader, @"typeSnellader",nil];
        [laadpalenSql addObject:laadpaalDic];
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
    NSDictionary *laadpaal = [laadpalenSql objectAtIndex:[indexPath row]];
    UIImage *image = [UIImage imageNamed:IMAGE_SNELLADER];

    
    [[cell textLabel] setText:[laadpaal objectForKey:@"text"]];
    [[cell detailTextLabel] setText:[laadpaal objectForKey:@"detailText"]];
    
    [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:10]];
    [[cell detailTextLabel] setFont:[UIFont boldSystemFontOfSize:7]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if ([[laadpaal objectForKey:@"typeSnellader"] integerValue]) {
        [[cell imageView] setImage:image];        
    }
    return cell;
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
