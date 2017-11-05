#import "SpriteGameScene.h"
#import "gameOverScene.h"

@implementation SpriteGameScene

int Yspeed = 75;
int Xspeed = 0;
static const int taxiCategory = 1;
static const int borderCategory = 2;
static const int carCategory = 3;

int Xpos1;
int Xpos2;
int frames;
float normalDelay = 2.5;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.physicsWorld.contactDelegate = self;
        
    }
    return self;
}




-(void) didMoveToView:(SKView *)view{
    
    if (!self.contentCreated) {
        
        [self createSceneContents];
        self.contentCreated = YES;
    }
}


-(void) createSceneContents {
    
    [self createSides];
    
    [self createRoads];
    
    [self createRightBorder1];
    
    [self createRightBorder2];
    
    [self createLeftBorder1];
    
    [self createLeftBorder2];
    
    [self createTaxi];
    
    [self createScoreLabel];
    
    [self setUpExplosion];
  
    
    [self performSelector:@selector(chooseCombination) withObject:nil afterDelay:2.5];
    
    
    
}

-(void) setUpExplosion {
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"blow"];
    
    SKTexture* blow1 = [atlas textureNamed:@"blow1.png"];
    SKTexture* blow2 = [atlas textureNamed:@"blow2.png"];
    SKTexture* blow3 = [atlas textureNamed:@"blow3.png"];
    SKTexture* blow4 = [atlas textureNamed:@"blow4.png"];
    SKTexture* blow5 = [atlas textureNamed:@"blow5.png"];
    SKTexture* blow6 = [atlas textureNamed:@"blow6.png"];
    SKTexture* blow7 = [atlas textureNamed:@"blow7.png"];
    
    NSArray *textureAtlas = @[blow1,blow2,blow3,blow4,blow5,blow6,blow7];
    
    [SKTexture preloadTextures:textureAtlas withCompletionHandler:^{}];
    
    explosionAnimation = [SKAction animateWithTextures:textureAtlas timePerFrame:0.05 resize:YES restore:NO];
    
    explosionSound = [SKAction playSoundFileNamed:@"boom.wav" waitForCompletion:YES];
    
    turnSound = [SKAction playSoundFileNamed:@"tires.wav" waitForCompletion:NO];
    
    SKAction *changeScene = [SKAction performSelector:@selector(changeScene) onTarget:self];
    
    blowUp = [SKAction sequence:@[explosionAnimation, changeScene]];
    
    
    
}

-(void) createScoreLabel {
    
    scoreNum = 0;
    
    Scorelabel = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
    Scorelabel.name = @"scoreLabel";
    Scorelabel.text = [NSString stringWithFormat:@"%i",scoreNum];
    Scorelabel.fontSize = 20;
    Scorelabel.zPosition = 200;
    Scorelabel.position = CGPointMake(CGRectGetWidth(self.frame) *0.92, CGRectGetHeight(self.frame)* 0.93);
    
    [self addChild:Scorelabel];
}





static inline CGFloat skRandf(){
    
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    
    return skRandf() * (high - low) + low;
}






-(void) createCars1 {
    
    int combination = skRand(1, 5);
    
    if (combination == 1) {
        
        [self createCar1:Xpos1];
        
    }else if (combination == 2){
        
        [self createCar2:Xpos1];
        
    }else if (combination == 3){
        
        [self createCar3:Xpos1];
    }
    
    else{
        
        [self createCar4:Xpos1];
        
    }
    
    
    
    
    
    [self performSelector:@selector(chooseCombination) withObject:nil afterDelay:(skRand(1, 4)*0.1)+ normalDelay];
    
}



-(void) createCars2 {
    
    int combination = skRand(1, 5);
    
    if (combination == 1) {
        
        [self createCar1:Xpos2];
        
    }else if (combination == 2){
        
        [self createCar2:Xpos2];
        
    }else if (combination == 3){
        
        [self createCar3:Xpos2];
    }
    
    else{
        
        [self createCar4:Xpos2];
        
    }
    
    
    
    
}

