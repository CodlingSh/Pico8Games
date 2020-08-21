pico-8 cartridge // http://www.pico-8.com
version 27
__lua__

--TODO: Add collision between player and fruit
--TODO: Add to health and score when collecting fruit
--TODO: Animate player when walking and dying
--TODO: Add 3 lives and a function to make the player die

function add_fruit()
    add(fruit, {
        x = flr(rnd(116)) + 2,
        y = 15 + flr(rnd(85)),
        sprite = 4,
        update = function(self)
            if self.y <= player.y and self.y + 8 >= player.y then
                hor_align = true
            else
                hor_align = false
            end
            if self.x <= player.x and self.x + 8 >= player.x then
                vert_align = true
            else
                vert_align = false
            end
        end,    
        draw = function(self)
            spr(self.sprite, self.x, self.y)
            if hor_align == true then
                print('horizontal!', 5, 120, 7)
            end
            if vert_align == true then
                print('vertical!', 55, 120, 7)
            end
        end
    })
end

function _init()
    score1 = 0
    score2 = 0
    score3 = 0
    score4 = 0
    score5 = 0
    score6 = 0
    score7 = 0
    score8 = 0

    fruit = {}
    
    logo = {
        x = 1,
        y = 14,
        w = 32,
        h = 16,
        col = 7,
        xdir = 1,
        ydir = 1,
        update = function(self)
            self.x += self.xdir
            self.y += self.ydir

            if self.x == 1
            or self.x + self.w == 126 then
                self.xdir = -self.xdir
                self.col = flr(rnd(15)+1)

            end
            
            if self.y == 14
            or self.y + self.h == 108 then
                self.ydir = -self.ydir
                self.col = flr(rnd(15)+1)
            end

        end,
        draw = function(self)
            spr(0, self.x, self.y, 4, 2)
            pal(6, self.col)

        end
    }

    player = {
        sp = 64,
        x = 59,
        y = 59,
        w = 8,
        h = 8,
        mov = 1,
        flp = false,
        stand = true,
        update = function(self)
            if btn(0) and self.x > 1 then
                self.x -= self.mov
                self.flp = false
                stand = false
            else
                stand = true
            end
            if btn(1) and self.x < 127 - self.w then
                self.x += self.mov
                self.flp = true
                stand = false
            else
                stand = true
            end
            if btn(2) and self.y > 14 then
                self.y -= self.mov
                self.sp = 67
                stand = false
            else
                stand = true
            end
            if btn(3) and self.y < 109 - self.h then
                self.y += self.mov
                self.sp = 64
                stand = false
            else
                stand = true
            end
        end,
        draw = function(self)
            spr(self.sp, self.x, self.y, 1, 1, self.flp)
            rect(self.x, self.y, self.x + 7, self.y + 7, 7)
        end
    }

    lifebar = {
        x = 118,
        sprite = 9,
        tick = 0,
        speed = 1,
        dead = false,
        update = function(self)
            self.tick += 1
            if self.tick >= 45 then
                self.x -= 1
                self.tick = 0
            end
            if self.x <= 74 then
                self.dead = true
            end

        end,
        draw = function(self)
            --Draw red to represent life
            spr(self.sprite, self.x, 0)
            spr(self.sprite, self.x - 8 * 1, 0)
            spr(self.sprite, self.x - 8 * 2, 0)
            spr(self.sprite, self.x - 8 * 3, 0)
            spr(self.sprite, self.x - 8 * 4, 0)
            spr(self.sprite, self.x - 8 * 5, 0)

            --Draw life bar
            spr(5, 72, 0)            
            spr(6, 72 + 8 * 1, 0)
            spr(7, 72 + 8 * 2, 0)            
            spr(7, 72 + 8 * 3, 0)           
            spr(7, 72 + 8 * 4, 0)
            spr(7, 72 + 8 * 5, 0)
            spr(8, 72 + 8 * 6, 0)

            if self.dead == true then
                print("yOU dIED", 48, 115, 7)
            end



        end
    }
    add_fruit()
end

function _update()
    lifebar:update()
    logo:update()
    player:update()
    for f in all(fruit) do
        f:update()
    end
end

function _draw()
    palt(0, false) --draw black pixels
    palt(14, true) --don't draw pink

    cls()
    lifebar:draw()
    rectfill(0, 0, 72, 8, 0) -- This rectangle is here to cover up the "health" when it leaves the health bar
    for f in all(fruit) do
        f:draw()
    end
    player:draw()
    logo:draw()
    rect(0, 13, 127, 109, 5)
    print('score: ' .. score1 .. score2 .. score3 .. score4 .. score5 .. score6 .. score7 .. score8, 1, 1, 7)

end

__gfx__
e6666666666666eeeeee6666666666eee777777eee99999999999999999999999999999eeeeeeeee000000000000000000000000000000000000000000000000
e6666666666666eeeee666666666666e75555557e999339999aaaaaaaaaaaaaaaaaaaa99eeeeeeee000000000000000000000000000000000000000000000000
eeeeeeee6666666eee666eeeeeeee66675775557e99933999aeeeeeeeeeeeeeeeeeeeea988888888000000000000000000000000000000000000000000000000
e666eeeee66e666ee666e666eeeee66675555557e93333339aeeeeeeeeeeeeeeeeeeeea988888888000000000000000000000000000000000000000000000000
e666eeee666e666ee66ee666eeeee66e87777778e93333339aeeeeeeeeeeeeeeeeeeeea988888888000000000000000000000000000000000000000000000000
6666eee666eee66666ee6666eeee666e88878888e99933999aeeeeeeeeeeeeeeeeeeeea988888888000000000000000000000000000000000000000000000000
666666666eeee66666ee666666666eee88887888e999339999aaaaaaaaaaaaaaaaaaaa99eeeeeeee000000000000000000000000000000000000000000000000
6666666eeeeee6666eee6666666eeeeee888888eee99999999999999999999999999999eeeeeeeee000000000000000000000000000000000000000000000000
eeeeeeeeeeeeee66eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeee6eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeee6666666666666666666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
e666666666666eeeeee666666666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
666666666666eeeeeeee666666666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
666666666666eeeeeeee666666666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
e666666666666eeeeee666666666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeee6666666666666666666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeffffeeeeffffeeeeffffeeeeffffeeeeffffeeeeffffeeee5555eeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
ee1f1feeee1f1feeee1f1feeeeffffeeeeffffeeeeffffee55566555eeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeffffeeeeffffeeeeffffeeeeffffeeeeffffeeeeffffee56666665eeeeeeee0000000000000000000000000000000000000000000000000000000000000000
e333333ee333333ee333333ee333333ee333333ee333333e55566555eeeeeeee0000000000000000000000000000000000000000000000000000000000000000
fe3333effe3333effe3333effe3333effe3333effe3333efee5665eeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
fe3333effe3333effe3333effe3333effe3333effe3333efee5665eeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
ee1ee1eee44ee1eeee1e44eeee1ee1eee44ee1eeee1e44eeee5665eeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
e44e44eeeeee44eee44eeeeee44e44eeeeee44eee44eeeeeee5555eeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
