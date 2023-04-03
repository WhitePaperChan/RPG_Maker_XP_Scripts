# =============================================================================
# WhitePaper_OnePersonMenuXP
# =============================================================================
# Робить екран меню більш пристосованим під гру з одн_ією геро_їнею.
#
# Портрет геро_їні має знаходитися в папці Pictures, мати ту ж назву, що й 
# графіка на карті в базі даних, і бути в форматі png.
# 
# Технічні подробиці:
# Цей скрипт:
# * змінює метод update_command класу Scene_Menu,
# * змінює метод refresh класу Window_MenuStatus,
# * додає метод draw_actor_portrait класу Window_MenuStatus.
#
# =============================================================================
# Ліцензія
# ==============================================================================
#
# Цей скрипт розповсюджується за ліцензією MIT-0 (MIT No Attribution License)
#
# MIT No Attribution
#
# Copyright 2023 WhitePaperChan
#
# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), to deal 
# in the Software without restriction, including without limitation the rights 
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
# SOFTWARE. 
# =============================================================================

# =============================================================================
# Початок налаштувань
# =============================================================================

# =============================================================================
# Зсув графіки портрету у пікселях
# =============================================================================
WP_ONEPERSON_OFFSET_X = 50
WP_ONEPERSON_OFFSET_Y = 25

# =============================================================================
# Кінець налаштувань
# =============================================================================

#==============================================================================
# ** Scene_Menu
#------------------------------------------------------------------------------
#  This class performs menu screen processing.
#==============================================================================

class Scene_Menu
  
  def update_command
    # If B button was pressed
    if Input.trigger?(Input::B)
      # Play cancel SE
      $game_system.se_play($data_system.cancel_se)
      # Switch to map screen
      $scene = Scene_Map.new
      return
    end
    # If C button was pressed
    if Input.trigger?(Input::C)
      # If command other than save or end game, and party members = 0
      if $game_party.actors.size == 0 and @command_window.index < 4
        # Play buzzer SE
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      # Branch by command window cursor position
      case @command_window.index
      when 0  # item
        # Play decision SE
        $game_system.se_play($data_system.decision_se)
        # Switch to item screen
        $scene = Scene_Item.new
      when 1  # skill
        # If this actor's action limit is 2 or more
        if $game_party.actors[0].restriction >= 2
          # Play buzzer SE
          $game_system.se_play($data_system.buzzer_se)
          return
        end
        # Play decision SE
        $game_system.se_play($data_system.decision_se)
        # Switch to skill screen
        $scene = Scene_Skill.new(0)
      when 2  # equipment
        # Play decision SE
        $game_system.se_play($data_system.decision_se)
        # Switch to equipment screen
        $scene = Scene_Equip.new(0)
      when 3  # status
        # Play decision SE
        $game_system.se_play($data_system.decision_se)
        # Switch to status screen
        $scene = Scene_Status.new(0)
      when 4  # save
        # If saving is forbidden
        if $game_system.save_disabled
          # Play buzzer SE
          $game_system.se_play($data_system.buzzer_se)
          return
        end
        # Play decision SE
        $game_system.se_play($data_system.decision_se)
        # Switch to save screen
        $scene = Scene_Save.new
      when 5  # end game
        # Play decision SE
        $game_system.se_play($data_system.decision_se)
        # Switch to end game screen
        $scene = Scene_End.new
      end
      return
    end
  end
  
end

#==============================================================================
# ** Window_MenuStatus
#------------------------------------------------------------------------------
#  This window displays party member status on the menu screen.
#==============================================================================

class Window_MenuStatus < Window_Selectable
  
  def refresh
    self.contents.clear
    x = 24
    y = 0
    actor = $game_party.actors[0]
    draw_actor_portrait(actor)
    draw_actor_name(actor, x, y)
    draw_actor_class(actor, x + 144, y)
    draw_actor_level(actor, x, y + 32)
    draw_actor_state(actor, x + 90, y + 32)
    draw_actor_exp(actor, x, y + 64)
    draw_actor_hp(actor, x + 236, y + 32)
    draw_actor_sp(actor, x + 236, y + 64)
    y += 100
    draw_actor_parameter(actor, x, y, 0)
    draw_actor_parameter(actor, x, y + 24, 1)
    draw_actor_parameter(actor, x, y + 48, 2)
    draw_actor_parameter(actor, x, y + 72, 3)
    draw_actor_parameter(actor, x, y + 96, 4)
    draw_actor_parameter(actor, x, y + 120, 5)
    draw_actor_parameter(actor, x, y + 144, 6)
    
    y += 144
    draw_item_name($data_weapons[actor.weapon_id], x, y + 32)
    draw_item_name($data_armors[actor.armor1_id], x, y + 64)
    draw_item_name($data_armors[actor.armor2_id], x, y + 96)
    draw_item_name($data_armors[actor.armor3_id], x, y + 128)
    draw_item_name($data_armors[actor.armor4_id], x, y + 160)
  end
  
  def draw_actor_portrait(actor)
    if File.exists?("Graphics\\Pictures\\" + actor.character_name + ".png")
      bitmap = RPG::Cache.picture(actor.character_name)
      cw = bitmap.width
      ch = bitmap.height
      src_rect = Rect.new(0, 0, cw, ch)
      self.contents.blt(
        self.width - cw - 32 + WP_ONEPERSON_OFFSET_X, 
        self.height - ch - 32 + WP_ONEPERSON_OFFSET_Y, 
        bitmap, 
        src_rect)
    end
  end
end