-(void)chooseCombination{
    
    int comb = skRand(1, 7);
    
    if (comb == 1) {
        
        [self combination1];
        
    }else if (comb ==2){
        
        [self combination2];
        
    }else if (comb == 3){
        
        [self combination3];
        
    }else if (comb == 4){
        
        [self combination4];
        
    }else if (comb ==5){
        
        [self combination5];
        
    }else if (comb == 6) {
        
        [self combination6];
    }
}


-(void) combination1 {
    
    Xpos1 = 70 + 25;
    
    Xpos2 = 70 * 2 + 25;
    
    
        
    [self createCars1];
        
    [self createCars2];
        
       
    
    
    
    
    
    
}

-(void) combination2 {
    
    Xpos1 = 70 + 25;
    
    Xpos2 = 70 * 3 + 25;
    
    
        
    [self createCars1];
        
    [self createCars2];
        
    
    
}


-(void) combination3 {
    
    Xpos1 = 70 * 3 + 25;
    
    Xpos2 = 70 * 2 + 25;
    
    
        
    [self createCars1];
        
    [self createCars2];
        
    
}

-(void) combination4 {
    
    Xpos1 = 70 +25;
    
    [self createCars1];
}

-(void) combination5 {
    
    Xpos1 = 70 *2 +25;
    
    [self createCars1];
}

-(void) combination6 {
    
    Xpos1 = 70 *3 +25;
    
    [self createCars1];
}





-(void)createCar1 : (int) Xposition {
    
    
    SKSpriteNode *car1 = [SKSpriteNode spriteNodeWithImageNamed:@"car1"];
    car1.position = CGPointMake(Xposition, CGRectGetHeight(self.frame)+30);
    car1.zPosition = 100;
    car1.name = @"car2";
    car1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:car1.size];
    car1.physicsBody.dynamic = YES;
    car1.physicsBody.affectedByGravity = NO;
    car1.physicsBody.usesPreciseCollisionDetection = YES;
    car1.physicsBody.categoryBitMask = carCategory;
    car1.physicsBody.contactTestBitMask = taxiCategory;
    car1.physicsBody.collisionBitMask = taxiCategory;
    car1.physicsBody.contactTestBitMask = borderCategory;
    car1.physicsBody.collisionBitMask = borderCategory;
    [self addChild:car1];
    
    
}

-(void)createCar2 : (int) Xposition{
    
   
    
    SKSpriteNode *car1 = [SKSpriteNode spriteNodeWithImageNamed:@"car2"];
    car1.position = CGPointMake(Xposition , CGRectGetHeight(self.frame)+30);
    car1.zPosition = 100;
    car1.name = @"car2";
    car1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:car1.size];
    car1.physicsBody.dynamic = YES;
    car1.physicsBody.affectedByGravity = NO;
    car1.physicsBody.usesPreciseCollisionDetection = YES;
    car1.physicsBody.categoryBitMask = carCategory;
    car1.physicsBody.contactTestBitMask = taxiCategory;
    car1.physicsBody.collisionBitMask = taxiCategory;
    car1.physicsBody.contactTestBitMask = borderCategory;
    car1.physicsBody.collisionBitMask = borderCategory;
    [self addChild:car1];
    
    
    
}

-(void)createCar3: (int) Xpostion{
    
  
    
    SKSpriteNode *car1 = [SKSpriteNode spriteNodeWithImageNamed:@"car3"];
    car1.position = CGPointMake(Xpostion, CGRectGetHeight(self.frame)+30);
    car1.zPosition = 100;
    car1.name = @"car3";
    car1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:car1.size];
    car1.physicsBody.dynamic = YES;
    car1.physicsBody.affectedByGravity = NO;
    car1.physicsBody.usesPreciseCollisionDetection = YES;
    car1.physicsBody.categoryBitMask = carCategory;
    car1.physicsBody.contactTestBitMask = taxiCategory;
    car1.physicsBody.collisionBitMask = taxiCategory;
    car1.physicsBody.contactTestBitMask = borderCategory;
    car1.physicsBody.collisionBitMask = borderCategory;
    [self addChild:car1];
    
   
    
}

