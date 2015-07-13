//
//  CategoryDAO.h
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 7/7/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "CategoryBean.h"

@interface CategoryDAO : NSObject
{
    sqlite3 *base;
}

//DB Methods
-(void) checkAndCreateDatabase;
-(void) openDatabase;
-(NSString *) getDBPath;
-(NSString *) daoGetTotalRecords;
-(NSString *) daoGetEstModMax;
-(BOOL) daoExistCategory: (CategoryBean *) category;
-(void) daoUpdateCategory: (CategoryBean *) category;
-(void) daoCreateCategory: (CategoryBean *) category;
@end
