-- ~/.hammerspoon/init.lua

-- アプリ切り替え
local apps = {
  F16 = "iTerm",
  F17 = "Microsoft Teams",
}
for key, app in pairs(apps) do
  hs.hotkey.bind({}, key, function() hs.application.launchOrFocus(app) end)
end

-- F18: Teamsを前面に出してミュートを切り替え
hs.hotkey.bind({}, "F18", function()
  local app = hs.application.get("com.microsoft.teams2")
  if not app then hs.alert.show("Teamsが起動していません") return end
  app:activate()

  local tries = 0
  hs.timer.waitUntil(function()
    tries = tries + 1
    local front = hs.application.frontmostApplication()
    return (front and front:bundleID() == "com.microsoft.teams2") or tries > 40
  end, function()
    hs.timer.doAfter(0.2, function()
      hs.eventtap.keyStroke({"cmd", "shift"}, "m", 0, app)
    end)
  end, 0.05)
end)

-- Ctrl + Space: 日本語と英語を切り替え（macOS標準の切り替え不具合を回避）
local ABC = "com.apple.keylayout.ABC"
local JA = "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese"

hs.hotkey.bind({"ctrl"}, "space", function()
    local current = hs.keycodes.currentSourceID()
    local target = current == ABC and JA or ABC

    local success = hs.keycodes.currentSourceID(target)

    if not success then
        hs.alert.show("入力ソースの切り替えに失敗")
    end
end)
