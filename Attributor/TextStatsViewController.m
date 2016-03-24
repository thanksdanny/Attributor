//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Danny Ho on 3/13/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharactersLabel;

@end

@implementation TextStatsViewController

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    while (index < [self.textAnalyze length]) {
        NSRange range;
        id value = [self.textAnalyze attribute:attributeName atIndex:index effectiveRange:&range]; // range为结构体，所以要传进他的地址
        if (value) {
            [characters appendAttributedString:[self.textAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index ++;
        }
    }
    return characters;
}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}


- (void)updateUI {
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%ld colorful characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlineCharactersLabel.text = [NSString stringWithFormat:@"%ld outlined characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
    
}
@end