-(void)createCar4 : (int) Xposition{
    
    
    
    SKSpriteNode *car1 = [SKSpriteNode spriteNodeWithImageNamed:@"car4"];
    car1.position = CGPointMake(Xposition, CGRectGetHeight(self.frame)+30);
    car1.zPosition = 100;
    car1.name = @"car4";
    car1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:car1.size];
    car1.physicsBody.dynamic = YES;
    car1.physicsBody.affectedByGravity = NO;
    car1.physicsBody.usesPreciseCollisionDetection = YES;
    car1.physicsBody.categoryBitMask = carCategory;
    car1.physicsBody.contactTestBitMask = taxiCategory;
    car1.physicsBody.collisionBitMask = taxiCategory;
    car1.physicsBody.contactTestBitMask = borderCategory;
    car1.physicsBody.collisionBitMask = borderCategory;
    [self addChild:car1];
    
    
    
}







-(void)createSides{
    
    SKSpriteNode *sides1 = [SKSpriteNode spriteNodeWithImageNamed:@"second_background1"];
    sides1.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    [self addChild:sides1];
    
    SKSpriteNode *sides2 = [SKSpriteNode spriteNodeWithImageNamed:@"second_background2"];
    sides2.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2+ CGRectGetHeight(self.frame));
    [self addChild:sides2];
    
}







-(void)createRightBorder1{
    
    SKSpriteNode* rightBorder1 = [SKSpriteNode spriteNodeWithImageNamed:@"right_border"];
    rightBorder1.name = @"rightborder1";
    rightBorder1.position = CGPointMake(270, 284);
    rightBorder1.zPosition = 100;
    rightBorder1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightBorder1.size];
    rightBorder1.physicsBody.dynamic = NO;
    rightBorder1.physicsBody.affectedByGravity = NO;
    rightBorder1.physicsBody.usesPreciseCollisionDetection = YES;
    rightBorder1.physicsBody.categoryBitMask = borderCategory;
    rightBorder1.physicsBody.contactTestBitMask = taxiCategory;
    rightBorder1.physicsBody.collisionBitMask = taxiCategory;
    rightBorder1.physicsBody.contactTestBitMask = carCategory;
    rightBorder1.physicsBody.collisionBitMask = carCategory;
    [self addChild:rightBorder1];

    
}

-(void)createRightBorder2 {
    
    SKSpriteNode* rightBorder2 = [SKSpriteNode spriteNodeWithImageNamed:@"right_border2"];
    rightBorder2.name = @"rightborder2";
    rightBorder2.position = CGPointMake(270, 852);
    rightBorder2.zPosition = 100;
    rightBorder2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightBorder2.size];
    rightBorder2.physicsBody.dynamic = NO;
    rightBorder2.physicsBody.affectedByGravity = NO;
    rightBorder2.physicsBody.usesPreciseCollisionDetection = YES;
    rightBorder2.physicsBody.categoryBitMask = borderCategory;
    rightBorder2.physicsBody.contactTestBitMask = taxiCategory;
    rightBorder2.physicsBody.collisionBitMask = taxiCategory;
    rightBorder2.physicsBody.contactTestBitMask = carCategory;
    rightBorder2.physicsBody.collisionBitMask = carCategory;

    [self addChild:rightBorder2];

    
    
    
}

-(void)createLeftBorder1 {
    
    SKSpriteNode* leftBorder1 = [SKSpriteNode spriteNodeWithImageNamed:@"left_border1"];
    leftBorder1.name = @"leftborder1";
    leftBorder1.position = CGPointMake(50, 284);
    leftBorder1.zPosition = 100;
    leftBorder1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftBorder1.size];
    leftBorder1.physicsBody.dynamic = NO;
    leftBorder1.physicsBody.affectedByGravity = NO;
    leftBorder1.physicsBody.usesPreciseCollisionDetection = YES;
    leftBorder1.physicsBody.categoryBitMask = borderCategory;
    leftBorder1.physicsBody.contactTestBitMask = taxiCategory;
    leftBorder1.physicsBody.collisionBitMask = taxiCategory;
    leftBorder1.physicsBody.contactTestBitMask = carCategory;
    leftBorder1.physicsBody.collisionBitMask = carCategory;
    [self addChild:leftBorder1];
    
    
}

