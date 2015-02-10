package window 
{
	import aze.motion.easing.Linear;
	import aze.motion.eaze;
	import control.AppControl;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import utils.TextButton;
	/**
	 * Level Up Window
	 * @author ProBigi
	 */
	public class LevelUpWindow
	{
		/*
		 * Подобные модальные окна можно оптимизировать, путем создания контроллера
		 * этих окон и объединением общих элементов (фон, кнопки и т.д.)
		*/
		private static var _inst:LevelUpWindow;
		
		private var _bkg:Sprite;
		private var _box:Sprite;
		private var _panel:Sprite;
		private var _tf:TextField;
		private var _closeBtn:CloseBtn;
		private var _okBtn:TextButton;
		
		public function LevelUpWindow() {
			_bkg = new Sprite;
			_bkg.graphics.beginFill(0x000000, 0.7);
			_bkg.graphics.drawRect(0, 0, AppControl.STAGE_W, AppControl.STAGE_H);
			_bkg.graphics.endFill();
			
			_box = new Sprite;
			_panel = new Sprite;
			_panel.graphics.lineStyle(3, 0xFF0000);
			_panel.graphics.beginFill(0xFFFFFF);
			_panel.graphics.drawRoundRect(0, 0, 400, 300, 10, 10);
			_panel.graphics.endFill();
			_box.addChild(_panel);
			
			_tf = new TextField;
			_tf.mouseEnabled = false;
			_tf.autoSize = TextFieldAutoSize.CENTER;
			_tf.selectable = false;
			var format:TextFormat = new TextFormat;
			format.size = 30;
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			_tf.defaultTextFormat = format;
			_box.addChild(_tf);
			
			_closeBtn = new CloseBtn();
			_closeBtn.buttonMode = true;
			_closeBtn.x = _panel.width - _closeBtn.width / 2;
			_closeBtn.y = -_closeBtn.height / 2;
			_box.addChild(_closeBtn);
			
			_okBtn = new TextButton("OK");
			_okBtn.x = (_panel.width - _okBtn.width) / 2;
			_okBtn.y = _panel.height - _okBtn.height - 10;
			_box.addChild(_okBtn);
			
			_closeBtn.addEventListener(MouseEvent.CLICK, onClick);
			_okBtn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			hide();
		}
		
		public static function get inst():LevelUpWindow {
			if (_inst == null) { _inst = new LevelUpWindow(); }
			return _inst;
		}
		
		public function show(level:int):void {
			AppControl.STAGE.addChild(_bkg);
			AppControl.STAGE.addChild(_box);
			
			_tf.text = "УРА!\nВы достигли уровня " + level;
			_tf.x = (_panel.width - _tf.width)/2;
			_tf.y = (_panel.height - _tf.height)/2;
			
			_box.x = (AppControl.STAGE.stageWidth - _panel.width) / 2;
			_box.y = (AppControl.STAGE.stageHeight - _panel.height) / 2;
			
			var gotoY:int = _box.y;
			_box.y = _box.y - 50;
			_box.alpha = 0;
			eaze(_box).to(0.5, { y:gotoY, alpha:1 } );
		}
		
		public function hide():void {
			var gotoY:int = _box.y - 50;
			eaze(_box).to(0.5, { y:gotoY, alpha:0 } ).onComplete(destroy);
		}
		
		private function destroy():void {
			AppControl.STAGE.removeChild(_bkg);
			AppControl.STAGE.removeChild(_box);
		}
	}

}