//
//  ViewController.m
//  zz
//
//  Created by jky-group on 14-6-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
    NSArray *_arrCities;
}
@end
/////////////////
@implementation ViewController
int count = 0;
- (void)viewDidLoad
{
    //[super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"02.png"]];
    _arrCities = [NSArray array];
    // http://www.weather.com.cn/data/cityinfo/101250101.html
    // http://m.weather.com.cn/atad/101150401.html
    // 首先加载
    [self loadCitiy:@"101250101"];
    // 申明一个top
    UISwipeGestureRecognizer *recongizer;
    recongizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(gestureFrom:)];
    [recongizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:recongizer];
    // [recongizer release];
    recongizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(gestureFrom:)];
    [recongizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view]addGestureRecognizer:recongizer];
    
}
#pragma mark 判断手势的左右滑动
- (void)gestureFrom :(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
         NSLog(@"left");
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
    }
}
#pragma mark 获取数据加载到页面
- (void)loadCitiy :(NSString *)str
{
    // 得到路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://m.weather.com.cn/atad/%@.html",str]];
    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 通过网络请求得到数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // xml的解析
    NSData * data1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    //判断json解析出来的数据是字典类型还是数组类型
    if([data1 isKindOfClass:[NSDictionary class]])
    {
        NSDictionary * dic = [NSDictionary dictionary];
        dic = (NSDictionary *)data1;
        NSDictionary * weatherDict = [dic objectForKey:@"weatherinfo"];
        //取出json解析出来的城市天气相应信息
        _cDate.text = [weatherDict objectForKey:@"date_y"];
        _cWeek.text = [weatherDict objectForKey:@"week"];
        _cLunar.text = [weatherDict objectForKey:@"date"];
        _cCitiy.text = [weatherDict objectForKey:@"city"];
        _cClimate.text = [weatherDict objectForKey:@"weather1"];
        _chigh.text = [weatherDict objectForKey:@"temp1"];
        _low.text = [weatherDict objectForKey:@"fx1"];
        _cHot.text = [weatherDict objectForKey:@"index"];
        _cPenetr.text = [weatherDict objectForKey:@"index_d"];
        
    }

}
#pragma mark 控制键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_seekBtn resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark 获取按钮点击事件
- (IBAction)btnSeek {
    BOOL bol = 0;
    NSLog(@"%@",_seekBtn.text);
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"china" ofType:@"plist"]];
    for (id tier1 in array) {
        for (id tier2 in tier1) {
            if ([tier2 isKindOfClass:[NSArray class]]) {
                for (id tier3 in tier2) {
                    if ([tier3 isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *dic in tier3) {
                            NSLog(@"%@",dic[@"name"]);
                            if ([dic[@"name"] isEqualToString:_seekBtn.text]) {
                                bol = 1;
                                [self loadCitiy:dic[@"weatherCode"]];
                            }
                        }
                    }
                }
            }
        }
    }
    if (bol == 0) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的输入有误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
    }
    
}
@end
