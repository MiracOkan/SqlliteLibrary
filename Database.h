//
//  Database.h
//  MyFreeProject
//
//  Created by Mirac on 11/04/2017.
//  Copyright © 2017 Mirac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface Database : NSObject
//-(instancetype)init;


-(NSString*)testMethod : (NSString*)data;

//-(void)testMethod : (NSString*)data;

//CompanyTable
-(NSString*)getDBFilePath;

-(int)createTable:(NSString *) filePath;

-(int) insert:(NSString *)filePath witHUserName:(NSString *)userName withUserId : (NSString *)userId withStatus:(NSString*)status;

-(NSArray *) getRecords:(NSString*) filePath where:(NSString *)whereStmt;

-(int)deleteUser:(NSString*) filePath withuserId:(NSString*) userId;



@end
