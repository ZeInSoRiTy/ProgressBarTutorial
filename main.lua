--1.1
--функция на Tween

local TweenService = game:GetService("TweenService")

local Bar = --путь до прогресс бара
local Clipping = Bar:WaitForChild("Clipping") -- названия могут быть любые, главное структура должна быть такой же как в видео
local Top = Clipping.Top

function resizeCustomLoadingBar(sizeRatio, clipping, top)

	--sizeRatio = 0.5 -> 50% полоски должно быть заполнено
	local twInfo = TweenInfo.new(.001, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	--clippingTween
	local clTw = TweenService:Create(clipping, twInfo, {Size = UDim2.new(sizeRatio, clipping.Size.X.Offset, clipping.Size.Y.Scale, clipping.Size.Y.Offset)})
	--topTween
	local tTw = TweenService:Create(top, twInfo, {Size = UDim2.new((sizeRatio > 0 and 1 / sizeRatio) or 0, top.Size.X.Offset, top.Size.Y.Scale, top.Size.Y.Offset)})
	clTw:Play()
	tTw:Play()

	clTw.Completed:Wait()

end

--1.2
--функция на чистом Size

local Bar = --путь до прогресс бара
local Clipping = Bar:WaitForChild("Clipping") -- названия могут быть любые, главное структура должна быть такой же как в видео
local Top = Clipping.Top

function resizeCustomLoadingBar(sizeRatio, clipping, top)
	
	--sizeRatio = 0.5 -> 50% полоски должно быть заполнено
	
	clipping.Size = UDim2.new(sizeRatio, clipping.Size.X.Offset, clipping.Size.Y.Scale, clipping.Size.Y.Offset)
	top.Size = UDim2.new((sizeRatio > 0 and 1 / sizeRatio) or 0, top.Size.X.Offset, top.Size.Y.Scale, top.Size.Y.Offset) -- Проверка, чтобы не произошло деления 1 / 0 (иначе выдаст ошибку)
	
end

--пример работы прогресс бара
if game:IsLoaded() then

	for i=1,500 do
		
		local percentofAssets = i/500
		
		
		resizeCustomLoadingBar(percentofAssets, Clipping, Top)
		
		task.wait(.001)
	end
	
	for i=1,720 do
		
		Clipping.Rotation += 1
		task.wait(.001)
	end
	
	task.wait(1)
	
	Bar.Parent.Enabled = false 
	Bar.Parent.Parent.HealthUI.Enabled = true
end
