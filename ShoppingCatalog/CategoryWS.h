//
//  CategoryWS.h
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 6/28/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryWS : NSObject

-(NSArray *) wsGetCategories:(NSString *) parameters;
@end