-(void) createLeftBorder2{
    
    SKSpriteNode* leftBorder2 = [SKSpriteNode spriteNodeWithImageNamed:@"left_border2"];
    leftBorder2.name = @"leftborder2";
    leftBorder2.position = CGPointMake(50, 852);
    leftBorder2.zPosition = 100;
    leftBorder2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftBorder2.size];
    leftBorder2.physicsBody.dynamic = NO;
    leftBorder2.physicsBody.affectedByGravity = NO;
    leftBorder2.physicsBody.usesPreciseCollisionDetection = YES;
    leftBorder2.physicsBody.categoryBitMask = borderCategory;
    leftBorder2.physicsBody.contactTestBitMask = taxiCategory;
    leftBorder2.physicsBody.collisionBitMask = taxiCategory;
    leftBorder2.physicsBody.contactTestBitMask = carCategory;
    leftBorder2.physicsBody.collisionBitMask = carCategory;
    [self addChild:leftBorder2];
    
    
}








-(void)createRoads {
    
    SKSpriteNode *road1 = [SKSpriteNode spriteNodeWithImageNamed:@"first_background1"];
    road1.position = CGPointMake(CGRectGetWidth(self.frame)/2, 284);
    road1.name = @"road1";
    road1.physicsBody.dynamic = NO;
    [self addChild:road1];
    
    SKSpriteNode *road2 = [SKSpriteNode spriteNodeWithImageNamed:@"first_background2"];
    road2.name = @"road2";
    road2.position = CGPointMake(CGRectGetWidth(self.frame)/2 , 852);
    road2.physicsBody.dynamic = NO;
    [self addChild:road2];

    
}







-(void)createTaxi{
    
    SKSpriteNode *taxi = [SKSpriteNode spriteNodeWithImageNamed:@"taxi"];
    taxi.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)*0.2);
    taxi.zPosition = 100;
    taxi.name = @"taxi";
    taxi.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(CGRectGetWidth(taxi.frame)*0.9, CGRectGetHeight(taxi.frame)*0.9)];
    taxi.physicsBody.dynamic = YES;
    taxi.physicsBody.affectedByGravity = NO;
    taxi.physicsBody.usesPreciseCollisionDetection = YES;
    taxi.physicsBody.mass = 0.8;
    taxi.physicsBody.allowsRotation = NO;
    SKAction *engineSound = [SKAction playSoundFileNamed:@"engine.wav" waitForCompletion:YES];
    [self runAction:engineSound];
    [self addChild:taxi];
    
    
}








-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
   CGPoint location = [[touches anyObject] locationInNode:self];
    
    if (location.x < 160) {
        
      // SKSpriteNode* taxinode = (SKSpriteNode*)[self childNodeWithName:@"taxi"];
        
        [self turnRight];
        [self runAction:turnSound];
        
        
    }else{
       // SKSpriteNode* taxinode = (SKSpriteNode*)[self childNodeWithName:@"taxi"];
       
        [self turnLeft];
        [self runAction:turnSound];
        
        
    }
    
    
    
};





-(void)turnRight {
    
    if (TurningLeft == YES) {
        TurningLeft = NO;
        TurningRight = YES;
    } else {
        TurningRight = YES;
    }
    
    
}

-(void)turnLeft {
    
    if (TurningRight == YES) {
        TurningRight = NO;
        TurningLeft = YES;
    }else{
        TurningLeft = YES;
    }
    
    
}

-(void)updateScore {
    
    scoreNum = scoreNum + 1;
    
    Scorelabel.text = [NSString stringWithFormat:@"%i",scoreNum];
}

-(void)didBeginContact:(SKPhysicsContact *)contact

