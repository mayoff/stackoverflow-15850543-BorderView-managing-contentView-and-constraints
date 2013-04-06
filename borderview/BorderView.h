//
//  BorderView.h
//  borderview
//
//  Created by Rob Mayoff on 4/6/13.
//  Copyright (c) 2013 Rob Mayoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorderView : UIView

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic) UIEdgeInsets borderSize;

@end
