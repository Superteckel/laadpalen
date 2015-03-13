//
//  SecondViewController.m
//  Laadpalen
//
//  Created by Max van Doren on 05-12-14.
//  Copyright (c) 2014 Max van Doren. All rights reserved.
//

#import "SettingsVC.h"
#import "Globals.h"
#import "Localization.h"

@interface SettingsVC ()

@end

@implementation SettingsVC


#pragma datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return INFOVC_TABLEVIEW_HEADER;
}


#pragma view


- (void)initView {
    [self setTitle:INFOVC_TITLE];
}

- (void)viewDidLoad {
    [self initView];
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
