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
#import <objc/objc.h>
#import <objc/runtime.h>
@interface ViewController ()<UITextFieldDelegate,UIPopoverPresentationControllerDelegate>
/**label*/
@property(nonatomic,strong)UILabel *testLabel;

/**textFiled*/
@property(nonatomic,strong)UITextField *textFiled;
/**testButton*/
@property(nonatomic,strong)UIButton *testButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *testButton = [[UIButton alloc] init];
    [testButton addTarget:self
                   action:@selector(onClick)
         forControlEvents:UIControlEventTouchUpInside];
    [testButton setTitle:@"点击" forState:UIControlStateNormal];
    [testButton setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:testButton];
    
    [testButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(50);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    self.testButton = testButton;
    

   // [self test5];
    [self test8];
    
    NSLog(@"self.view.subviews.count: %zd",self.view.subviews.count);
    NSLog(@"self.view.subviews: %@",self.view.subviews);

    [self test5];
    [self test9];

}

-(void)test1
{
    //CGAffineTrans的实现
    [UIView animateWithDuration:2 animations:^{
       /* http://www.jianshu.com/p/ca7f9bc62429
        实现以初始位置为基准, 当tx为正值时,会向x轴正方向平移,反之,则向x轴负方向平移;当ty为正值时,会向y轴正方向平移,反之,则向y轴负方向平移
         _testLabel.transform = CGAffineTransformMakeTranslation(0, 200);
        
        CGAffineTransformTranslate实现以一个已经存在的形变为基准,在x轴方向上平移x单位,在y轴方向上平移y单位
        _testLabel.transform = CGAffineTransformTranslate(_testLabel.transform, 0, 40);
        
        缩放
         当sx为正值时,会在x轴方向上缩放x倍,反之,则在缩放的基础上沿着竖直线翻转;当sy为正值时,会在y轴方向上缩放y倍,反之,则在缩放的基础上沿着水平线翻转
         _testLabel.transform = CGAffineTransformMakeScale(-2, 2);
        
        CGAffineTransformScale实现以一个已经存在的形变为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍
        _testLabel.transform = CGAffineTransformScale(_testLabel.transform, 2, 1);
        
        旋转
        实现以初始位置为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)
        注1: 当angle为正值时,逆时针旋转坐标系统,反之顺时针旋转坐标系统
        注2: 逆时针旋转坐标系统的表现形式为对控件进行顺时针旋转
        _testLabel.transform = CGAffineTransformMakeRotation(-M_PI);
        
        CGAffineTransformRotate实现以一个已经存在的形变为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)
        _testLabel.transform = CGAffineTransformRotate(_testLabel.transform, M_PI);
        */
    }];
    
     /*   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                _testLabel.transform = CGAffineTransformIdentity;
            }];
        });
    */
    
}
//UITextField
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

-(void)onClick
{
    //[self test4];
}

//UIAlertController
-(void)test3
{
    /*
     * UIAlertController以一种模块化替换的方式来代替这两货(UIAlertView以及UIActionSheet)的功能和作用
      UIAlertAction的实例 你可以将动作按钮添加到控制器上。UIAlertAction由标题字符串、样式、以及当用户选中该动作时运行的代码块组成。通过AlertActionStyle你可以选择如下三种动作样式：常规(default)、取消(cancel)以及警示(destruective)。
     */
    //1.创建 2.显示
    //按钮显示的次序取决于他们添加到对话框控制器上的次序，
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"标题" message:@"创建第一个按钮" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"登录";
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"密码";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    UIAlertAction *comformAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确认按钮");
        UITextField *login = alertVC.textFields.firstObject;
        NSLog(@"login:%@", login.text);
        //释放通知
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }];
    comformAction.enabled = NO;
    //修改按钮的颜色字体
    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    NSArray *array =  [self getPropertiesStr:@"UIAlertAction"];
    NSLog(@"array %@",array);
    [alertVC addAction:cancelAction];
    [alertVC addAction:comformAction];
        
    [self presentViewController:alertVC animated:YES completion:nil];
}

