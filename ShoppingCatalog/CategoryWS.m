//
//  CategoryWS.m
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 6/28/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import "CategoryWS.h"
#import "Constants.h"
#import "CategoryBean.h"

@implementation CategoryWS

-(NSArray *)wsGetCategories:(NSString *)parameters{
    NSArray *resultList;
    NSMutableArray *categories = [[NSMutableArray alloc]init];
    //NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_CATEGORY_JSON, parameters];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_CATEGORY_JSON, @"/api/categories"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSError *error;
    
    NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
    
    if (!error){
        resultList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        for (int i=0; i < resultList.count; i++){
            NSString *catId = [[resultList objectAtIndex:i] objectForKey:@"_id"];
            NSString *name = [[resultList objectAtIndex:i] objectForKey:@"name"];
            NSString *description = [[resultList objectAtIndex:i] objectForKey:@"description"];
            
            CategoryBean *category = [[CategoryBean alloc] init];
            category.catId = catId;
            category.name = name;
            category.catDescription = description;
            
            [categories addObject:category];
        }
    }
    return categories;
}

@end
