---
---@type table

local SettingsButton = {
    Rectangle = { Y = 0, Width = 420, Height = 38 },
    Line = { X = 8, Y = 15 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

function RageUI.Dline(Style)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                
               -- RenderRectangle(CurrentMenu.X + SettingsButton.Line.X + (CurrentMenu.WidthOffset * 10.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 0), CurrentMenu.Y + SettingsButton.Line.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 45, 4, 255, 255, 255, 100)
                RenderRectangle(CurrentMenu.X + SettingsButton.Line.X + (CurrentMenu.WidthOffset * 10.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 75), CurrentMenu.Y + SettingsButton.Line.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 45, 4, 255, 255, 255, 100)
                RenderRectangle(CurrentMenu.X + SettingsButton.Line.X + (CurrentMenu.WidthOffset * 10.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 175), CurrentMenu.Y + SettingsButton.Line.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 45, 4, 255, 255, 255, 100)
                RenderRectangle(CurrentMenu.X + SettingsButton.Line.X + (CurrentMenu.WidthOffset * 10.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 275), CurrentMenu.Y + SettingsButton.Line.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 45, 4, 255, 255, 255, 100)
              --  RenderRectangle(CurrentMenu.X + SettingsButton.Line.X + (CurrentMenu.WidthOffset * 10.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 375), CurrentMenu.Y + SettingsButton.Line.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 45, 4, 255, 255, 255, 100)
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (RageUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUI.Options = RageUI.Options + 1
        end
    end
end

