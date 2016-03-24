//
//  ViewController.m
//  Attributor
//
//  Created by Danny Ho on 3/13/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "ViewController.h"
#import "TextStatsViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineBtn;

@end

@implementation ViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Analyze Text"]) {
        if ([segue.destinationViewController isKindOfClass:[TextStatsViewController class]]) {
            TextStatsViewController *tsvc = (TextStatsViewController *)segue.destinationViewController;
            tsvc.textAnalyze = self.body.textStorage;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineBtn.currentTitle];
//    [title setAttributes:@{NSStrokeWidthAttributeName : @3,
//                           NSStrokeColorAttributeName : self.outlineBtn.tintColor}
//                   range:NSMakeRange(0, [title length])];
//    
//    [self.outlineBtn setAttributedTitle:title forState:UIControlStateNormal];
    NSLog(@"view did load");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self usePreferredFonts]; // 当失去通知时，状态改变了就不会知道，所以需要这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    NSLog(@"view will appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
    NSLog(@"view will disappear");
}

- (void)preferredFontsChanged:(NSNotificationCenter *)notification {
    [self usePreferredFonts];
}

- (void)usePreferredFonts {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection {
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName : @-3,
                                           NSStrokeColorAttributeName : [UIColor blackColor]} range:self.body.selectedRange];
}
- (IBAction)unOutlineBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
