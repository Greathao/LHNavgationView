//
//  LHNavgationView.h
//  LHProjectShell
//
//  Created by liuhao on 2018/12/27.
//  Copyright © 2018 liuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void(^LHNavgationLeftActionBlock) (UIView*view);
typedef  void(^LHNavgationRightActionBlock)(UIView*view);

@interface LHNavgationView : UIView

///设置背景图片
@property (nonatomic,copy)   NSString * backGroundImageName;
///设置背景颜色默认白色
@property (nonatomic,strong) UIColor *backGroundColor;
///设置是否显示1像素的线
@property (nonatomic,assign) BOOL isHideButtomLine;
///设置导航栏下面的线颜色
@property (nonatomic,strong) UIColor  * buttomLineColor;
///设置title
@property (nonatomic,copy)   NSString * titleName;
///标题颜色
@property (nonatomic,strong) UIColor  * titleColor;
///标题大小
@property (nonatomic,strong) UIFont   * titleFont;
///隐藏显示左侧按钮 默认不显示
@property (nonatomic,assign) BOOL isHideBackButton;
///左边按钮 对象组
@property (nonatomic,strong,readonly) NSArray <UIView*>*leftItems;
///右边按钮 对象组
@property (nonatomic,strong,readonly) NSArray <UIView*>*rightItems;
///左边第一个按钮点击事件
@property (nonatomic,copy) LHNavgationLeftActionBlock  cancalActionBlock; 

/**
 titleView追加
 
 @param view view
 */
-(void)addTitleView:(UIView*)view;


/**
 追加一个左侧按钮
 
 @param view [view class]
 @param leftActionBlock 追加按钮的点击事件 及对象
 */
-(void)addLeftCustomView:(UIView*)view selectBlock:(LHNavgationLeftActionBlock)leftActionBlock;


/**
 追加一个右侧按钮
 
 @param view [view class]
 @param rightActionBlock 追加按钮的点击事件 及对象
 */
-(void)addRightCustomView:(UIView*)view selectBlock:(LHNavgationRightActionBlock)rightActionBlock;


@end

NS_ASSUME_NONNULL_END
