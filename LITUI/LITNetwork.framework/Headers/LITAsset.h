//
//  LITAsset.h
//  AboveGEM
//
//  Created by Tao Yunfei on 04/09/2017.
//
//

@import LITCommon;

@interface LITAsset : AGModel

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) id userInfo;

@end
