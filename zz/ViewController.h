//
//  ViewController.h
//  zz
//
//  Created by jky-group on 14-6-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *cDate;
@property (weak, nonatomic) IBOutlet UILabel *cWeek;
@property (weak, nonatomic) IBOutlet UILabel *cLunar;
@property (weak, nonatomic) IBOutlet UILabel *cCitiy;
@property (weak, nonatomic) IBOutlet UILabel *cClimate;
@property (weak, nonatomic) IBOutlet UILabel *chigh;
@property (weak, nonatomic) IBOutlet UILabel *low;
@property (weak, nonatomic) IBOutlet UITextField *seekBtn;
@property (weak, nonatomic) IBOutlet UILabel *cHot;
@property (weak, nonatomic) IBOutlet UILabel *cPenetr;
//@property (nonatomic, assign) int ;

- (IBAction)btnSeek;

@end
