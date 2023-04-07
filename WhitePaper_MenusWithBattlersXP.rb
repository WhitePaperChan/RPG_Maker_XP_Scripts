# =============================================================================
# WhitePaper_MenusWithBattlersXP
# =============================================================================
# Замінює усю графіку персонаж_ок у вікнах на бойову графіку.
# 
# Технічні подробиці:
# Цей скрипт змінює метод draw_actor_graphic класу Window_Base.
#
# Цей скрипт розповсюджується за ліцензією MIT-0 (MIT No Attribution License)
# MIT No Attribution
#
# Copyright 2022-2023 WhitePaperChan
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
# Стандартний зсув графіки у пікселях
# =============================================================================
DEFAULT_RECT_X = 30
DEFAULT_RECT_Y = 0
# =============================================================================
# Зсув графіки з певною назвою файлу графіки
# =============================================================================
CUSTOM_RECT = {
  "004-Fighter04" => [75, 0],
  "006-Fighter06" => [75, 0],
  "009-Lancer01" => [75, 0],
  "010-Lancer02" => [0, 30],
  "011-Lancer03" => [30, 20],
  "012-Lancer04" => [75, 0],
  "013-Warrior01" => [40, 0],
  "014-Warrior02" => [40, 30],
  "020-Hunter01" => [10, 0],
  "022-Hunter03" => [10, 0],
  "023-Gunner01" => [40, 20],
  "024-Gunner02" => [10, 0],
  "026-Cleric02" => [20, 0],
  "027-Cleric03" => [40, 0],
  "028-Cleric04" => [50, 0],
  "029-Cleric05" => [10, 0],
  "033-Mage01" => [10, 0],
  "034-Mage02" => [50, 0],
  "036-Mage04" => [50, 0],
  "037-Mage05" => [40, 0],
  "039-Mage07" => [50, 0],
  "042-King01" => [55, 0],
  "043-Queen01" => [20, 0],
  "046-Grappler01" => [20, 0],
  "047-Grappler02" => [10, 0],
  "048-Fairy01" => [0, 40],
  "049-Soldier01" => [20, 0],
  "050-Soldier02" => [90, 0],
  "051-Undead01" => [0, 0],
  "053-Undead03" => [60, 0],
  "054-Undead04" => [190, 0],
  "055-Snake01" => [20, 30],
  "056-Snake02" => [10, 0],
  "057-Snake03" => [50, 30],
  "058-Snake04" => [350, 0],
  "059-Aquatic01" => [20, 0],
  "060-Aquatic02" => [10, 0],
  "061-Aquatic03" => [60, 80],
  "062-Aquatic04" => [50, 60],
  "063-Beast01" => [20, 30],
  "065-Beast03" => [0, 10],
  "066-Beast04" => [80, 140],
  "067-Goblin01" => [10, 0],
  "068-Goblin02" => [30, 10],
  "070-Goblin04" => [190, 0],
  "072-Bird02" => [30, 30],
  "073-Bird03" => [200, 160],
  "074-Bird04" => [120, 70],
  "075-Devil01" => [10, 0],
  "076-Devil02" => [40, 10],
  "077-Devil03" => [140, 60],
  "078-Devil04" => [190, 0],
  "079-Angel01" => [15, 0],
  "080-Angel02" => [20, 0],
  "081-Angel03" => [110, 0],
  "082-Angel04" => [170, 20],
  "084-Elemental02" => [25, 0],
  "085-Elemental03" => [40, 0],
  "086-Elemental04" => [60, 0],
  "087-Monster01" => [25, 10],
  "088-Monster02" => [10, 30],
  "089-Monster03" => [10, 0],
  "090-Monster04" => [10, 0],
  "091-Monster05" => [40, 100],
  "092-Monster06" => [50, 0],
  "093-Monster07" => [10, 0],
  "094-Monster08" => [10, 0],
  "095-Monster09" => [50, 60],
  "096-Monster10" => [10, 160],
  "097-Monster11" => [80, 0],
  "098-Monster12" => [140, 60],
  "099-Monster13" => [230, 40],
  "100-Monster14" => [205, 60]
}
# =============================================================================
# Кінець налаштувань
# =============================================================================
class Window_Base < Window
  
  def draw_actor_graphic(actor, x, y)
    bitmap = RPG::Cache.battler(actor.battler_name, actor.battler_hue)
    cw = bitmap.width
    ch = bitmap.height
    if CUSTOM_RECT.key?(actor.battler_name)
      rect_x = CUSTOM_RECT[actor.battler_name][0]
      rect_y = CUSTOM_RECT[actor.battler_name][1]
    else
      rect_x = DEFAULT_RECT_X
      rect_y = DEFAULT_RECT_Y
    end
    src_rect = Rect.new(rect_x, rect_y, 64, 96)
    self.contents.blt(x - 24, y - 80, bitmap, src_rect)
  end
  
end
