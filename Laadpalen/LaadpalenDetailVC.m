//
//  LaadpalenDetailVC.m
//  Laadpalen
//
//  Created by Max van Doren on 16-02-15.
//  Copyright (c) 2015 Max van Doren. All rights reserved.
//

#import "LaadpalenDetailVC.h"
#import "AppDelegate.h"
#import "SQL.h"


@interface LaadpalenDetailVC ()

@end

@implementation LaadpalenDetailVC

@synthesize appDelegate;
@synthesize laadpalenAttributesArray;


- (NSInteger)updateLaadpalenAttributes {
    laadpalenAttributesArray = [[NSMutableArray alloc] init];
    
    NSDictionary *laadpaal = [appDelegate LaadpalenVCLaadpalen];
    NSDictionary *laadpaalAttribute;
    
    [laadpalenAttributesArray removeAllObjects];
    laadpaalAttribute = [NSDictionary dictionaryWithObjectsAndKeys:[laadpaal objectForKey:SQL_COLUMN_ADDRESS], @"text", @"address", @"detailText", nil];
    [laadpalenAttributesArray addObject:laadpaalAttribute];
    
    laadpaalAttribute = [NSDictionary dictionaryWithObjectsAndKeys:[laadpaal objectForKey:SQL_COLUMN_TYPE], @"text", @"type", @"detailText", nil];
    [laadpalenAttributesArray addObject:laadpaalAttribute];
    
    NSString *latitudeString = [[NSString alloc] initWithFormat:@"%@",[laadpaal objectForKey:@"latitude"]];
    laadpaalAttribute = [NSDictionary dictionaryWithObjectsAndKeys:latitudeString, @"text", @"latitude", @"detailText", nil];
    [laadpalenAttributesArray addObject:laadpaalAttribute];
    
    NSString *longitudeString = [[NSString alloc] initWithFormat:@"%@",[laadpaal objectForKey:@"longitude"]];
    laadpaalAttribute = [NSDictionary dictionaryWithObjectsAndKeys:longitudeString, @"text", @"longitude", @"detailText", nil];
    [laadpalenAttributesArray addObject:laadpaalAttribute];
    
    return [laadpalenAttributesArray count];
}


#pragma datasource


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [laadpalenAttributesArray count];
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"bokkelul"];
    NSDictionary *laadpaalAttribute = [laadpalenAttributesArray objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[laadpaalAttribute objectForKey:@"text"]];
    [[cell detailTextLabel] setText:[laadpaalAttribute objectForKey:@"detailText"]];
    
    [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:10]];
    [[cell detailTextLabel] setFont:[UIFont boldSystemFontOfSize:7]];
    return cell;
}


#pragma view


- (void)viewDidLoad {
    NSLog(@"Selected laadpaal = %@", [appDelegate LaadpalenVCLaadpalen]);

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self updateLaadpalenAttributes];
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
