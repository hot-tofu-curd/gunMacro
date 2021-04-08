local a = 0
local gunY = 3; -- Y轴参数
local gunX = 0; -- X轴参数
local runningtime = 0; -- 脚本运行时间
EnablePrimaryMouseButtonEvents(true);
local mode = 0;
local Y1 = 0;
local X1 = 0;
local Y2 = 0;
local X2 = 0;
startgame = -1

function OnEvent(event, arg)
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 4) then -- 调整压强参数，X轴右为正，Y轴下为正
        if IsModifierPressed("lctrl") then -- 压枪强度+1
            gunY = gunY + 1
        elseif IsModifierPressed("lshift") then -- 压枪程度-1
            gunY = gunY - 1
        elseif IsModifierPressed("ralt") then -- 左压枪+1
            gunX = gunX - 1
        elseif IsModifierPressed("rctrl") then -- 右压枪+1
            gunX = gunX + 1
        end
        OutputLogMessage("gunY:%s,gunX:%s ", gunY, gunX)
        OutputLogMessage("\n")
        weapon1aa = math.floor(gunY);
        weapon1ba = math.floor(gunX);
    end

    if (event == "MOUSE_BUTTON_PRESSED" and arg == 5) then -- 宏开关
        startgame = -1 * startgame
        if (startgame == 1) then
            MoveMouseRelative(0, 100);
            Sleep(100);
            MoveMouseRelative(0, -100);
        end
        OutputLogMessage("state:");
        OutputLogMessage(startgame);
        OutputLogMessage("\n");
    end

    if startgame == 1 then
        Sleep(5)
        if IsMouseButtonPressed(1) then -- 开始压枪
            runningtime = GetRunningTime();
            if (a == 0) and mode == 0 then

                Sleep(30)
                -- MoveMouseRelative(0, 2 * weapon1a)
                repeat
                    Y1 = math.floor(gunY / 2);
                    X1 = gunX - 1;
                    Y2 = gunY - Y1;
                    X2 = gunX + 1;

                    Sleep(15)
                    MoveMouseRelative(-1, Y1) -- Y轴移动  -1，1
                    OutputLogMessage("X:%s,Y:%s\n", X1, Y1) -- 3,0

                    Sleep(15)
                    MoveMouseRelative(X2, Y2) -- X轴移动   1，2
                    OutputLogMessage("X:%s,Y:%s\n\n", X2, Y2) -- 2,0

                    X1 = 0;
                    Y1 = 0;
                    X2 = 0;
                    Y2 = 0;
                until not IsMouseButtonPressed(1)
            end
        end
    end
end