//给文本框添加一个通知 监听文本的长度变化。
-(void)alertTextFieldDidChange:(NSNotification *)notifaction
{
    UIAlertController *alertVC = (UIAlertController *)self.presentedViewController;
    if (alertVC) {
        UITextField *login = alertVC.textFields.firstObject;
        UIAlertAction *comfirm = alertVC.actions.lastObject;
        comfirm.enabled = login.text.length > 2;
    }
}
//UIAlertControllerStyleActionSheet
/*
  如果上拉菜单中有取消按钮的话，那么他永远都会出现在菜单底部。
 */


//UIPopoverPresentationController
-(void)test4
{
    //http://blog.csdn.net/u013346305/article/details/52174799
    //UIPopoverPresentationController 是个弹出的控件
    UIViewController *functionlistVC = [[UIViewController alloc]init];
    functionlistVC.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *pover = functionlistVC.popoverPresentationController;
    pover.delegate = self;
    //是指弹出时所参照的视图 与弹框的位置有关
    pover.sourceView = self.testButton;
    //是指弹出时参照视图的大小,与弹框的位置有关。
    pover.sourceRect = self.testButton.bounds;
    pover.backgroundColor = [UIColor orangeColor];
    //是弹框的箭头方向。
    pover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    [self presentViewController:functionlistVC animated:YES completion:nil];
    
}

//-(CGSize)preferredContentSize
//{
//    if (self.presentedViewController && self.view != nil) {
//        CGSize size = CGSizeMake(50, 50);
//        return size;
//    }else
//    {
//        return  [super preferredContentSize];
//    }
//}

-(void)test5
{
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 0, 0)];
    testLabel.backgroundColor = [UIColor whiteColor];
    testLabel.text = @"我们都有一个家啊，名字叫中国，家里攀着两条龙";
    testLabel.font = [UIFont systemFontOfSize:15];
    testLabel.textColor = [UIColor blackColor];
    
    [testLabel sizeThatFits:CGSizeMake(20, 20)];//会计算出最优的 size 但是不会改变 自己的 size，个人认为这个就是 label 自适应大小有用别的没什么用
    NSLog(@"testLabel sizeThatFits frame = %@", NSStringFromCGRect(testLabel.frame));
    NSLog(@"best size = %@",NSStringFromCGSize([testLabel sizeThatFits:CGSizeMake(20, 20)]));
    [testLabel sizeToFit];//会计算出最优的 size 而且会改变自己的size
    NSLog(@"testLabel sizeToFit frame = %@",NSStringFromCGRect(testLabel.frame));
    //[self.view  addSubview:testLabel];
}

//UIScrollView
-(void)test6
{
    /*
     http://blog.csdn.net/ccf0703/article/details/7595014
     UIScrollView有一个frame属性，同时UIScrollView还具有contentSize、contentOffset和contentInset属性
     UIScrollView的subView他的左右上下是相对于UIScrollView的ContentSize而不是bounds来决定的。
        API讲解: http://tech.glowing.com/cn/practice-in-uiscrollview/
             1)- (void)scrollViewDidScroll:(UIScrollView *)scrollView
               这个方法在任何方式触发contentOffset变化的时候都会被调用(包括用户拖动,减速过程,直接通过代码设置等)
                可以用于监控contentOffset的变化,并根据当前contentOffset对其他View做出随动调整。
             2) scrollViewWillEndDragging: withVelocity: targetContentOffset:
               通过修改targetContentOffset直接修改目标offset为整数页位置。
            3）重用机制：
                 3.1）维护一个重用队列
                 3.2）当元素离开可见范围时,removeFromSuperView并加入重用队列(queue)
                 3.3)当需要加入新的元素时，先尝试从重用队列中获取可重用的元素并且从可重用的元素队列中移除。
                 3.4）如果队列为空，新建元素。
                 
     */
}

