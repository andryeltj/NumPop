function love.load()
 require("sys/glove_simple")
 gloveload()
 require("sys/colors")
 size = 14
 loadfont("res/fonts/mui-symbols.ttf","material-symbols")
 loadfont("res/fonts/KdamThmorPro-Regular.ttf","kdam")
 material=fontfamily("material-symbols")
 kdam=fontfamily("kdam",em(2))
 tbscores={}
 tbgamers={}
 tbconfig={1}
 usuarionm="seu_nome"
 loadsave("score.lua")
 tbkeys={"kp1","kp2","kp3","kp4","kp5","kp6","kp7","kp8","kp9","kp0","kpenter","kp.","kp+","kp-","kp*","kp/","numlock","home","end","pageup","pagedown"}
 tbcolorbt={}
 tbcolortxt={}
 tbbtstxt={1,2,3,4,5,6,7,8,9,0,"","","",""}
 tbmultis={1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100,200,300,400,500,600,700,800,900,1000,2000,3000,1}
 tbtarlvls={5,5,5,6,6,6,7,7,7,10,10,10,10,15,15,15,15,20,20,3,3,3,5,5,5,10,10,10,12,40,1}
 lvl = 1
 tbscorelevels={}
 tbscoretar={}
 tbhightscorepoints={}
 tbhightscoregamers={}
 tbtar={0,4,8,6}
 tbcorrect={0}
 tbwrong={}
 score=0
 ok="ok"
 tarnum=0
 tarrest=0
 tartotal=0
 lifes="A"
 text = ''
 memval = 0
 resval = 0
 germult= 99
 la.setIcon(li.newImageData("res/NumPop.png"))
 la.setTitle("NumPop")
 bks = "melody1.ogg"
 fsounds = "res/sounds/"
 fvideos="res/videos/"
 --bgm = love.audio.newSource(fsounds..bks, "stream")
 plock = love.sound.newSoundData(fsounds.."plock2.ogg")
 enters = love.sound.newSoundData(fsounds.."enter.ogg")
 errors = love.sound.newSoundData(fsounds.."ohno.ogg")
 wrongs = love.sound.newSoundData(fsounds.."wrong.ogg")
 up2s = love.sound.newSoundData(fsounds.."up2.ogg")
 alerts = love.sound.newSoundData(fsounds.."alert.ogg")
 loses = love.sound.newSoundData(fsounds.."losemusic.ogg")
 tbmusicnames={"melody1.ogg","melody2.ogg","melody3.ogg","melody4.ogg","melody5.ogg","melody6.ogg","music1.ogg"}
 tbmidia={}
 for k, v in pairs(tbmusicnames) do
   local musicdata=love.sound.newSoundData(fsounds..v)
   tbmidia[k]=love.audio.newSource(musicdata)
 end
 bgm=tbmidia[1]
 plocksound = love.audio.newSource(plock)
 entersound = love.audio.newSource(enters)
 errorsound = love.audio.newSource(errors)
 wrongsound = love.audio.newSource(wrongs)
 up2sound = love.audio.newSource(up2s)
 alertsound = love.audio.newSource(alerts)
 losesound = love.audio.newSource(loses)
 colorkeyok=paint("green400")
 colorkeyst=paint("orange500")
 colorkeywr=paint("red700")
 white=paint("white")
 renew()
 music = 1
 audiovol=0.03
 btmusic = 0
 if tbconfig[1] == 1 then btmusic = tbbtstxt[12]; bgm:play() else btmusic = tbbtstxt[13];bgm:stop() end
 enterrelease = "no"
 tmp = ''
 tmpk = ''
 live=''
 lastscore=tbscores[#tbscores]
 lastplayer=tbgamers[#tbgamers]
 hightscore()
 video = lg.newVideo(fvideos.."intro.ogv")
 if lifes == "A" then video:rewind();video:play() end
 usuarionm=tbgamers[#tbgamers]
 --clear()
end
function love.update()
 gloveupdate()
 onWindowChange(function() size=appWidth/20; material=fontfamily("material-symbols") end)
 w = em(3)
 h = em(3)
 rad = em(1)
 c1 = centerx-margin-w-(w/2)
 c2 = c1+margin+w
 c3 = c2+margin+w
 l1 = margin
 l2 = l1+margin+h
 l3 = l2+margin+h
 l4 = l3+margin+h
 largew = (w*3)+(margin*2)
 btbk=paint("white")
 btcolor=paint("black")
 cbt1x,cbt1y=centerobj(c1,l1,w,h)
 cbt2x,cbt2y=centerobj(c2,l1,w,h)
 cbt3x,cbt3y=centerobj(c3,l1,w,h)
 cbt4x,cbt4y=centerobj(c1,l2,w,h)
 cbt5x,cbt5y=centerobj(c2,l2,w,h)
 cbt6x,cbt6y=centerobj(c3,l2,w,h)
 cbt7x,cbt7y=centerobj(c1,l3,w,h)
 cbt8x,cbt8y=centerobj(c2,l3,w,h)
 cbt9x,cbt9y=centerobj(c3,l3,w,h)
 cbt0x,cbt0y=centerobj(c1,l4,largew,h)
 newtar()
 clickcorrect()
 clickwrong()
 uplevel()
 calcscore(germult)
 live=''
 if lifes ~= "A" then
  for i=1, lifes do live=live..tbbtstxt[14] end
 end
 love.audio.setVolume(audiovol)
 gloveupdateEnds()
end
--function keyboard()
function love.keypressed( key )
   glovekbstatus[1]=key;glovekbstatus[2]="pressed"    --ARGUMENT TO FUNCTION NOTE
   if key == "m" and lifes~="A" then
      music=tbconfig[1]
      if music == 1 then music = 0; bgm:stop() else music = 1;bgm:play() end
      tbconfig[1]=music
      if tbconfig[1] == 1 then btmusic = tbbtstxt[12]; else btmusic = tbbtstxt[13]; end
   end
   if key == "r" and lifes~="A" then
      lifes = "A";tbtar={};tbwrong={};renew();tbcorrect={};
      --lma.stop();
      if music == 1 then
      bgm:stop(); bgm=tbmidia[1];
      bgm:play();
      end
      score=0;lvl=1;tarnum=0;tartotal=0;tarrest=0;backgroundvideo(fvideos.."intro.ogv")
   end
   if lifes == "A" then
      if key == "return" then
         idplayer=#tbgamers;newnumbers()
         lifes=3;table.insert(tbgamers,usuarionm);table.insert(tbscores,0);love.audio.play(up2sound);
         if idplayer < 1 or idplayer == nil then idplayer = 1 end
         lastplayer=tbgamers[idplayer]
         lastscore=tbscores[idplayer]
      end
      if key == "kpenter" then
         print("Nova Jogada")
         idplayer=#tbgamers;newnumbers()
         lifes=3;table.insert(tbgamers,usuarionm);table.insert(tbscores,0);love.audio.play(up2sound)
         if idplayer < 1 or idplayer == nil then idplayer = 1 end
         lastplayer=tbgamers[idplayer]
         lastscore=tbscores[idplayer]
      end
   else
      keyok,keyv=0,""
      for k, v in pairs(tbkeys) do
         if key == v and lifes >= 1 then keyok=1;keyv=k end
      end
      if keyok == 1 and lvl ~= #tbtarlvls then
         ok="no"
         lma.play(plocksound)
         if keyv == 11 then
            print(lifes)
           if enterrelease == "ok" then
            ok="ok"
            tarconc=concluded()
            if tarconc == "ok" then
               print("tarefa concluida")
               renew();tbcorrect={};tbcorrect[1]="A"
               tarnum = tarnum + 1
               tartotal = tartotal + 1
               tarrest=tbtarlvls[lvl]-tarnum
               newnumbers();
               tbscorelevels[lvl]=score
               tbscores[#tbscores]=score
               insertlives()
               savescore()
            else
               lma.play(alertsound)
               print("tarefa inclompleta")
               local gtar = tbtarlvls[lvl]
               tbtarlvls[lvl] = gtar + 1
               if tbscoretar[tartotal] == nil then tbscoretar[tartotal] = 0 end
               score = score - (tbscoretar[tartotal]*tbmultis[lvl])
               if score < 0 then score=score*(-1) end
               savescore()
               function infotar()
                  listnumtar=""
                  listnumcorrect=""
                  for _,v in pairs(tbtar) do listnumtar=listnumtar..v end
                  for _,v in pairs(tbcorrect) do listnumcorrect=listnumcorrect..v end
                  print(listnumtar,listnumcorrect,keyv)
               end
               infotar()
            end
           end
         end
         for l, j in pairs(tbtar) do
            if j == keyv then
               --print(j,k,"ai")
               ok="ok"
               okcorrect = "ok"
               for d, f in pairs(tbcorrect) do
                 if f == j then okcorrect = "no" end
               end
               if okcorrect == "ok" then
                  print("Numero Correto")
                  table.insert(tbcorrect,j)
                 score = score+(resval*tbmultis[lvl])
                 tbscoretar[tartotal] = (resval*tbmultis[lvl])
                 memval=0;calcscore(germult)
                 enterrelease = "ok"
                 tbscores[#tbscores]=score
                 savescore()
               end
            elseif keyv == 10 and j == 0 then
               --print(j,k,"ui")
               k=0
               ok="ok"
               okcorrect = "ok"
               for g, n in pairs(tbcorrect) do
                if n == k then okcorrect = "no" end
               end
               if okcorrect == "ok" then
                  print("Numero Correto")
                table.insert(tbcorrect,k)
                score = score+(resval*tbmultis[lvl])
                tbscoretar[tartotal] = (resval*tbmultis[lvl])
                memval=0;calcscore(germult)
                enterrelease="ok"
                tbscores[#tbscores]=score
                savescore()
               end
            end
         end
         if ok == "no" then
            print("Numero Errado")
            lma.play(errorsound)
            lma.play(wrongsound)
            k = keyv
            if k == 10 then k = 0 end
            if k ~= 11 and tbwrong[#tbwrong] ~= k then table.insert(tbwrong,k); lifes=lifes-1 end
            tarnum = 0
            tbscorelevels[lvl]=0
            --print(tbwrong[#tbwrong])
            if tbwrong[#tbwrong] ~= k then score = tbscorelevels[lvl-1] end
            enterrelease="ok"
            tbscores[#tbscores]=score
            if score == nil then score=0 end
            if lifes == 0 then
               --lma.stop()
               if music == 1 then
                  bgm:stop();bgm=losesound
                  bgm:play()
               end
               backgroundvideo(fvideos.."lose.ogv") 
            end
            print("lifes:",lifes)
            savescore()
         end
         if lifes == 0 then savescore() end
         hightscore()
      end
   end
end
function love.keyreleased( key )
  --if key == "backspace" then
  glovekbstatus[1]=key;glovekbstatus[2]="released";glovekbtxt=''    --ARGUMENT TO FUNCTION NOTE
   memval=0;calcscore(germult)
  --end
end
function love.textinput(t) glovekbtxt=t end
function love.draw()
if  lifes ~= "A" and lifes >= 1 and lvl ~= #tbtarlvls then
 background(paint("blue700"))
 if video:isPlaying() then
   love.graphics.draw(video, 0,0, 0, video.scale) 
  else 
   video:rewind()
  end
 frame(tbcolorbt[7],c1,l1,w,h,rad)
 frame(tbcolorbt[8],c2,l1,w,h,rad)
 frame(tbcolorbt[9],c3,l1,w,h,rad)
 frame(tbcolorbt[4],c1,l2,w,h,rad)
 frame(tbcolorbt[5],c2,l2,w,h,rad)
 frame(tbcolorbt[6],c3,l2,w,h,rad)
 frame(tbcolorbt[1],c1,l3,w,h,rad)
 frame(tbcolorbt[2],c2,l3,w,h,rad)
 frame(tbcolorbt[3],c3,l3,w,h,rad)
 frame(tbcolorbt[10],c1,l4,largew,h,rad)
 write(tbcolortxt[7],tbbtstxt[7],cbt1x-em(0.5),cbt1y-em(0.5),material)
 write(tbcolortxt[8],tbbtstxt[8],cbt2x-em(0.5),cbt2y-em(0.5),material)
 write(tbcolortxt[9],tbbtstxt[9],cbt3x-em(0.5),cbt3y-em(0.5),material)
 write(tbcolortxt[4],tbbtstxt[4],cbt4x-em(0.5),cbt4y-em(0.5),material)
 write(tbcolortxt[5],tbbtstxt[5],cbt5x-em(0.5),cbt5y-em(0.5),material)
 write(tbcolortxt[6],tbbtstxt[6],cbt6x-em(0.5),cbt6y-em(0.5),material)
 write(tbcolortxt[1],tbbtstxt[1],cbt7x-em(0.5),cbt7y-em(0.5),material)
 write(tbcolortxt[2],tbbtstxt[2],cbt8x-em(0.5),cbt8y-em(0.5),material)
 write(tbcolortxt[3],tbbtstxt[3],cbt9x-em(0.5),cbt9y-em(0.5),material)
 write(tbcolortxt[10],tbbtstxt[10],cbt0x-em(0.5),cbt0y-em(0.5),material)
 button(paint("white",0),btbk,tbbtstxt[11],material,nil,appWidth-em(2),centery-em(0.5),em(1.5),em(1.5),em(1.5))
 button(paint("white",0),btbk,"\""..usuarionm.."\" "..score,kdam,nil,em(.1),em(.3))
 button(paint("white",0),white,btmusic,material,nil,appWidth-em(2),centery+em(2))
 write(btbk,lvl,appWidth-em(2),em(2),material)
 write(btbk,tarrest,appWidth-em(1.5),em(4),kdam)
 write(btbk,"x"..tbmultis[lvl],appWidth-em(4),appHeight-em(2),material)
 write(btbk,live,appWidth-margin-em(lifes),0,material)
 --SIDESCORE
 write(btbk,"Ultimo: \""..lastplayer.."\" "..lastscore,em(0.5),em(3))
 ate=1
 if #tbhightscoregamers > 10 then ate = 10 else ate = #tbhightscoregamers end
 for i=1, ate do
   --print(i,tbhightscoregamers[i],tbhightscorepoints[i])
   min=i*0.5
   write(btbk,i..
   ". \""..tbhightscoregamers[i]..
   "\" "..tbhightscorepoints[i]..""
   ,em(0.5),em(3+min))
 end
 
elseif  lifes ~= "A" and lvl ~= #tbtarlvls then
 background(paint("red500"))
 if video:isPlaying() then
   love.graphics.draw(video, 0,0, 0, video.scale) 
  else 
   video:rewind()
  end
 button(paint("white",0),white,"FIM DE JOGO",material,nil,centerx-em(5.5),centery)
 button(paint("white",0),btbk,usuarionm.." "..score,material,nil,em(.5),em(2))
 button(paint("white",0),white,"clique no 'R' para reiniciar o jogo",kdam,nil,centerx-em(5),appHeight-em(1.5))
elseif  lvl == #tbtarlvls then
   background(paint("blue200"))
   if video:isPlaying() then
     love.graphics.draw(video, 0,0, 0, video.scale) 
    else 
     video:rewind()
    end
   button(paint("white",0),white,"PARABENS",material,nil,centerx-em(5.5),centery)
   button(paint("white",0),white,usuarionm.." "..score,material,nil,em(.5),em(2))
   button(paint("white",0),white,"clique no 'R' para reiniciar o jogo",kdam,nil,centerx-em(5),appHeight-em(1.5))
elseif lifes == "A" then
 background(paint("#9a0621"))
 if video:isPlaying() then
   love.graphics.draw(video, 0,0, 0, video.scale) 
  else 
   video:rewind()
  end
 button(paint("white",0),white,"jogador",material,nil,centerx-em(3.5),centery-em(2))
 usuarionm=note(paint("white",.3),white,usuarionm,kdam,centerx-em(5),centery,em(10),em(1),nil,1)
 button(paint("darkorange"),white,"INICIAR",material,nil,centerx-em(3.5),centery+em(2),em(7.5),em(1.2),em(.5))
end

 --write(btbk,text,0,0,material)
end
function calcscore(maximo)
   if maximo ~= memval then
      memval=maximo
      resval=maximo
   else
      resval = resval-1
      if resval <= 1 then resval=1 end
      return resval
   end
   --keyreleased aciona o cronometro
   --em um tempo de 3 segundos ele reduz o valor maximo de score a 1
   
end
function ramdomn(a,b)
   return math.random (a, b)
end

function newnumbers()
   lma.play(entersound)
   tbtar={}
   tbwrong={}
   tbcorrect={}
   renew()
   local tararea = ramdomn(1, 9);  --numbers to show
   local numramdom = 0;
   --table.insert(tbtar,"A")
   function mama()
      local ctnewnumber="ok"
      numramdom = ramdomn(0, 9)
      for k,v in pairs(tbtar) do
         if v == numramdom then mama();  end
      end
   end
   for i=0,tararea do
      mama()
      table.insert(tbtar,numramdom)
   end
   --renew()
   newtar()
   --[[mtmp=''
   for _,v in pairs(tbtar) do mtmp=mtmp..v end
   print(mtmp)]]
end
function clickcorrect()
   for k,v in pairs(tbcorrect) do
     if v == 1 then tbcolorbt[1] = colorkeyok;tbcolortxt[1] = white; end
     if v == 2 then tbcolorbt[2] = colorkeyok;tbcolortxt[2] = white; end
     if v == 3 then tbcolorbt[3] = colorkeyok;tbcolortxt[3] = white; end
     if v == 4 then tbcolorbt[4] = colorkeyok;tbcolortxt[4] = white; end
     if v == 5 then tbcolorbt[5] = colorkeyok;tbcolortxt[5] = white; end
     if v == 6 then tbcolorbt[6] = colorkeyok;tbcolortxt[6] = white; end
     if v == 7 then tbcolorbt[7] = colorkeyok;tbcolortxt[7] = white; end
     if v == 8 then tbcolorbt[8] = colorkeyok;tbcolortxt[8] = white; end
     if v == 9 then tbcolorbt[9] = colorkeyok;tbcolortxt[9] = white; end
     if v == 0 then tbcolorbt[10] = colorkeyok;tbcolortxt[10] = white; end
   end
end
function clickwrong()
   for k,v in pairs(tbwrong) do
     if v == 1 then tbcolorbt[1] = colorkeywr;tbcolortxt[1] = white; end
     if v == 2 then tbcolorbt[2] = colorkeywr;tbcolortxt[2] = white; end
     if v == 3 then tbcolorbt[3] = colorkeywr;tbcolortxt[3] = white; end
     if v == 4 then tbcolorbt[4] = colorkeywr;tbcolortxt[4] = white; end
     if v == 5 then tbcolorbt[5] = colorkeywr;tbcolortxt[5] = white; end
     if v == 6 then tbcolorbt[6] = colorkeywr;tbcolortxt[6] = white; end
     if v == 7 then tbcolorbt[7] = colorkeywr;tbcolortxt[7] = white; end
     if v == 8 then tbcolorbt[8] = colorkeywr;tbcolortxt[8] = white; end
     if v == 9 then tbcolorbt[9] = colorkeywr;tbcolortxt[9] = white; end
     if v == 0 then tbcolorbt[10] = colorkeywr;tbcolortxt[10] = white; end
   end
end
  
function newtar()
   for k,v in pairs(tbtar) do
      if v == 1 then tbcolorbt[1] = colorkeyst;tbcolortxt[1] = white; end
      if v == 2 then tbcolorbt[2] = colorkeyst;tbcolortxt[2] = white; end
      if v == 3 then tbcolorbt[3] = colorkeyst;tbcolortxt[3] = white; end
      if v == 4 then tbcolorbt[4] = colorkeyst;tbcolortxt[4] = white; end
      if v == 5 then tbcolorbt[5] = colorkeyst;tbcolortxt[5] = white; end
      if v == 6 then tbcolorbt[6] = colorkeyst;tbcolortxt[6] = white; end
      if v == 7 then tbcolorbt[7] = colorkeyst;tbcolortxt[7] = white; end
      if v == 8 then tbcolorbt[8] = colorkeyst;tbcolortxt[8] = white; end
      if v == 9 then tbcolorbt[9] = colorkeyst;tbcolortxt[9] = white; end
      if v == 0 then tbcolorbt[10] = colorkeyst;tbcolortxt[10] = white; end
    end
end
function renew()
   tbcolorbt[1]=paint("white");tbcolortxt[1] = btcolor
   tbcolorbt[2]=paint("white");tbcolortxt[2] = btcolor
   tbcolorbt[3]=paint("white");tbcolortxt[3] = btcolor
   tbcolorbt[4]=paint("white");tbcolortxt[4] = btcolor
   tbcolorbt[5]=paint("white");tbcolortxt[5] = btcolor
   tbcolorbt[6]=paint("white");tbcolortxt[6] = btcolor
   tbcolorbt[7]=paint("white");tbcolortxt[7] = btcolor
   tbcolorbt[8]=paint("white");tbcolortxt[8] = btcolor
   tbcolorbt[9]=paint("white");tbcolortxt[9] = btcolor
   tbcolorbt[10]=paint("white");tbcolortxt[10] = btcolor
end
function uplevel()
   if tarnum == tbtarlvls[lvl] then
      tarnum=0;
      lvl = lvl + 1;
      table.insert(tbscorelevels,score)
      if lvl == 3 and lifes ~= "A" then backgroundvideo(fvideos.."1.ogv") end
      if lvl == 5 then bgm:stop(); bgm=tbmidia[2]; bgm:play() end
      if lvl == 10 then bgm:stop(); bgm=tbmidia[3]; bgm:play();backgroundvideo(fvideos.."2.ogv") end
      if lvl == 14 then backgroundvideo(fvideos.."3.ogv") end
      if lvl == 18 then bgm:stop(); bgm=tbmidia[4]; bgm:play();backgroundvideo(fvideos.."4.ogv") end
      if lvl == 20 then backgroundvideo(fvideos.."5.ogv") end
      if lvl == 22 then bgm:stop(); bgm=tbmidia[5]; bgm:play() end
      if lvl == 29 then backgroundvideo(fvideos.."6.ogv") end
      if lvl == 30 then bgm:stop(); bgm=tbmidia[6]; bgm:play();backgroundvideo(fvideos.."7.ogv") end
      if lvl == 31 then bgm:stop(); bgm=tbmidia[7]; bgm:play();backgroundvideo(fvideos.."win.ogv") end
      love.audio.play(up2sound)
   end
end
function backgroundvideo(path)
   video:pause(); video = lg.newVideo(path);video:rewind();video:play()
end
function concluded()
   local tab1 = #tbcorrect
   local tab2 = #tbtar
   local resultado = "no"
   
   for k, v in pairs(tbtar) do tmp=tmp..","..v end
   for k, v in pairs(tbcorrect) do 
      tmpk=tmpk..","..v
      resultado = "no"
      for j, l in pairs(tbtar) do
         if l == 10 then l = 0 end
         if v == l then resultado = "ok" end
      end
   end
   --print(tmp,tmpk);tmp,tmpk="",""
   if tab1 ~= tab2 then resultado="no" end
   return resultado
   --if tab1 == tab2 then return "ok" else return "no" end
end
function savescore()
   --scoretb=usuarionm..'='..score
   local listusrs=""
   local listpoints=""
   local listconfigs=""
   for k, v in pairs(tbgamers) do
      listusrs=listusrs..",'"..v.."'"
   end
   listusrs=string.sub(listusrs, 2, n)
   for k, v in pairs(tbscores) do
      listpoints=listpoints..","..v
   end
   listpoints=string.sub(listpoints, 2, n)
   
   for k, v in pairs(tbconfig) do
      listconfigs=listconfigs..","..v
   end
   listconfigs=string.sub(listconfigs, 2, n)

   mainscore="tbgamers={"..listusrs.."}\
tbscores={"..listpoints.."}\
tbconfig={"..listconfigs.."}"
   glovesave("score.lua",mainscore)
   la.setTitle("NumPop  -   "..usuarionm.." : "..score)
end
function insertlives()
   if lvl <= 3 and score >= 5000 and lifes < 2 then lifes = lifes+1 end
end
function hightscore()
   tbhightscorepoints={}
   tbhightscoregamers={}
   for n,v in pairs(tbscores) do table.insert(tbhightscorepoints, v); end
   table.sort(tbhightscorepoints, function(a,b) return a > b end)
   --clear()
   for k,v in pairs(tbhightscorepoints) do
      nmck=1
      for q,l in pairs(tbscores) do
         if v == l and nmck == 1 then
            nmck=0
            table.insert(tbhightscoregamers,tbgamers[q]);
         end
      end
      --print(tbhightscorepoints[k],tbhightscoregamers[k])
   end
   --for n,v in pairs(tborderpoints) do print(v) end
  
end