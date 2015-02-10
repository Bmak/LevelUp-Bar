package control 
{
	import aze.motion.eaze;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import window.LevelUpWindow;
	/**
	 * Level Bar
	 * @author ProBigi
	 */
	public class LevelBar extends Sprite
	{
		private var _data:XML;
		
		private var _levels:Vector.<int>;
		
		private var _panelBar:PanelBar;
		private var _bar:Bar;
		private var _star:LevelStar;
		private var _starTF:TextField;
		private var _currentLevel:int;
		private var _expTF:TextField;
		private var _currentExp:int;
		private var _diffExp:Number;
		
		public function LevelBar(data:XML) 
		{
			_data = data;
			_currentExp = _data.currentExp;
			_currentLevel = _data.currentLevel;
			_levels = new Vector.<int>;
			var list:XMLList = _data.levels.level;
			for each (var level:XML in list) {
				_levels.push(level);
			}
			
			_panelBar = new PanelBar;
			_bar = new Bar;
			_bar.x = (_panelBar.width - _bar.width) / 2;
			_bar.y = (_panelBar.height - _bar.height) / 2;
			this.addChild(_bar);
			this.addChild(_panelBar);
			
			_expTF = new TextField;
			_expTF.autoSize = TextFieldAutoSize.CENTER;
			var format:TextFormat = new TextFormat;
			format.size = 20;
			format.align = TextFormatAlign.CENTER;
			_expTF.defaultTextFormat = format;
			_expTF.x = _panelBar.width/2;
			_expTF.y = _panelBar.height;
			this.addChild(_expTF);
			
			_bar.scaleX = 0;
			_expTF.text = "опыт: " + _currentExp.toString();
			
			_star = new LevelStar;
			_star.x = _panelBar.width + 10;
			_star.y = (_panelBar.height - _star.height) / 2;
			this.addChild(_star);
			
			_starTF = new TextField;
			_starTF.autoSize = TextFieldAutoSize.CENTER;
			format = new TextFormat;
			format.size = 30;
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			_starTF.defaultTextFormat = format;
			
			setNewLevel(_currentLevel);
			this.addChild(_starTF);
		}
		
		//Обновление бара
		public function updateExp(exp:int):void {
			if (_currentLevel >= _levels.length) { return; }
			
			_currentExp += exp;
			_expTF.text = "опыт: " + _currentExp.toString();
			
			if (_currentLevel == 0) {
				_diffExp = _currentExp / _levels[_currentLevel];
			} else {
				_diffExp = (_currentExp - _levels[_currentLevel - 1]) / (_levels[_currentLevel] - _levels[_currentLevel-1]);
			}
			if (_diffExp > 1) {
				_diffExp = 1;
			}
			
			if (_currentExp >= _levels[_currentLevel]) {
				setNewLevel(_currentLevel + 1);
			}
			eaze(_bar).to(0.3, { scaleX: _diffExp } ).onComplete(endBarTween);
		}
		
		private function endBarTween():void {
			if (_bar.scaleX == 1) { _bar.scaleX = 0; }
		}
		
		//Новый уровень
		private function setNewLevel(level:int):void {
			if (_currentLevel < level) {
				_currentLevel = level;
				
				LevelUpWindow.inst.show(level+1);
			}
			_starTF.text = (level+1).toString();
			_starTF.x = _star.x + (_star.width - _starTF.textWidth)/2-1;
			_starTF.y = _star.y + (_star.height - _starTF.textHeight) / 2 - 2;
		}
	}

}