//UICollectionView
-(void)test7
{
 /*   自定义Cell时先注册再使用。
#pragma mark  定义每个UICollectionView的横向间距
    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
    {
        return 0;
    }
    
#pragma mark  定义每个UICollectionView的纵向间距
    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
    {
        return 0;
    }
    
collectionView:numberOfItemsInSection: //返回每段显示的数据个数
collectionView:cellForItemAtIndexPath: // 返回数据的显示cell获取cell必须使用dequeueReusableCellWithReuseIdentifier:forIndexPath:方法，与TableView不同的是，这里不会返回nil，而是必须把cell的类别注册到collectionView供此方法调用，否则会出错。
   布局我们使用已经提供的UICollectionViewLayout的子类UICollectionViewFlowLayout，在初始化UICollectionView的时候传入 
2.UICollectionViewCell详解 https://cnbin.github.io/blog/2015/09/01/ios-uicollectionview-zong-jie/
    2.1 所有自定义View需要加入contentView中。
    2.2 实现prepareForReuse对重用cell进行必要清理。http://www.jianshu.com/p/ff96a8e5abdb
    cell重用如何提前知道,重写Cell的prepareForReuse当前已经被分配的cell如果被重用了(通常是滚动出屏幕外了),会调用cell的prepareForReuse通知cell.注意这里重写方法的时候,注意一定要调用父类方法[super prepareForReuse] .
    
    
    
    2.3 prepareLayout 此方法中出全部元素布局所需要的属性并以indexPath为关键字存入字典
    
    */
 
}

-(void)test8
{
    /*
     * addSubView 和 insertSubview 区别
     * 子视图是以栈的方式存放的。
     * 每次addSubView时都是在最后面添加。每次在addsubview前和addsubview后可以看看[self.view.subViews count]；
     * self.view addSubView:xx.View 等同于 self.view insertSubView:xx.View atIndex:self.view.subViews.count
     * 即在最底层增加View
     *addSubview是一层一层往上加，新加的只能放到最上层，
     *insertSubView可以控制将view添加到指定的层。
     */
    
    UILabel *label8 = [[UILabel alloc]init];
    label8.text = @"label8";
    [self.view addSubview:label8];
}

//UINavigationController
-(void)test9
{
    /*
     1.1 UINavigationBar类提供一种对导航栏层级内容的控制,他是一个栏，最典型的用法是用在屏幕的顶端，
     包含着各级视图的导航按钮， http://www.jianshu.com/p/f797793d683f
     1.1.1 UINavigationBar控制着导航栏的背景色(BarTintColor) 背景图片(backgroundImage) 按钮字体颜色(tintColor)
     标题文本属性:(titleTextAttributes) 半透明:(translucent)
     1.2 UINavigationItem对象管理展示在导航栏上的按钮和视图，
     1.2.1UINavgationController并没有navigationItem这样一个直接属性，由于UINavigationController继承于UIViewController而UINavigationController是有这个属性的。
     1.2.1 UINavigationItem是一个独特的实例，当视图控制器被推到导航控制器中时,他来代表这个视图控制器
     当第一次访问这个属性的时候它被创建，因此如果你并没有用导航控制器来管理视图控制器，那你不应该访问这个属性。为确保NavigationItem已经配置，你可以在视图控制器中初始化 重写这个属性。创建BarButtonItem。
     1.2.2 UINavigationItem有leftBarButtonitem（leftBarButtonItems）和rightBarButtonItem（rightBarButtonItems）
     每个属性都可以赋值装有一个UIBarButtonItem对象的数组。
     1.2.2.1    UIBarButtonItem是专门给UIToolBar和UINavigationBar定制的类似button的类。
     
     1.3 UINavgationController是一个特殊的视图容器。
     1.4 让滑动返回手势有效 http://www.jianshu.com/p/31f177158c9e
     1.4.1 如果使用自定义的按钮去替换系统默认的返回按钮,就会出现滑动返回手势失效的问题。解决办法:只需要重新添加导航栏的interactivePopGestureRecognizer的delegate即可。
     首先为ViewContoller添加UIGestureRecognizerDelegate协议
     设置代理self.navigationController.interactivePopGestureRecognizer.delegate = self;
     
     */
    
    self.navigationItem.title = @"测试导航栏";
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
}

