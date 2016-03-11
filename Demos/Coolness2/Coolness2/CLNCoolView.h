//
//  CLNCoolView.h
//  Coolness
//
//  Created by Student on 3/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CLNCoolView : UIView

@property (assign, nonatomic) BOOL highlighted;

@property (copy, nonatomic) IBInspectable NSString *text;

@end
