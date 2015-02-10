package utils 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * Компонент кнопки с текстом
	 * @author Bigmac
	 */
	public class TextButton extends Sprite
	{
		private var _btn:TapBtn;
		private var _tf:TextField;
		
		public function TextButton(txt:String) 
		{
			_btn = new TapBtn;
			
			_tf = new TextField();
			_tf.mouseEnabled = false;
			_tf.autoSize = TextFieldAutoSize.CENTER;
			_tf.selectable = false;
			var format:TextFormat = new TextFormat;
			format.size = 40;
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			_tf.defaultTextFormat = format;
			_tf.text = txt;
			_tf.x = _btn.x + (_btn.width - _tf.textWidth)/2;
			_tf.y = _btn.y + (_btn.height - _tf.textHeight) / 2;
			
			this.addChild(_btn);
			this.addChild(_tf);
			this.buttonMode = true;
		}
		
	}

}