//
//  ViewController.m
//  SqlLite
//
//  Created by Mirac Okan on 31.07.2018.
//  Copyright © 2018 Mirac Okan. All rights reserved.
//

#import "ViewController.h"
#import "Database.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Database * db = [Database new];
    [db getDBFilePath];
    [db createTable:[db getDBFilePath]];
    
    
    
    [db insert:[db getDBFilePath] witHUserName:@"Test User" withUserId:@"1" withStatus:@"1"];
    NSArray * ary1 = [db getRecords:[db getDBFilePath] where:nil];
    NSLog(@"ary1 = %@",ary1);
    [db deleteUser:[db getDBFilePath] withStatus:@"1"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Database *db  = [Database new];
    NSArray * aryy = [db getRecords:[db getDBFilePath] where:nil];
    
//    NSArray * arry = [db getRecords:[db getDBFilePath] where:[NSString stringWithFormat:@"cityCode=\"%@\"",cityC]withCityCode:cityC];
    [self setArray:aryy];
    
    
}
-(void) setArray:(NSArray *) array_
{
    ary = [NSArray arrayWithArray:array_];
//    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
