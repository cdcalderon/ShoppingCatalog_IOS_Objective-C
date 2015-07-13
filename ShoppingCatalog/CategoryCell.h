//
//  CategoryCell.h
//  ShoppingCatalog
//
//  Created by Carlos Calderon on 7/7/15.
//  Copyright (c) 2015 constructisystems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryBean.h"


@interface CategoryCell : UITableViewCell{
    NSURLConnection *connection;
    NSMutableData *data;
    UIActivityIndicatorView *activity;
}

@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitleLabel;
@property (strong, nonatomic) CategoryBean *category;

-(void) loadImage;
-(NSString *) getDBPath;
@end
