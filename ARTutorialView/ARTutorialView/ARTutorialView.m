//
//  ARTutorialView.m
//  ARKitIntro
//
//  Created by Roderic Campbell on 9/8/17.
//  Copyright © 2017 Roderic Campbell. All rights reserved.
//

#import "ARTutorialView.h"

@implementation ARTutorialView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self buildTutorialSceneView];
    }
    return self;
}

- (void)buildTutorialSceneView {
    
    SCNScene *scene = [[SCNScene alloc] init];
    self.scene = scene;
    
    // create the table
    SCNNode *tableNode = [SCNScene sceneNamed:@"art.scnassets/table.dae"].rootNode;
    tableNode.position = SCNVector3Make(0, 0, -12);
    
    tableNode.rotation = SCNVector4Make(1, 0, 0, M_PI/20);
    tableNode.scale = SCNVector3Make(0.06, 0.06, 0.06);
    [scene.rootNode addChildNode:tableNode];
    
    // create the iOS device node
    SCNNode *iOSDeviceNode = [self iOSDevice];

    // create a node for rotating
    SCNNode *rotatingNode = [SCNNode node];
    [rotatingNode addChildNode:iOSDeviceNode];
    rotatingNode.position = tableNode.position;
    [scene.rootNode addChildNode:rotatingNode];
    
    // set up the camera
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *pov = [SCNNode node];
    pov.camera = camera;
    [scene.rootNode addChildNode:pov];
    SCNLookAtConstraint *lookat = [SCNLookAtConstraint lookAtConstraintWithTarget:tableNode];
    pov.constraints = @[lookat];
    
    self.pointOfView = pov;
    
    // do the animations
    CGFloat rotationValue = M_PI / 7;
    SCNAction *deviceAction = [self calibrationActionChainWithRotation:rotationValue duration:0.5];
    [iOSDeviceNode runAction:deviceAction];
    
    SCNAction *tableAction = [self calibrationActionChainWithRotation:-rotationValue duration:0.5];
    [tableNode runAction:tableAction];
}

#pragma mark - A few helpers

- (SCNNode *)iOSDevice {
    // create the iOS device
    SCNNode *iOSDeviceNode = [SCNScene sceneNamed:@"art.scnassets/iPhone6.dae"].rootNode;
    iOSDeviceNode.scale = SCNVector3Make(0.05, 0.05, 0.05);
    iOSDeviceNode.rotation = SCNVector4Make(1, 0, 0, M_PI/2);
    iOSDeviceNode.position = SCNVector3Make(0, 0, 3);
    return iOSDeviceNode;
}

- (SCNAction *)calibrationActionChainWithRotation:(CGFloat)rotationValue duration:(CGFloat)duration {
    SCNAction *rotateX = [SCNAction rotateByX:rotationValue y:0 z:0 duration:duration];
    SCNAction *rotateY = [SCNAction rotateByX:0 y:rotationValue z:0 duration:duration];
    SCNAction *rotateZ = [SCNAction rotateByX:0 y:0 z:rotationValue duration:duration];
    
    SCNAction *rotateNegativeX = [SCNAction rotateByX:rotationValue y:0 z:0 duration:-duration];
    SCNAction *rotateNegativeY = [SCNAction rotateByX:0 y:rotationValue z:0 duration:-duration];
    SCNAction *rotateNegativeZ = [SCNAction rotateByX:0 y:0 z:rotationValue duration:-duration];
    
    SCNAction *moveLeft = [SCNAction moveBy:SCNVector3Make(-1, 0, 0) duration:duration];
    SCNAction *moveRight = [SCNAction moveBy:SCNVector3Make(1, 0, 0) duration:duration];
    
    SCNAction *sequence = [SCNAction sequence:@[rotateNegativeX, moveLeft, rotateY, rotateZ, rotateNegativeY, moveRight, rotateNegativeZ, moveRight, rotateX, rotateNegativeZ, rotateNegativeX, moveLeft, rotateNegativeY, rotateZ, rotateY, rotateX]];
    
    return [SCNAction repeatActionForever:sequence];
}
@end
