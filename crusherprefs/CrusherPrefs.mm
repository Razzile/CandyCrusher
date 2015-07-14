#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Preferences/PSSwitchTableCell.h>
#import <Preferences/PSSegmentTableCell.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSliderTableCell.h>
#import <Preferences/PSSpecifier.h>

#define kPATH @"/var/mobile/Library/Preferences/candycrush.plist"

@interface PinkSwitchTableCell : PSSwitchTableCell
@end

@interface PinkSegmentTableCell : PSSegmentTableCell
@end

@interface PinkSliderTableCell : PSSliderTableCell
@end

@implementation PinkSwitchTableCell

-(id)initWithStyle:(int)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)spec {

    self = [super initWithStyle:style reuseIdentifier:identifier specifier:spec];
    if (self) {
        [((UISwitch *)[self control]) setOnTintColor:[UIColor magentaColor]];
    }

    return self;
}

@end

@implementation PinkSegmentTableCell

-(id)initWithStyle:(int)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)spec {

    self = [super initWithStyle:style reuseIdentifier:identifier specifier:spec];
    if (self) {
        [((UISegmentedControl *)[self control]) setTintColor:[UIColor magentaColor]];
    }

    return self;
}

@end

@implementation PinkSliderTableCell

-(id)initWithStyle:(int)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)spec {

    self = [super initWithStyle:style reuseIdentifier:identifier specifier:spec];
    if (self) {
        [((UISlider *)[self control]) setMinimumTrackTintColor:[UIColor magentaColor]];
    }

    return self;
}

@end

@interface CrusherPrefsListController: PSListController <UIAlertViewDelegate> {
}
@end

@implementation CrusherPrefsListController

- (void)thread:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ioscheaters.com/topic/2262-candy-crush-ultimate-hack-all-versions/"]];
}

- (void)visit:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ioscheaters.com/"]];
}

- (void)donate:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=CYLGW6YEPHLXA"]];
}


- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"CrusherPrefs" target:self] retain];
    }
    return _specifiers;
}

- (NSString *)version {
    return @"2.1.0";
}

- (void)viewWillAppear:(BOOL)arg {
    [self performSelectorOnMainThread:@selector(checkForUpdates) withObject:nil waitUntilDone:NO];
}

- (BOOL)isDataSourceAvailable {
    BOOL _isDataSourceAvailable = NO;
    static BOOL checkNetwork = YES;
    if (checkNetwork) { // Since checking the reachability of a host can be expensive, cache the result and perform the reachability check once.
        checkNetwork = NO;

        Boolean success;
        const char *host_name = "razzland.com"; // your data source host name

        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        _isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
    }
    return _isDataSourceAvailable;
}

- (void)checkForUpdates {
    if (![self isDataSourceAvailable]) return;
    NSString *str = @"http://razzland.com/crusher/settings.php";
    NSURL *url = [NSURL URLWithString:str];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

    if (!error) {
        if (![(NSString *)response[@"version"] isEqualToString:[self version]]) {
            UIAlertView *alert = [[UIAlertView alloc]
                initWithTitle:@"Update" message:@"An Update is available, would you like to download? " delegate:nil
                cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            alert.delegate = self;
            [alert show];
            [alert release];
        }
        if ([response[@"showMessage"] boolValue]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                    initWithTitle:@"Message" message:response[@"message"] delegate:nil
                                    cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"]) {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ioscheaters.com/topic/2262-candy-crush-ultimate-hack-all-versions/"]];
    }
}
@end

// vim:ft=objc
