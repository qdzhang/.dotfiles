-- This script pauses playback when exiting fullscreent, and resumes playback
-- if it's fullscreen back again. If the player was already paused when exiting
-- fullscreen, then try not to mess with the pause state.

function on_exiting_fullscreen_change(name, value)
   if value == false then
      local pause = mp.get_property_native("pause")
      if pause == false then
         mp.set_property_native("pause", true)
      end
   end
end
mp.observe_property("fullscreen", "bool", on_exiting_fullscreen_change)
