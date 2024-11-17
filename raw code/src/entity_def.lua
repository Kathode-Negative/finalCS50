

-- stores all modular data for all entities in the game
-- all objects are entities 
-- there are two types of entities: active and static 
--
-- active entitites activate an on collide function, when colliding with another entity 
-- 
-- static entities can not react to collision, as this is unnecesary 
--
-- 



ENTITY_DEF = {
    ['null'] = {
        health = 0,
        invincible = true,
        animations = { ['idle'] = {
            frames = {4},
            graphic = 'platforms'
          }}
    }, -- just for collisions(dummy)
-- active
    ['player'] = {
        active = true,
        health = 3,
        atk = 1,
        id = 'player',
        graphic = 'player',
        vel = 200,
        animations = {
            ['idle'] = {
                frames = {8},
                graphic = 'player'
            },
            ['walk']= {
                frames = {6,7},
                frate = 0.15,
                loop = true,
                graphic = 'player'
            },
            ['jump'] = {
                frames = {4},
                graphic = 'player'
            },
            ['jump-side'] = {
                frames = {12},
                graphic = 'player'
            },
            ['fall'] = {
                frames = {5},
                graphic = 'player'
            },
            ['fall-side'] = {
                frames = {11},
                graphic = 'player'
            },
            ['crouch'] = {
                frames = {10},
                graphic = 'player'
            },
            ['attack-side'] = {
                frames = {2},
                graphic = 'player'
            },
            ['attack-up'] = {
                frames = {1},
                graphic = 'player'
            },
            ['attack-down'] = {
                frames = {3},
                graphic = 'player'
            },
            ['death'] = {
                frames = {1,1,2,3,4,5},
                frate = 0.1,
                loop = false,
                graphic = 'p-death'
            }
        
        },
        sounds = {
            ['death'] = gSounds['deathP'],
            ['jump'] = gSounds['playerjump'],
            ['hurt'] = gSounds['hurtP'],
            ['heal'] = gSounds['heal'],
            ['atk'] = gSounds['atkP']
        },

        collides = {

            [1] = 'start-platform',
            [2] = 'plattform',
            [3] = 'enemy',
            [4] = 'ray',
            [5] = 'boss-platform',
            [6] = 'bigBone',
            [7] = 'null',
            [8] = 'small-bone'
        
        },
        passes = {'enemy','bigBone'},
        onCollide = {
            ['start-platform'] = function(player,ent) player.collideddown = true  end,
            ['plattform'] = function(player,ent) player.collideddown = true  end,
            ['enemy'] = function(player,ent) player:dmg(ent.atk) player:goInv(1.5) end,
            ['boss-platform'] = function(player,ent) player.collideddown = true end,
            ['bigBone'] = function(player,ent) player:dmg(ent.atk) player:goInv(1.5) end,
            ['null'] = function(a,b) a.collideddown = true  end,
            ['small-bone'] =  function(player,ent) player:dmg(ent.atk) player:goInv(1.5) ent.dead = true end
        },
        -- dmgBoxes are used to extend hitboxes of entities, these are not necesarily confined to the attack state but could be used anywhere as they
        -- are predefined extensions
        --
        -- each has capabilities of having a graphic output
        --
        -- they can act as independent collision fields, with optional on Collide functions
        -- they can also be manipulated like any other entity as they posess a move function
        --
        -- they also don't collide with each other
        dmgBoxes = {
            ['up'] = {
                KBoss = true,
                xo = 6,
                yo = -24,
                width = 32,
                height = 32,
                rot = 0,
                animation = {
                    frames = (DEBUG == true and {4,5,6} or {3,2,1}),
                    frate = 0.06,
                    loop = false,
                    graphic = 'attack-p'
                    },
                onCollide = function(a,b)  b:dmg(a.atk) b:goInv(1)   end
            },
            ['down'] = {
                KBoss = true,
                xo = 33,
                yo = 60,
                width = 32,
                height = 32,
                rot = math.rad(180),
                animation = {
                    frames = (DEBUG == true and {4,5,6} or {3,2,1}),
                    frate = 0.06,
                    loop = false,
                    graphic = 'attack-p'
                    },
                onCollide = function(a,b)  b:dmg(a.atk) b:goInv(1) end
            },
            ['left'] = {
                KBoss = true,
                xo = -34,
                yo = 36,
                width = 32,
                height = 32,
                rot = math.rad(-90),
                animation = {
                    frames = (DEBUG == true and {4,5,6} or {3,2,1}),
                    frate = 0.06,
                    loop = false,
                    graphic = 'attack-p'
                    },
                onCollide = function(a,b)  b:dmg(a.atk) b:goInv(1)  end
            },
            ['right'] = {
                KBoss = true,
                xo = 62,
                yo = 4,
                width = 32,
                height = 32,
                rot = math.rad(90),
                animation = {
                    frames = (DEBUG == true and {4,5,6} or {3,2,1}),
                    frate = 0.06,
                    loop = false,
                    graphic = 'attack-p'
                    },
                onCollide = function(a,b)  b:dmg(a.atk) b:goInv(1)  end
            }
        }
    },
    ['start-platform'] = {
        active = false,
        invincible = true,
        id = 'start-platform',
        health = 0,
        atk = 0,
        graphic = 'start-platform',
        animations = {
            ['idle'] = {
                frames = {1},
                graphic = 'start-platform'
            }
        }
    },
    ['enemy'] = {
        active = false,
        written = true,
        id = 'enemy',
        health = 1,
        width = 20,
        height = 20,
        atk = 1,
        vel = {
            ['left'] = -20,
            ['right'] = 20,
            ['up'] = -20,
            ['down'] = 20

        },
        sounds = {
            ['death'] = gSounds['enemydeath']
        },
        animations = {

            ['idle'] =  {
                frames = {1,2},
                graphic = 'enemy',
                frate = 0.2,
                loop = true
            },
            ['death'] = {
                frames = {3,3,4},
                frate = 0.1,
                loop = false,
                graphic = 'enemy'
            },
        },
        collides = {
            [1] = 'player'
        },
        AI = {
            type = 'homing',
            radius = 100,
            sleepTime = {4}
        }


    },
    ['plattform'] = {
        active = false,
        invincible = true,
        id = 'plattform',
        health = 0,
        atk = 0,
        graphic = 'platforms',
        animations = {
            ['idle'] = {
                frames = {1},
                graphic = 'platforms'
            }
        }
        },
    ['boss'] = {
        active = false,
        written = true,
        health = 25,
        width = 64,
        height = 64,
        graphic = 'boss',
        atk = 1,
        id = 'boss',
        animations = {
            ['idle'] = {
                frames = {3,4,5},
                graphic = 'boss',
                frate = 0.2,
                loop = true
            },
            ['hurt'] = {
                frames = {6},
                graphic = 'boss'
            },
            ['death'] = {
                frames = {6,7},
                frate = 1,
                loop = false,
                graphic ='boss'
            },
            ['laugh'] = {
                frames = {1,2,3,2},
                loop = true,
                frate = 0.1,
                graphic = 'boss'
            }
        },
        sounds = {
            ['death'] = gSounds['bossdeath'],
            ['laugh'] = gSounds['bosslaugh'],
            ['hurt'] = gSounds['bossdeath']
        },

        AI = {
            type = 'rotating',
            radius = 50,
            rotationR = 1,
            attacks =  {
                ['bones'] =function(boss,x1,x2) return boneDash(boss,x1,x2)end,
                ['summon'] =function(boss,n,x) return enemySummon(boss,n,x)end,
                ['balls'] = function(boss,n,x) return pingPong(boss,n,x) end
            },
            sleepTime = {10}
        },
        dmgBoxes = {
            ['circles'] = {
                low = false,
                xo = 0,
                yo = 0,
                width = 20,
                KPlayer = true,
                height = 20,
                rot = 0,
                animation = {
                    frames = {1,2},
                    frate = 0.08,
                    loop = true,
                    graphic = 'attack-b-bone'
                    },
                onCollide = function(a,b)
                        if b.health > 0 then
                            b:dmg(a.atk) 
                            b:goInv(1.5)
                            a.dead = true
                        end 
                    end 
            }
        },
    },
    ['boss-platform'] = {
        active = false,
        invincible = true,
        id = 'boss-platform',
        health = 0,
        atk = 0,
        graphic = 'boss-platform',
        animations = {
            ['idle'] = {
                frames = {1},
                graphic = 'boss-platform'
            }
        }
    },
    ['bigBone'] = {
        active = true,
        invincible = false,
        id = 'bigBone',
        health = 50,
        atk = 1,
        graphic = 'bigBone',
        sounds = {
            ['coll'] = gSounds['bossbones'],
        },

        animations = {
            ['idle'] = {
                frames = {1},
                graphic = 'bigBone'
            },
            ['fall'] = {
                frames = {1},
                graphic = 'bigBone'
            }
        },
        collides = {
            [5] = 'boss-platform',
        },
        passes = {},
        onCollide = {
            ['boss-platform'] = function(a,b) a.collideddown = true gSounds['bossbones']:play() end
        }
    },
    ['small-bone'] = {
        active = true,
        written = true,
        id = 'small-bone',
        health = 1,
        atk = 1,
        graphic = 'attack-b-bone',
        animations = {
            ['idle'] = {
            frames = {1,2},
            frate = 0.08,
            loop = true,
            graphic = 'attack-b-bone'
            }
        },
        collides = {
            [1]='player',
            [2]='boss-platform',
            [3] = 'null'
        },
        passes = {},
        onCollide = {
            ['player'] = function(a,b) b:dmg(1) b:goInv(1.5) a.dead = true end,
            ['boss-platform'] = function(a,b) end,
            ['null'] = function(a,b) a.collideddown = true  end
        }
    }
}


MENU_DEF = {
    ['dead'] = {
        items = {
            





        }


    }




}






