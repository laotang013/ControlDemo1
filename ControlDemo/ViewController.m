//
//  ViewController.m
//  ControlDemo
//
//  Created by Start on 2017/7/26.
//  Copyright © 2017年 het. All rights reserved.
//
// 定义这个常量，就可以不用在开发过程中使用"mas_"前缀。
#define MAS_SHORTHAND
// 定义这个常量，就可以让Masonry帮我们自动把基础数据类型的数据，自动装箱为对象类型。
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>
#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
/**label*/
@property(nonatomic,strong)UILabel *testLabel;

/**textFiled*/
@property(nonatomic,strong)UITextField *textFiled;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)test1
{
    //CGAffineTrans的实现
    [UIView animateWithDuration:2 animations:^{
        //http://www.jianshu.com/p/ca7f9bc62429
        //实现以初始位置为基准, 当tx为正值时,会向x轴正方向平移,反之,则向x轴负方向平移;当ty为正值时,会向y轴正方向平移,反之,则向y轴负方向平移
        // _testLabel.transform = CGAffineTransformMakeTranslation(0, 200);
        
        //CGAffineTransformTranslate实现以一个已经存在的形变为基准,在x轴方向上平移x单位,在y轴方向上平移y单位
        //_testLabel.transform = CGAffineTransformTranslate(_testLabel.transform, 0, 40);
        
        //缩放
        // 当sx为正值时,会在x轴方向上缩放x倍,反之,则在缩放的基础上沿着竖直线翻转;当sy为正值时,会在y轴方向上缩放y倍,反之,则在缩放的基础上沿着水平线翻转
        // _testLabel.transform = CGAffineTransformMakeScale(-2, 2);
        
        //CGAffineTransformScale实现以一个已经存在的形变为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍
        //_testLabel.transform = CGAffineTransformScale(_testLabel.transform, 2, 1);
        
        //旋转
        //实现以初始位置为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)
        //注1: 当angle为正值时,逆时针旋转坐标系统,反之顺时针旋转坐标系统
        //注2: 逆时针旋转坐标系统的表现形式为对控件进行顺时针旋转
        //_testLabel.transform = CGAffineTransformMakeRotation(-M_PI);
        
        //CGAffineTransformRotate实现以一个已经存在的形变为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)
        //_testLabel.transform = CGAffineTransformRotate(_testLabel.transform, M_PI);
        
    }];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [UIView animateWithDuration:0.25 animations:^{
    //            _testLabel.transform = CGAffineTransformIdentity;
    //        }];
    //    });
    
    
}

-(void)test2
{
    //http://www.jianshu.com/p/4d38889500df
    UITextField *textFiled = [[UITextField alloc]init];
    [self.view addSubview:textFiled];
    [textFiled makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testLabel.bottom).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(-10);
        make.height.equalTo(44);
        
    }];
    
    textFiled.borderStyle = UITextBorderStyleLine;
    textFiled.placeholder = @"文本输入框";
    //显示删除按钮的模式
    textFiled.clearButtonMode = UITextFieldViewModeAlways;
    //设置开始编辑时是否删除原有的内容
    textFiled.clearsOnBeginEditing = YES;
    //设置return键返回类型
    textFiled.returnKeyType = UIReturnKeyDone;
    //自定义键盘辅助视图
    UIView *keyBoardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    keyBoardView.backgroundColor = [UIColor orangeColor];
    textFiled.inputAccessoryView = keyBoardView;
    
    //自定义键盘
    UIView *keyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    keyView.backgroundColor = [UIColor redColor];
    textFiled.inputView = keyView;
    
    //添加编辑框的左右视图
    textFiled.leftViewMode = UITextFieldViewModeWhileEditing;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    leftView.backgroundColor = [UIColor grayColor];
    textFiled.leftView = leftView;
    self.textFiled = textFiled;
    //编辑框的代理方法
    textFiled.delegate = self;
    
    [textFiled addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidChange
{
    NSLog(@"dd");
}
//限定只能输入一定长度的字符
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //string指此时输入的那个字符。textFiled表示此时正在输入的那个输入框 返回YES就是可以改变输入框的值。
    NSLog(@"Range: %@  string:%@",NSStringFromRange(range),string);
    NSString *toStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"toStr: %@",toStr);
    
    //限制只能输入特定的字符
    //    NSCharacterSet *cs;
    //    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
    //    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    if (textField == self.textFiled) {
        if ([toStr length] > 5) {
            NSLog(@"长度超过了5");
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