{
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    if(firstBody.categoryBitMask == taxiCategory || secondBody.categoryBitMask == carCategory)
    {
        
        [self gameOver];
        
        
    }
    if(firstBody.categoryBitMask == borderCategory || secondBody.categoryBitMask == taxiCategory)
    {
        
        [self gameOver];
        
        
    }

}
    



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    
    SKSpriteNode *taxi;
    
    SKNode *someNode = [self childNodeWithName:@"taxi"];
    
    if (someNode != nil){
        if ([someNode isKindOfClass:[SKSpriteNode class]]) {
            
            taxi = (SKSpriteNode*)someNode;
        }
    }
    
    frames = frames + 1;
    
    
    
    if (frames % 20 == 0) {
        
        [self updateScore];
        
        
        
    };
    
    if (frames % 25 == 0) {
        if (normalDelay >= 1.5) {
            
        normalDelay = normalDelay - 0.1;
        }
    }


    
    [self enumerateChildNodesWithName:@"taxi" usingBlock:^(SKNode *node, BOOL *stop) {
        
        if (TurningLeft == YES) {
            [node.physicsBody applyForce:CGVectorMake(-300, 0)];
            
        }
        else if (TurningRight == YES)
        
        {
            [node.physicsBody applyForce:CGVectorMake(300, 0)];
        }
    }];
    
    
    
   
    
    [self enumerateChildNodesWithName:@"road1" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 10);
        if (node.position.y < -284) {
            node.position = CGPointMake(node.position.x, 849);
        }
        
        
            }];
    
    [self enumerateChildNodesWithName:@"road2" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 10);
        if (node.position.y < -284) {
            node.position = CGPointMake(node.position.x, 849);
        }
    }];
    
    
    
    
    [self enumerateChildNodesWithName:@"rightborder1" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 10);
        if (node.position.y < -284) {
            node.position = CGPointMake(node.position.x, 849);
        }
        
        

    }];
    
    [self enumerateChildNodesWithName:@"rightborder2" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 10);
        if (node.position.y < -284) {
            node.position = CGPointMake(node.position.x, 849);
        }
        
        
    }];
    
    [self enumerateChildNodesWithName:@"leftborder1" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 10);
        if (node.position.y < -284) {
            node.position = CGPointMake(node.position.x, 849);
        }
        
       
    }];
    
    [self enumerateChildNodesWithName:@"leftborder2" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 10);
        if (node.position.y < -284) {
            node.position = CGPointMake(node.position.x, 849);
        }
        
       
    }];
    
    
    [self enumerateChildNodesWithName:@"car1" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 5);
        if (node.position.y < -50) {
            [self removeFromParent];
        }
        
       
    }];
    
    [self enumerateChildNodesWithName:@"car2" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 5);
        if (node.position.y < -50) {
            [self removeFromParent];
        }
        

       
    }];
    
    [self enumerateChildNodesWithName:@"car3" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 5);
        if (node.position.y < -50) {
            [self removeFromParent];
        }
        
      
    }];
    
    [self enumerateChildNodesWithName:@"car4" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 5);
        if (node.position.y < -50) {
            
            [self removeFromParent];
        }
        
    }];
    
}



-(void)saveUserProfile {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    newHighscore = [userDefaults integerForKey:@"newHighScore"];
    
    currentScore = [userDefaults integerForKey:@"currentScore"];
    
    [userDefaults setInteger:scoreNum forKey:@"currentScore"];
    
    if (scoreNum > newHighscore) {
        
        [userDefaults setInteger:scoreNum forKey:@"newHighScore"];
        
    }
    
    [userDefaults synchronize];
}

-(void) changeScene {
    
    SKScene *nextscene = [[gameOverScene alloc]initWithSize:self.size];
    
    SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
    
    [self.view presentScene:nextscene transition:doors];
    
    
}


-(void) gameOver {
    
     [self saveUserProfile];
    
    
    SKSpriteNode* taxiNode = (SKSpriteNode*)[self childNodeWithName:@"taxi"];
    
    [self runAction:explosionSound];
    
    [taxiNode runAction:blowUp];
    
    
    [self saveUserProfile];
    
}



@end
