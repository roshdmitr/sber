//
//  PresentViewController.m
//  FinalProject
//
//  Created by Дмитрий Рощин on 26/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "IntradayViewController.h"

@interface IntradayViewController ()

@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *openLabel;
@property (nonatomic, strong) UILabel *closeLabel;
@property (nonatomic, strong) UILabel *highLabel;
@property (nonatomic, strong) UILabel *lowLabel;
@property (nonatomic, strong) UILabel *lastUpdatedLabel;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *lastUpdated;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDictionary *intradayData;
@property (nonatomic, strong) UIFont *arialHebrewBold;
@property (nonatomic, strong) NSDictionary *arialHebrewBoldDict;
@property (nonatomic, strong) UIFont *arialHebrew;
@property (nonatomic, strong) NSDictionary *arialHebrewDict;

@end

@implementation IntradayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    _mainLabel = [[UILabel alloc] init];
    [self setupMainLabel];
    
    _openLabel = [[UILabel alloc] init];
    [self setupOtherLabel:_openLabel :@"Price at open: " :_mainLabel :30 :30];
    
    _closeLabel = [[UILabel alloc] init];
    [self setupOtherLabel:_closeLabel :@"Price at close: " :_openLabel :30 :30];
    
    _highLabel = [[UILabel alloc] init];
    [self setupOtherLabel:_highLabel :@"Highest price: " :_closeLabel :30 :30];
    
    _lowLabel = [[UILabel alloc] init];
    [self setupOtherLabel:_lowLabel :@"Lowest price: " :_highLabel :30 :30];
    
    _lastUpdatedLabel = [[UILabel alloc] init];
    [self setupOtherLabel:_lastUpdatedLabel :@"Last updated: " :_lowLabel :70 :10];
    
    _arialHebrewBold = [UIFont fontWithName:@"ArialHebrew-Bold" size:20];
    _arialHebrewBoldDict = [NSDictionary dictionaryWithObject:_arialHebrewBold forKey:NSFontAttributeName];
    
    _arialHebrew = [UIFont fontWithName:@"ArialHebrew" size:20];
    _arialHebrewDict = [NSDictionary dictionaryWithObject:_arialHebrew forKey:NSFontAttributeName];
    
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
}

- (void)saveIntradayData:(NSDictionary *)intradayData :(NSString *)lastUpdated
{
    _intradayData = [NSDictionary dictionaryWithDictionary:intradayData];
    _lastUpdated = [NSString stringWithString:lastUpdated];
    [self updateOtherLabel:_openLabel :@"Price at open: " :APIDictionaryKeyOpen];
    [self updateOtherLabel:_closeLabel :@"Price at close: " :APIDictionaryKeyClose];
    [self updateOtherLabel:_highLabel :@"Highest price: " :APIDictionaryKeyHigh];
    [self updateOtherLabel:_lowLabel :@"Lowest price: " :APIDictionaryKeyLow];
    [self updateLastUpdatedLabel];
}

- (void)updateLabelData
{
    [[NetworkService sharedInstance] updateIntradayData:_symbol];
}


- (void)setSymbol:(NSString *)symbol
{
    _symbol = [NSString stringWithString:symbol];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [NetworkService sharedInstance].delegate = self;
    [self updateLabelData];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(updateLabelData) userInfo:nil repeats:YES];
}

- (void)setupMainLabel
{
    [self.view addSubview:_mainLabel];
    _mainLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_mainLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:150].active = YES;
    [_mainLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:30].active = YES;
    [_mainLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-30].active = YES;
    UIFont *arialHebrewBold = [UIFont fontWithName:@"ArialHebrew-Bold" size:40];
    NSDictionary *arialHebrewBoldDict = [NSDictionary dictionaryWithObject:arialHebrewBold forKey:NSFontAttributeName];
    NSMutableAttributedString *boldAttrString = [[NSMutableAttributedString alloc] initWithString:_symbol attributes:arialHebrewBoldDict];
    UIFont *arialHebrew = [UIFont fontWithName:@"ArialHebrew" size:30];
    NSDictionary *arialHebrewDict = [NSDictionary dictionaryWithObject:arialHebrew forKey:NSFontAttributeName];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"\nIntraday quotes:" attributes:arialHebrewDict];
    [boldAttrString appendAttributedString:attrString];
    _mainLabel.numberOfLines = 2;
    _mainLabel.attributedText = boldAttrString;
    _mainLabel.textAlignment = NSTextAlignmentCenter;
    [_mainLabel.heightAnchor constraintEqualToConstant:80].active = YES;
}

- (void)setupOtherLabel:(UILabel *)label :(NSString *)text :(UILabel *)constraintLabel :(CGFloat)constraintConstantY :(CGFloat)constraintConstantX
{
    [self.view addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label.topAnchor constraintEqualToAnchor:constraintLabel.bottomAnchor constant:constraintConstantY].active = YES;
    [label.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:constraintConstantX].active = YES;
    [label.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-constraintConstantX].active = YES;
    NSAttributedString *boldAttrString = [[NSMutableAttributedString alloc] initWithString:text attributes:_arialHebrewBoldDict];
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText = boldAttrString;
    [label.heightAnchor constraintEqualToConstant:40].active = YES;
    
}

- (void)updateOtherLabel:(UILabel *)label :(NSString *)text :(NSString *)APIDictionaryKey
{
    NSMutableAttributedString *boldAttrString = [[NSMutableAttributedString alloc] initWithString:text attributes:_arialHebrewBoldDict];
    if (_intradayData[_lastUpdated][APIDictionaryKey] != nil)
    {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_intradayData[_lastUpdated][APIDictionaryKey] attributes:_arialHebrewDict];
        [boldAttrString appendAttributedString:attrString];
    }
    label.attributedText = boldAttrString;
}

- (void)updateLastUpdatedLabel
{
    NSMutableAttributedString *boldAttrString = [[NSMutableAttributedString alloc] initWithString:@"Last updated at: " attributes:_arialHebrewBoldDict];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_lastUpdated attributes:_arialHebrewDict];
    [boldAttrString appendAttributedString:attrString];
    _lastUpdatedLabel.attributedText = boldAttrString;
}


@end
