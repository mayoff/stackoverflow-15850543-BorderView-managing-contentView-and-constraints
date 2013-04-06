//
//  ViewController.m
//  borderview
//
//  Created by Rob Mayoff on 4/6/13.
//  Copyright (c) 2013 Rob Mayoff. All rights reserved.
//

#import "ViewController.h"
#import "BorderView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UISlider *topSlider;
@property (strong, nonatomic) IBOutlet UISlider *leftSlider;
@property (strong, nonatomic) IBOutlet UISlider *bottomSlider;
@property (strong, nonatomic) IBOutlet UISlider *rightSlider;
@property (strong, nonatomic) IBOutlet BorderView *borderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateBorderViewBorderSize];
}

- (IBAction)sliderValueDidChange {
    [self updateBorderViewBorderSize];
}

- (void)updateBorderViewBorderSize {
    self.borderView.borderSize = UIEdgeInsetsMake(self.topSlider.value, self.leftSlider.value, self.bottomSlider.value, self.rightSlider.value);
}

@end
