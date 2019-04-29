//
//  LHNavgationView.m
//  LHProjectShell
//
//  Created by liuhao on 2018/12/27.
//  Copyright © 2018 liuhao. All rights reserved.
//







typedef NS_ENUM(NSInteger,LHNavItemType)
{
    LHNavItemType_left,
    LHNavItemType_right,
    
};
#import "LHNavgationView.h"

@interface LHNavgationView ()
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UILabel  *line;
@property (nonatomic,strong) UILabel  *titleLable;
@property (nonatomic,strong) UIView   *titleView;
@property (nonatomic,strong) NSMutableArray *leftArray;
@property (nonatomic,strong) NSMutableArray *rightArray;

///左边按钮 点击
@property (nonatomic,copy)   LHNavgationLeftActionBlock  leftActionBlock;
///右边按钮 点击
@property (nonatomic,copy)   LHNavgationRightActionBlock rightActionBlock;



@end
@implementation LHNavgationView

 

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseConfig];
        [self createSubViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseConfig];
        [self createSubViews];
    }
    return self;
}

#pragma mark - baseConfig
-(void)baseConfig
{
    _backGroundColor = [UIColor whiteColor];
    _backGroundImageName = @"";
    _isHideButtomLine = NO;
    _buttomLineColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    _titleName = @"";
    _isHideButtomLine  = YES;
    _buttomLineColor  = _backGroundColor;
    _titleColor = [UIColor blackColor];
    _titleFont = [UIFont systemFontOfSize:14];
    _isHideBackButton = NO;
}


-(void)createSubViews
{
    self.frame = CGRectMake(0, 0, kScreenWidth, NAV_HEIGHT);
    self.backgroundColor = _backGroundColor;
    self.leftArray = [NSMutableArray array];
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setImage:[UIImage imageNamed:@"fanhui-3副本"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(cancalAction:) forControlEvents:UIControlEventTouchUpInside];
   
    //    self.leftButton.backgroundColor = [UIColor grayColor];
    [self addSubview:self.leftButton];
    [self.leftArray addObject:self.leftButton];
    
    _leftItems = [self.leftArray copy];
    self.rightArray = [NSMutableArray array];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
 
    //    self.rightButton.backgroundColor = [UIColor redColor];
    [self addSubview:self.rightButton];
    [self.rightArray addObject:self.rightButton];
    _rightItems = [self.rightArray copy];
    
    self.line = [[UILabel alloc]init];
    self.line.backgroundColor = _buttomLineColor;
    [self addSubview:self.line];
    self.titleView = [UIView new];
    [self addSubview:self.titleView];
    self.titleLable = [[UILabel alloc]init];
    self.titleLable.text = _titleName;
    self.titleLable.textAlignment  = NSTextAlignmentCenter;
    //    self.titleLable.backgroundColor = [UIColor yellowColor];
    [self.titleView addSubview:self.titleLable];
//    self.titleView.backgroundColor = [UIColor blueColor];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //left 的起始  righ的终点
    CGFloat spac =8;
    //statusBar的高度
    CGFloat status_h =  [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat button_w = 43;
    CGFloat subView_h = 43;
    //布局左item
    int i =0;
    for (UIView * view in self.leftArray)
    {
        ///布局
        view.frame = CGRectMake(spac+i*button_w, status_h, button_w, subView_h);
        i++;
    }
    //布局中间
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat title_w = screenWidth -spac*2-button_w*i;
    CGFloat title_x = spac+i*button_w;
    //    self.titleView .frame = CGRectMake(title_x, status_h, title_w, subView_h);
    //    self.titleLable.frame = self.titleView.bounds;
    //布局右
    int j = 0;
    //左侧按钮区域
    CGFloat left_w = button_w*i+spac;
    
    for (UIView * view in self.rightArray)
    {
        j++;
        CGFloat right_x = title_w-j*button_w+ left_w;
        //布局
        view.frame = CGRectMake(right_x, status_h, button_w, subView_h);
        
    }
    //更新title布局
    self.titleView .frame = CGRectMake(title_x, status_h, title_w-j*button_w, subView_h);
    self.titleLable.frame = self.titleView.bounds;
    //线的布局
    self.line.frame = CGRectMake(0, status_h+subView_h, screenWidth, 1);
}


#pragma mark - setter
-(void)setBackGroundColor:(UIColor *)backGroundColor
{
    _backGroundColor = backGroundColor;
    self.backgroundColor = backGroundColor;
    
}

-(void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    self.titleLable.text = titleName;
}

-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLable.textColor = titleColor;
}

-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLable.font = titleFont;
}

-(void)setIsHideButtomLine:(BOOL)isHideButtomLine
{
    _isHideButtomLine = isHideButtomLine;
    [self.line setHidden:isHideButtomLine];
}

-(void)setIsHideBackButton:(BOOL)isHideBackButton
{
    _isHideBackButton = isHideBackButton;
    self.leftButton.hidden = isHideBackButton;
    
}

#pragma mark - add other
-(void)addLeftCustomView:(UIView*)view selectBlock:(LHNavgationLeftActionBlock)leftActionBlock;
{
    self.leftActionBlock = leftActionBlock;
    if (![view isKindOfClass:[UIView class]]) return;
    [self addSubview:view];
    [self.leftArray addObject:view];
    _leftItems = [self.leftArray copy];
    [self addGesturesToView:view withItemType:LHNavItemType_left];
}

-(void)addRightCustomView:(UIView*)view selectBlock:(LHNavgationRightActionBlock)rightActionBlock;
{
    self.rightActionBlock = rightActionBlock;
    if (![view isKindOfClass:[UIView class]]) return;
    [self addSubview:view];
    [self.rightArray addObject:view];
    _rightItems = [self.rightArray copy];
    [self addGesturesToView:view withItemType:LHNavItemType_right];
    
}

-(void)addGesturesToView:(UIView*)view withItemType:(LHNavItemType)type
{
    //添加手势
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:  type==LHNavItemType_left? @selector(leftViewGestureAction:):@selector(RightViewGestureAction:)];
    view .userInteractionEnabled = YES;
    [view addGestureRecognizer:tapGesture];
    
}

-(void)leftViewGestureAction:(UITapGestureRecognizer*)tap{
    self.leftActionBlock(tap.view);
}
-(void)RightViewGestureAction:(UITapGestureRecognizer*)tap{
    self.rightActionBlock(tap.view);
}
-(void)cancalAction:(UIButton*)cancalbutton
{
    if (self.cancalActionBlock)
    {
        self.cancalActionBlock(cancalbutton);
    }
}

-(void)addTitleView:(UIView*)view;
{
    [self.titleView addSubview:view];
}


@end
