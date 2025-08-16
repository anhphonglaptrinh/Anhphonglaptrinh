-- Auto Chat "ez" mỗi 1 giây
local player = game.Players.LocalPlayer
local chatService = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")

while true do
    chatService.SayMessageRequest:FireServer("ez", "All") -- "All" = chat công khai
    wait(1) -- 1 giây
end
