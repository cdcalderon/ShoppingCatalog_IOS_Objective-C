//
//  CategoryBean.h
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 6/27/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryBean : NSObject

@property (strong, nonatomic) NSString *catId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *catDescription;
@property (strong, nonatomic) NSString *image;
@end
