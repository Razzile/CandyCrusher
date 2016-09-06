#import <Foundation/Foundation.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSliderTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSSwitchTableCell.h>
#import <SystemConfiguration/SystemConfiguration.h>

#define kPATH @"/var/mobile/Library/Preferences/candycrush.plist"

@interface PSSegmentTableCell : PSControlTableCell {
  NSDictionary *_titleDict;
  NSArray *_values;
}

- (BOOL)canReload;
- (id)controlValue;
- (id)initWithStyle:(int)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3;
- (void)layoutSubviews;
- (id)newControl;
- (void)prepareForReuse;
- (void)refreshCellContentsWithSpecifier:(id)arg1;
- (void)setBackgroundView:(id)arg1;
- (void)setValue:(id)arg1;
- (void)setValues:(id)arg1 titleDictionary:(id)arg2;
- (id)titleLabel;

@end

@interface PinkSwitchTableCell : PSSwitchTableCell
@end

@interface PinkSegmentTableCell : PSSegmentTableCell
@end

@interface PinkSliderTableCell : PSSliderTableCell
@end

@implementation PinkSwitchTableCell

- (id)initWithStyle:(int)style
    reuseIdentifier:(NSString *)identifier
          specifier:(PSSpecifier *)spec {

  self = [super initWithStyle:style reuseIdentifier:identifier specifier:spec];
  if (self) {
    [((UISwitch *)[self control]) setOnTintColor:[UIColor magentaColor]];
  }

  return self;
}

@end

@implementation PinkSegmentTableCell

- (id)initWithStyle:(int)style
    reuseIdentifier:(NSString *)identifier
          specifier:(PSSpecifier *)spec {

  self = [super initWithStyle:style reuseIdentifier:identifier specifier:spec];
  if (self) {
    [((UISegmentedControl *)[self control])
        setTintColor:[UIColor magentaColor]];
  }

  return self;
}

@end

@implementation PinkSliderTableCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)identifier
          specifier:(PSSpecifier *)spec {

  self = [super initWithStyle:style reuseIdentifier:identifier specifier:spec];
  if (self) {
    [((UISlider *)[self control])
        setMinimumTrackTintColor:[UIColor magentaColor]];
  }

  return self;
}

@end

@interface CrusherPrefsListController : PSListController <UIAlertViewDelegate> {
}
@end

@implementation CrusherPrefsListController

- (void)twitter:(id)sender {
  if ([[UIApplication sharedApplication]
          canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
    [[UIApplication sharedApplication]
        openURL:[NSURL
                    URLWithString:[@"tweetbot:///user_profile/"
                                      stringByAppendingString:@"Razzilient"]]];

  } else if ([[UIApplication sharedApplication]
                 canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
    [[UIApplication sharedApplication]
        openURL:[NSURL
                    URLWithString:[@"twitterrific://user?screen_name="
                                      stringByAppendingString:@"Razzilient"]]];

  } else if ([[UIApplication sharedApplication]
                 canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
    [[UIApplication sharedApplication]
        openURL:[NSURL
                    URLWithString:[@"twitter://user?screen_name="
                                      stringByAppendingString:@"Razzilient"]]];
  } else {
    [[UIApplication sharedApplication]
        openURL:[NSURL
                    URLWithString:[@"https://mobile.twitter.com/"
                                      stringByAppendingString:@"Razzilient"]]];
  }
}

- (void)thread:(id)sender {
  [[UIApplication sharedApplication]
      openURL:[NSURL URLWithString:@"http://ioscheaters.com/topic/"
                                   @"2262-candy-crush-ultimate-hack-all-"
                                   @"versions/"]];
}

- (void)visit:(id)sender {
  [[UIApplication sharedApplication]
      openURL:[NSURL URLWithString:@"http://ioscheaters.com/"]];
}

- (void)donate:(id)sender {
  [[UIApplication sharedApplication]
      openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/"
                                   @"webscr?cmd=_s-xclick&hosted_button_id="
                                   @"CYLGW6YEPHLXA"]];
}

- (id)specifiers {
  if (_specifiers == nil) {
    _specifiers =
        [[self loadSpecifiersFromPlistName:@"CrusherPrefs" target:self] retain];
  }
  return _specifiers;
}

@end

// vim:ft=objc
