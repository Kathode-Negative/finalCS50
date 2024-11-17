




Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Entity'



require 'src/Player'
require 'src/StateMachine'
require 'src/util'

require 'src/states/DefaultState'
require 'src/states/game/PlayState'

require 'src/states/splash/LoadState'

require 'src/states/game/LoseState'

require 'src/states/game/WinState'


require 'src/world/Cave'

require 'src/DmgBox'

--Splashes
require 'src/states/splash/LogoState'
require 'src/states/splash/InstructionState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityJumpState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityFallingState'
require 'src/states/entity/EntityAttackState'


-- player
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerFallingState'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerAtackState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerCrouchState'
-- enemy

require 'src/states/entity/Enemy/EnemyWalkState'

-- world

require 'src/Plattform'
require 'src/world/Generator'
require 'src/Emmitter'
require 'src/Enemy'




require 'src/states/entity/boss/BossIdleState'
require 'src/states/entity/boss/BossMoveState'

require 'src/BossAtks'


require 'src/StateStack'

require 'src/Boss'

require 'src/states/entity/boss/Room/BossPlatformIdle'
require 'src/states/entity/boss/Room/BossPlatformDash'
require 'src/states/entity/boss/Room/BallAttack'

require 'src/states/game/OptionState'
require 'src/states/game/TitleState'

require 'src/GUI/Hud'
require 'src/GUI/Panel'
require 'src/GUI/Menu'
require 'src/GUI/Selection'
require 'src/GUI/Modules/DialougeBoxes'
require 'src/GUI/Modules/Button'
require 'src/GUI/Modules/Text'
require 'src/GUI/Modules/IMG'
require 'src/GUI/Modules/Slider'



gTextures = {

    ['Dub_logo'] = love.graphics.newImage('graphics/Intro_logo.png'),

    ['player'] = love.graphics.newImage('graphics/player/player.png'),
    ['p-death'] = love.graphics.newImage('graphics/player/death.png'),

    ['health'] = love.graphics.newImage('graphics/GUI/health clock.png'),
    ['arm'] = love.graphics.newImage('graphics/GUI/clock-arm.png'),
    ['carrot'] = love.graphics.newImage('graphics/loads/loadingcarrot.png'),
    ['button'] = love.graphics.newImage('graphics/GUI/button-continue.png'),
    ['vol'] = love.graphics.newImage('graphics/GUI/volume.png'),
    
    ['title_screen'] = love.graphics.newImage('graphics/title/title-background.png'),
    ['title_title'] = love.graphics.newImage('graphics/title/title.png'),
    ['instructions'] = love.graphics.newImage('graphics/GUI/instructions.png'),

    ['attack-p'] = love.graphics.newImage('graphics/player/attack.png'),
    ['attack-b-bone'] = love.graphics.newImage('graphics/Enemies/Boss/little-bones.png'),
    ['bigBone'] = love.graphics.newImage('graphics/Enemies/Boss/big-bone-full.png'),

    ['enemy'] = love.graphics.newImage('graphics/Enemies/enemy.png'),
    ['boss'] = love.graphics.newImage('graphics/Enemies/Boss/boss.png'),

    ['start-platform'] = love.graphics.newImage('graphics/world/start-plat.png'),
    ['platforms'] = love.graphics.newImage('graphics/world/platforms.png'),

    ['YouWin'] = love.graphics.newImage('graphics/YouWin-bg.png'),
    
    

    ['boss-platform'] = love.graphics.newImage('graphics/world/bossfloor.png'),

    ['heal-particles'] = love.graphics.newImage('graphics/player/heal.png')
    
}



gFrames = {
    ['player'] = cropFrames(gTextures['player'],32,32),
    ['attack-p'] = cropFrames(gTextures['attack-p'],32,32),
    ['p-death'] = cropFrames(gTextures['p-death'],32,32),
    ['platforms'] = cropFrames(gTextures['platforms'],96,16),
    ['enemy'] = cropFrames(gTextures['enemy'],20,20),
    ['boss'] = cropFrames(gTextures['boss'],64,64),
    ['health'] = cropFrames(gTextures['health'],80,88),
    ['arm'] = cropFrames(gTextures['arm'],48,16),
    ['carrot'] = cropFrames(gTextures['carrot'],89,56),
    ['button'] = cropFrames(gTextures['button'],72,24),
    ['start-platform'] = cropFrames(gTextures['start-platform'],600,40),
    ['vol'] = cropFrames(gTextures['vol'],20,20),

    ['instructions'] = cropFrames(gTextures['instructions'],600,320),

    ['attack-b-bone'] = cropFrames(gTextures['attack-b-bone'],20,20),
    ['bigBone'] = cropFrames(gTextures['bigBone'],84,645),
    ['YouWin'] = cropFrames(gTextures['YouWin'],600,320),

    ['boss-platform'] = cropFrames(gTextures['boss-platform'],300,59)
}

gSounds = {
    ['bossdeath'] = love.audio.newSource('sounds/Enemy/enemydeath.wav','static'),
    ['bosslaugh'] = love.audio.newSource('sounds/Boss/laugh-boss.wav','static'), 
    ['bossbones'] = love.audio.newSource('sounds/Boss/boss attack bones.wav','static'),

    ['enemydeath']  = love.audio.newSource('sounds/Enemy/enemydeath.wav','static'),

    ['heal'] = love.audio.newSource('sounds/Player/heal.wav','static'),
    ['hurtP'] = love.audio.newSource('sounds/Player/hurtPlayer.wav','static'),
    ['deathP'] = love.audio.newSource('sounds/Player/playerdeath.wav','static'),
    ['playerjump'] = love.audio.newSource('sounds/Player/playerjump.wav','static'),
    ['atkP'] = love.audio.newSource('sounds/Player/playeratk.wav','static'),

    ['select'] = love.audio.newSource('sounds/GUI/button-select.wav','static'),
    ['switch'] = love.audio.newSource('sounds/GUI/button-switch.wav', 'static'),

    ['pause'] = love.audio.newSource('sounds/GUI/pause.wav','static'),
    ['resume'] = love.audio.newSource('sounds/GUI/resume.wav','static')
}
gMusic = {
    ['test-music'] = love.audio.newSource('music/bg Musik.wav','stream'),
    ['title'] = love.audio.newSource('music/Menu.wav','stream'),
    ['intro'] = love.audio.newSource('music/intro.wav','stream'),
    ['outro'] = love.audio.newSource('music/outro.wav','stream'),
    ['boss'] = love.audio.newSource('music/boss.wav','stream')
}

gFonts = {
    ['default'] = love.graphics.newFont('fonts/PressStart2P-vaV7.ttf',12)
}

require 'src/entity_def'

