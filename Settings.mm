#include "Settings.h"

S("/var/mobile/Library/Preferences/candycrush.plist") settings;

int Settings::GetPrefInt(const char* key)
{
    return [[[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] valueForKey:[NSString stringWithUTF8String:key]] intValue];
}

float Settings::GetPrefFloat(const char* key)
{
    return [[[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] valueForKey:[NSString stringWithUTF8String:key]] floatValue];
}

bool Settings::GetPrefBool(const char* key)
{
    return [[[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] valueForKey:[NSString stringWithUTF8String:key]] boolValue];
}

void Settings::settings_proxy::set(bool value)
{
    [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] setValue:[NSNumber numberWithBool:value] forKey:[NSString stringWithUTF8String:key]];
    [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] writeToFile:[NSString stringWithUTF8String:path] atomically: YES];
}

void Settings::settings_proxy::set(int value)
{
    [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] setValue:[NSNumber numberWithInt:value] forKey:[NSString stringWithUTF8String:key]];
    [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] writeToFile: [NSString stringWithUTF8String:path] atomically: YES];
}

void Settings::settings_proxy::set(float value)
{
    [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] setValue: [NSNumber numberWithFloat:value] forKey:[NSString stringWithUTF8String:key]];
    [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/candycrush.plist"] writeToFile: [NSString stringWithUTF8String:path] atomically: YES];
}
