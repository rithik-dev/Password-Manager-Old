//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_string_encryption/FlutterStringEncryptionPlugin.h>)
#import <flutter_string_encryption/FlutterStringEncryptionPlugin.h>
#else
@import flutter_string_encryption;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterStringEncryptionPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterStringEncryptionPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
}

@end