//容器视图控制器
-(void)test10
{
    //http://www.jianshu.com/p/01bd6feb76e8
    /*容器视图控制器可以将多个视图控制器的内容结合到一个用户界面。容器视图控制器通常用于促进导航和基于现有内容创建新的用户界面。
      容器视图控制器如同其他任何内容控制器那样管理者一个根视图和一些内容。
     UIKit唯一的要求就是在容器视图控制器和其他子类视图控制器之间构建一个正式的父子关系。 将每个子视图添加到容器视图控制器中。
    1.0 构建自定义容器
        实现一个容器视图控制器,你必须建立视图控制器和其子视图控制器之间的关系。在你视图管理任何子视图控制器的视图前必须建立这些父子关系。
        这样做让UIKit知道视图控制器在管理子视图的大小和位置，可以在界面构造器中创建或者以编程的方式创建。当以编程的方式创建时,必须显示的添加和删除子视图。作为视图控制器设置的一部分
      1.1.1 调用容器视图控制器的 addChildViewController 告诉UIKit 容器视图控制器管理子视图控制器的视图。
      1.1.2 删除子视图控制器  removeFromParentViewController方法删除父子关系。
      1.1.3   删除子视图控制器会永久删除父视图和子视图之间的关系。当你不再需要它时，删除子视图控制器。例如，当新视图控制器push到导航堆栈时，导航控制器不移除当前子视图控制器。只有当他们被pop出栈时才会被删除。
    2.0 构建容器视图控制器
        2.1 只访问子视图控制器的根视图。容器应该只访问每个子视图控制器的根视图，即返回子视图的视图属性。它不应该访问子视图控制器的其他视图。
        2.2 子视图控制器不用了解容器。子视图控制器应该关注自己的内容，如果容器允许其行为被子视图控制器影响。应该使用代理模式来管理这些交互。
        2.3 优先使用普通视图设计你的容器。使用普通视图（而不是子视图控制器的视图）让你可以测试布局约束和简单环境过渡动画。当普通视图如预期那样工作，移除子视图控制器的视图。
    3.0：
      3.1定义控制器容器（Custom Container Controller），它的主要责任是明确怎么给用户呈现他的子元素（即容器内的控制器）
    4.0 实例讲解： http://blog.csdn.net/wflytoc/article/details/50212091
      4.0.1 侧边栏 侧边栏菜单是一个子视图控制器的根视图,而中心(侧边栏关闭时我们看到的)视图也是一个子视图控制器的根视图。这两个视图是同时存在的。因此我们可以使用容器视图来管理他们。之后根据情况来调整他们的frame。
      4.0.2 其实子视图控制器的根视图就是简单的视图UIView,只不过在添加到父视图控制器的根视图可以设置其frame。根据需求随时调整他们dede frame.
     4.1滚动切换子视图控制器：
     以腾讯新闻为例子讲解，头部就不再实现了，主要看下如何通过滚动来切换视图，我自己的解决办法是利用UIScrollView，将子视图控制器的根视图添加到上面，通过滚动来切换视图，而头部也是UIScrollView，上面添加按钮，如果点击按钮，可以改变下面UIScrollView的contentOffSet属性来切换视图。
     */
   
}
//UITabBarController
-(void)test11
{
    /*
     *
      1.0 UITabBar
      2.0 UITabBarItem 
        2.1 UITabBar上面的Tab都对应着一个ViewController,我们可以通过设置ViewController.tabBarItem来改变tabBar上对应的tab显示的内容。
        2.2 自定义TabBarItem的时候可以显示指定对应的文字和图片。另外UITabBarItem还有一个badgeValue,通过设置该属性可以在其右上角显示一个小的角标。
     2.3 UITabBar ，如果UITabBarController有N个子控制器,那么UITabBar内部就会有N 个UITabBarItem作为子控件与之对应。
         UITabBarItem⾥面显⽰什么内容,由对应子控制器的tabBarItem属性来决定
     3.0 改变UITabBarContoler中当前显示的viewController可以通过以下方法
        3.0.1 selectedIndex属性 通过该属性可以获得当前选中的ViewController,设置该属性，可以显示viewControllers中对应的index中的ViewController
        3.0.2 selectedViewController属性 通过该属性可以获取到当前显示的viewController，通过设置该属性可以设置当前选中的viewContrller同时更新selectedIndex。
     
         4.0 UITabBarController本身并不会显示任何视图,如果要显示视图则必须设置其ViewControllers属性。默认显示viewControllers[0] 这个属性是一个数组,他维护了所有的UITabBarController的子控制器。为了尽可能减少视图之间的耦合，所有的UITabBarController的子控制器的相关标题、图标等信息均由子控制器自己控制，UITabBarController仅仅作为一个容器存在
    
      5.0 UITabBarConroller声明周期:
           1.把子控制器都添加给TabBarController管理,当程序启动时它只会加载第一个添加的控制器的View。
           2.切换到第二个界面的时候，先把第一个界面的View移开，在把新的View添加上去,但是第一个View只是被移开没有被销毁。
     3.重新切换到第一个界面,第一个控制器直接ViewWillAppear，，没有执行viewDidLoad证明了2.中第一个view移除后并没有被销毁（因为它的控制器还存在，有一个强引用引用着它），且第二个界面的view移除后也没有被销毁。无论怎么切换，控制器和view都不会被销毁。
     UINavigationController和UITabBarController一个通过栈来管理，一个通过普通的数组来进行管理。
     http://www.jianshu.com/p/b934e6c52918
     */
    
    
}
//键盘事件
-(void)test12
{
    
}
-(void)setPreferredContentSize:(CGSize)preferredContentSize
{
    super.preferredContentSize = preferredContentSize;
}



