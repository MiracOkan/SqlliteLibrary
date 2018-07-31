//
//  Database.m
//  MyFreeProject
//
//  Created by Asis on 11/04/2017.
//  Copyright © 2017 Mirac. All rights reserved.
//

#import "Database.h"

@implementation Database



-(NSString *)testMethod:(NSString *)data{

//    data  = @"ASD";
    NSLog(@"%@",data);
    
    return data;
}


-(NSString*)getDBFilePath{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [docPath stringByAppendingPathComponent:@"Login.db"];
}


-(int)createTable:(NSString *) filePath{
    
    sqlite3 * db = NULL;
    
    int record = 0;
    
    record = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE,NULL);
    if (SQLITE_OK != record) {
        sqlite3_close(db);
        NSLog(@"Connection Failed");
    }
    else{
        //        "CREATE TABLE IF NOT EXISTS students ( id INTEGER PRIMARY KEY AUTOINCREMENT, name  TEXT, age INTEGER, marks INTEGER )"
        NSString *queryString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS LoginUser ( id INTEGER PRIMARY KEY AUTOINCREMENT, LoginUserName  TEXT, LoginUserId TEXT ,LoginStatus TEXT)"];
        const char * query = [queryString UTF8String];
        char * errMsg;
        record = sqlite3_exec(db, query, NULL, NULL, &errMsg);
        
        NSLog(@"Success");
        
        if (SQLITE_OK != record) {
            NSLog(@"Failed");
        }
        sqlite3_close(db);
    }
    return record;
}

-(int) insert:(NSString *)filePath witHUserName:(NSString *)userName withUserId : (NSString *)userId withStatus:(NSString*)status{
    sqlite3* db = NULL;
    int record=0;
    record = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != record)
    {
        sqlite3_close(db);
        NSLog(@"Connection Failed");
    }
    else
    {
      
        NSString * query  = [NSString stringWithFormat:@"INSERT INTO LoginUser (LoginUserName,LoginUserId,LoginStatus) VALUES (\"%@\",\"%@\",\"%@\")",userName,userId,status];
        char * errMsg;
        record = sqlite3_exec(db, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != record)
        {
            NSLog(@"Not Add  rc:%d, msg=%s",record,errMsg);
        }
        sqlite3_close(db);
    }
    return record;
}


-(NSArray *) getRecords:(NSString*) filePath where:(NSString *)whereStmt
{
    NSMutableArray * tablenameStmt =[[NSMutableArray alloc] init];
    sqlite3* db = NULL;
    sqlite3_stmt* stmt =NULL;
    int rc=0;
    rc = sqlite3_open_v2([filePath UTF8String], &db, SQLITE_OPEN_READONLY , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Connection Failed");
    }
    else
    {
        NSString  * query = [NSString stringWithFormat:@"Select * From LoginUser"];
        if(whereStmt)
        {
            query = [query stringByAppendingFormat:@" WHERE %@",whereStmt];
        }
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW) //get each row in loop
            {
                
                NSString * userName =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString * userId =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                NSString * status =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];

                
                NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:userName,@"userName",userId,@"userId",status,@"status",nil];

                [tablenameStmt addObject:dic];

            }
            NSLog(@"Login Tablosunun Kayıtları Başarı ile çekildi.");
            sqlite3_finalize(stmt);
        }
        else
        {
            NSLog(@"Sorgu yapılamadı:%d",rc);
        }
        sqlite3_close(db);
    }
    
    return tablenameStmt;
    
}

-(int)deleteUser:(NSString*) filePath withuserId:(NSString*) userId
{
    sqlite3* db = NULL;
    int record=0;
    record = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != record)
    {
        sqlite3_close(db);
        NSLog(@"Connection Failed");
    }
    else
    {
        NSString * query  = [NSString stringWithFormat:@"DELETE FROM LoginUser where LoginUserId=\"%@\"",userId];
        char * errMsg;
        record = sqlite3_exec(db, [query UTF8String] ,NULL,NULL,&errMsg);
        NSLog(@"Record deleted");
        if(SQLITE_OK != record)
        {
            NSLog(@"Failed rc:%d, msg=%s",record,errMsg);
        }
        sqlite3_close(db);
    }
    
    return  record;
}

@end
