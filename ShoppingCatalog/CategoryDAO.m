//
//  CategoryDAO.m
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 7/7/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import "CategoryDAO.h"
#import "Constants.h"

@implementation CategoryDAO

-(void) checkAndCreateDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataBasePath = [self getDBPath];
    
    success = [fileManager fileExistsAtPath:dataBasePath];
    if(!success){
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: DATABASE_NAME];
        [fileManager copyItemAtPath:databasePathFromApp toPath:dataBasePath error:nil];
        return;
    }
}

-(void)openDatabase{
    //Verify if DB exits
    [self checkAndCreateDatabase];
    NSString *dataBasePath = [self getDBPath];
    if(sqlite3_open([dataBasePath UTF8String], &base) != SQLITE_OK){
        sqlite3_close(base);
    }
}

-(NSString *) getDBPath{
    NSURL *urlDocuments = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *urlPath = [NSString stringWithFormat:@"%@/%@", [urlDocuments path], DATABASE_NAME];
    
    return urlPath;
}

-(NSString *) daoGetTotalRecords{
    [self openDatabase];
    NSString *sql = @"select count(*) from category";
    NSString *total = @"0";
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(base, [sql UTF8String], -1, &compiledStatement, nil) == SQLITE_OK){
        while(sqlite3_step(compiledStatement) == SQLITE_ROW){
            total =((char *) sqlite3_column_text(compiledStatement, 0)) ? [NSString stringWithUTF8String:(char *) sqlite3_column_text(compiledStatement, 0)] : @"@";
        }
    }
    sqlite3_close(base);
    return total;
}

-(NSString *) daoGetEstModMax{
    [self openDatabase];
    NSString *sql = @"select max(est_mod) from category";
    NSString *max = @"0";
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(base, [sql UTF8String], -1, &compiledStatement, nil) == SQLITE_OK){
        while(sqlite3_step(compiledStatement) == SQLITE_ROW){
            max =((char *) sqlite3_column_text(compiledStatement, 0)) ? [NSString stringWithUTF8String:(char *) sqlite3_column_text(compiledStatement, 0)] : @"@";
        }
    }
    sqlite3_close(base);
    return max;
}

-(BOOL) daoExistCategory: (CategoryBean *) category{
    [self openDatabase];
    BOOL result = false;
    NSString *sql = [NSString stringWithFormat:@"select id from category where id = %@", category.catId];
    NSString *max = @"0";
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(base, [sql UTF8String], -1, &compiledStatement, nil) == SQLITE_OK){
        while(sqlite3_step(compiledStatement) == SQLITE_ROW){
            result = true;
        }
    }
    sqlite3_close(base);
    return result;
}

-(void) daoUpdateCategory:(CategoryBean *)category{
    [self openDatabase];
    const char *sql = "";
    sqlite3_stmt *stmt = nil;
    sql = "update category set catDescription=?, name=? where catid=?";
    if(sqlite3_prepare_v2(base, sql, -1, &stmt, NULL) == SQLITE_OK){
        sqlite3_bind_text(stmt, 1, [category.name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [category.description UTF8String], -1, SQLITE_TRANSIENT);
    }
    if(sqlite3_step(stmt) != SQLITE_DONE){
        NSLog(@"ERROR UPDATING CATEGORY");
    }
    sqlite3_close(base);
}

-(void) daoCreateCategory:(CategoryBean *)category{
    [self openDatabase];
    const char *sql = "";
    sqlite3_stmt *stmt = nil;
    sql = "insert into category (name, catDescription) values(?, ?)";
    if(sqlite3_prepare_v2(base, sql, -1, &stmt, NULL) == SQLITE_OK){
        sqlite3_bind_text(stmt, 1, [category.name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 2, [category.description UTF8String], -1, SQLITE_TRANSIENT);
    }
    if(sqlite3_step(stmt) != SQLITE_DONE){
        NSLog(@"ERROR CREATING CATEGORY");
    }
    sqlite3_close(base);
}


@end
