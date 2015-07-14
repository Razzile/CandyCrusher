#import <Preferences/PSListController.h>

@interface CrusherCreditsListController: PSListController {
}
@end

@implementation CrusherCreditsListController

- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"CrusherCredits" target:self] retain];
    }
    return _specifiers;
}

- (void)visit:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://razzland.com/"]];
}

- (void)source:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Razzile/CandyCrusher/"]];
}

@end
