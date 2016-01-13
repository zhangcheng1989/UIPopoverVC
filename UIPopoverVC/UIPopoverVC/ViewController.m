//
//  ViewController.m
//  UIPopoverPresentationControllerDemo
//
//  Created by iOS on 16/1/13.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "ViewController.h"
#import "PopoverViewController.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate>
@property(nonatomic,weak)UIButton *button;
@property(nonatomic,strong)PopoverViewController *popVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 100, 100, 40);
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickPopView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.button = btn;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickSelectRow:) name:@"didClickSelectRow" object:nil];
}


- (void)didClickSelectRow:(NSNotification *)note{
    
    NSDictionary *dict = [note userInfo];
    
    NSIndexPath *indexPath = dict[@"indexPath"];
    
    NSMutableArray *items = dict[@"items"];
    
    NSLog(@"%@",[items objectAtIndex:indexPath.row]);
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickPopView:(UIButton *)btn{

    self.popVC = [[PopoverViewController alloc] init];
    self.popVC.items = [[NSMutableArray alloc]initWithObjects:@"张三",@"李四",@"王五",@"赵六" ,nil];
    self.popVC.modalPresentationStyle = UIModalPresentationPopover;
    self.popVC.popoverPresentationController.sourceView = _button;  //rect参数是以view的左上角为坐标原点（0，0）
    self.popVC.popoverPresentationController.sourceRect = _button.bounds; //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    self.popVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp; //箭头方向
    self.popVC.popoverPresentationController.delegate = self;
    [self presentViewController:self.popVC animated:YES completion:nil];

}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return NO;//点击蒙版是否影藏，默认是yes
}

@end
