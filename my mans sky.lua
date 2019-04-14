--------------------------------------
-- Information of recording
-- Time: 2019-04-11 01:20:54
-- Resolution: 1242, 2208
-- Front most app: R-Play
-- Orientation of front most app: LandscapeLeft;
--------------------------------------
--[[comment]]--
--also commented

--screen res. 2208,1242
-- (1,840,925); stick center
-- stick range; 150 ??

-- (1,2177,1159); o center      tap(2177,1159);
-- (1,2126,1211); x center      tap(2126,1211);
-- (1,2126,1103); tri center    tap(2126,1103);
-- (1,2071,1159); sq center     tap(2071,1159);

-- 420, 925     center of slot 0,0 inventory
-- 560, 925     center of slot 0,1 inventory
--1850, 820     center of <<
--2000, 820     center of >
--1625, 700     center of product

-- 370, 870 --> 480, 980 diagonal of item picture slot 0,0
-- 510, 870 --> 620, 980 diagonal of item picture slot 0,1
--1820, 795 --> 1880, 850 diagonal of << 
--1970, 795 --> 2030, 850 diagonal of >
--1570, 660 --> 1680, 770 diagonal of product

--public vars

--Basic functions
function sleepTime(n)
  if (n == nil or n <= 10000) then
    return 16000;
  else
    return n;
  end
end
function pressButton(buttonX,buttonY)
  touchDown(1,buttonX,buttonY);
  usleep(sleepTime());
  touchUp(1,buttonX,buttonY);
  usleep(sleepTime());
end  
function holdButton(buttonX,buttonY)
  touchDown(1,buttonX,buttonY);
  usleep(1100000);
  touchUp(1,buttonX,buttonY);
  usleep(sleepTime());
end

--Basic button control
function PressO()
  pressButton(2177,1159);
end
function pressX()
  pressButton(2126,1211);
end
function pressTri()
  pressButton(2126,1103);
end
function holdSq()
  holdButton(2071,1159);
end

--Basic stick movement
function moveStickDir(relX,relY,holdTime,maxRadius)
  stickHomeX, stickHomeY = 850, 925;
  if (math.sqrt(relX * relX + relY * relY) > maxRadius) then
    relX = (relX / math.sqrt(relX * relX + relY * relY)) * maxRadius;
    relY = (relY / math.sqrt(relX * relX + relY * relY)) * maxRadius;
    newStickX = stickHomeX + relX;
    newStickY = stickHomeY + relY;
  else
    newStickX = stickHomeX + relX;
    newStickY = stickHomeY + relY;
  end
  touchDown(1,stickHomeX,stickHomeY);
  usleep(sleepTime());
  touchMove(1, newStickX, newStickY);
  usleep(holdTime());
  touchUp(1, newStickX, newStickY);
  usleep(sleepTime());
end

--Bring cursor to 0,1242
function homeCursor(holdTime)
  touchDown(1,850,925);
  usleep(sleepTime());
  touchMove(1,725,1050);
  usleep(holdTime);
  touchUp(1,725,1050);
  usleep(sleepTime());
end


--start cycle
appActivate("com.iosremoteplay.app"); --switch to r play if not already
homeCursor(2000000);              --to corner

moveStickDir(244,704,50000,20); 	--to reactant
pressX();  			        		  	  --open menu
moveStickDir(480,-980,50000,20);  --to burner
pressX();							            --select burner
moveStickDir(1625,700,50000,20);  --to reactant
pressX();							            --place burner
moveStickDir(1850,820,50000,20);  --to num mod
pressX();							            --select 0
moveStickDir(2000,820,50000,20);  --to +1
pressX();							            --select +1
holdSq();
moveStickDir(1625,700,50000,20);
pressTri();
moveStickDir(100,100,50000,20);
pressX();
moveStickDir(-100,100,50000,20);
pressX();
moveStickDir(-100,-100,50000,20);
pressX();
moveStickDir(100,-100,50000,20);
pressX();
pressO();
pressX();
pressTri();
--end of cycle. 
--[[--]]