#pragma mark - **************** UIPopoverPresentationControllerDelegate

//默认返回的是覆盖整个屏幕,需要设置成UIModalPresentationNone
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

//设置点击蒙版是否消失 默认为YES
-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    return YES;
}

//弹出视图消失后调用的方法.
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    
}

// 动态的获取某一个类的属性.
- (NSArray *)getProperties:(NSString *)str
{
    unsigned int count;
    
    // 获取一个类中的属性
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(str), &count);
    
    NSMutableArray *array = [NSMutableArray array];
    
    // 遍历类中的属性,将每一个属性值都转换成 OC 的字符串
    for (int i = 0; i < count; i++) {
        
        // pro 依然是 C 语言的数据类型
        objc_property_t pro = properties[i];
        
        // 指向C 语言字符串一个指针.
        const char *name = property_getName(pro);
        
        NSString *property = [[NSString alloc] initWithUTF8String:name];
        
        NSLog(@"property:%@",property);
        
        [array addObject:property];
    }
    
    return array;
}


//获取属性列表包括私有
- (NSArray *)getPropertiesStr:(NSString *)str
{
    //记录属性的个数
    unsigned int count = 0;
     NSMutableArray *array = [NSMutableArray array];
    //获取属性列表
    Ivar *members = class_copyIvarList([NSClassFromString(str) class], &count);
    
    //遍历属性列表
    for (NSInteger i = 0; i < count; i++) {
        
        //取到属性
        Ivar ivar = members[i];
        
        //获取属性名
        const char *memberName = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithFormat:@"%s", memberName];
        NSLog(@"属性名:%@", ivarName);
        [array addObject:ivarName];
    }
    return array;
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
