#==============================================================================
# WhitePaper_DetailedEquipMenuXP
#==============================================================================
# Додає на екран спорядження зміну параметрів:
# * STR - сила,
# * DEX - меткість,
# * AGI - спритність,
# * INT - розум.
# Також цей скрипт додає графіку персонаж_ки та виділення позитивних та 
# негативних змін характеристик.
# 
# Технічні подробиці:
# Цей скрипт змінює класи Window_EquipLeft, Window_EquipItem і Scene_Equip
#
# Цей скрипт розповсюджується за ліцензією MIT-0 (MIT No Attribution License)
#==============================================================================

#==============================================================================
# ** Window_EquipLeft
#------------------------------------------------------------------------------
#  This window displays actor parameter changes on the equipment screen.
#==============================================================================

class Window_EquipLeft < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     actor : actor
  #--------------------------------------------------------------------------
  def initialize(actor)
    super(0, 64, 272, 416)
    self.contents = Bitmap.new(width - 32, height - 32)
    @actor = actor
    refresh
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    draw_actor_name(@actor, 4, 0)
    draw_actor_level(@actor, 4, 32)
    draw_actor_graphic(@actor, 32, 146)
    for i in 0..6 do
      draw_actor_parameter(@actor, 4, 164 + 32 * i, i)
    end
    
    actor_stats = [
      @actor.atk, 
      @actor.pdef, 
      @actor.mdef, 
      @actor.str, 
      @actor.dex,
      @actor.agi,
      @actor.int
    ]
    
    for i in 0..6 do
      if @new_stats != nil and @new_stats[i] != nil
          self.contents.font.color = system_color
        self.contents.font.color = system_color
        self.contents.draw_text(160, 164 + 32 * i, 40, 32, "->", 1)
        if @new_stats[i] == actor_stats[i]
          self.contents.font.color = normal_color
        elsif @new_stats[i] > actor_stats[i]
          self.contents.font.color = Color.new(0,255,0,255)
        else
          self.contents.font.color = Color.new(255,0,0,255)
        end
        self.contents.draw_text(200, 164 + 32 * i, 36, 32, @new_stats[i].to_s, 2)
      end
    end

  end
  #--------------------------------------------------------------------------
  # * Set parameters after changing equipment
  #     new_atk  : attack power after changing equipment
  #     new_pdef : physical defense after changing equipment
  #     new_mdef : magic defense after changing equipment
  #--------------------------------------------------------------------------
  def set_new_parameters(new_atk, new_pdef, new_mdef, new_str, new_dex, 
    new_agi, new_int)
    
    @new_stats = [
      new_atk, 
      new_pdef, 
      new_mdef, 
      new_str, 
      new_dex, 
      new_agi,
      new_int
    ]
    refresh
  end
end
#==============================================================================
# ** Window_EquipItem
#------------------------------------------------------------------------------
#  This window displays choices when opting to change equipment on the
#  equipment screen.
#==============================================================================
class Window_EquipItem < Window_Selectable
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     actor      : actor
  #     equip_type : equip region (0-3)
  #--------------------------------------------------------------------------
  def initialize(actor, equip_type)
    super(272, 256, 368, 224)
    @actor = actor
    @equip_type = equip_type
    @column_max = 1
    refresh
    self.active = false
    self.index = -1
  end
end
#==============================================================================
# ** Scene_Equip
#------------------------------------------------------------------------------
#  This class performs equipment screen processing.
#==============================================================================
  def refresh
    # Set item window to visible
    @item_window1.visible = (@right_window.index == 0)
    @item_window2.visible = (@right_window.index == 1)
    @item_window3.visible = (@right_window.index == 2)
    @item_window4.visible = (@right_window.index == 3)
    @item_window5.visible = (@right_window.index == 4)
    # Get currently equipped item
    item1 = @right_window.item
    # Set current item window to @item_window
    case @right_window.index
    when 0
      @item_window = @item_window1
    when 1
      @item_window = @item_window2
    when 2
      @item_window = @item_window3
    when 3
      @item_window = @item_window4
    when 4
      @item_window = @item_window5
    end
    # If right window is active
    if @right_window.active
      # Erase parameters for after equipment change
      @left_window.set_new_parameters(nil, nil, nil, nil, nil, nil, nil)
    end
    # If item window is active
    if @item_window.active
      # Get currently selected item
      item2 = @item_window.item
      # Change equipment
      last_hp = @actor.hp
      last_sp = @actor.sp
      @actor.equip(@right_window.index, item2 == nil ? 0 : item2.id)
      # Get parameters for after equipment change
      new_atk = @actor.atk
      new_pdef = @actor.pdef
      new_mdef = @actor.mdef
      new_str = @actor.str
      new_dex = @actor.dex
      new_agi = @actor.agi
      new_int = @actor.int
      # Return equipment
      @actor.equip(@right_window.index, item1 == nil ? 0 : item1.id)
      @actor.hp = last_hp
      @actor.sp = last_sp
      # Draw in left window
      @left_window.set_new_parameters(new_atk, new_pdef, new_mdef, new_str, 
      new_dex, new_agi, new_int)
    end
  end
