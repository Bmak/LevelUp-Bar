package control 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import utils.TextButton;
	/**
	 * Main Control
	 * @author ProBigi
	 */
	public class AppControl 
	{
		public static var STAGE_W:int;
		public static var STAGE_H:int;
		public static var STAGE:Stage;
		
		private var _mainView:Sprite;
		
		private var _addExpBtn:TextButton;
		private var _levelBar:LevelBar;
		
		private var _data:XML;
		private const PATH:String = "../lib/config.xml";
		
		public function AppControl(view:Sprite) 
		{
			_mainView = view;
			STAGE = _mainView.stage;
			STAGE_W = view.stage.stageWidth;
			STAGE_H = view.stage.stageHeight;
			
			onLoadConfig();
		}
		
		//Загрузка конфига
		private function onLoadConfig():void {
			var configReq:URLRequest = new URLRequest(PATH);
			var configLoader:URLLoader = new URLLoader(configReq);
			
			configLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
			configLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		//Проверка на ошибки
		private function onSecError(e:SecurityErrorEvent):void 
		{
			throw new SecurityError("[LOAD XML] Ошибка безопасности " + e.type);
		}
		private function onIOError(event:IOErrorEvent):void {
			throw new IOError("[LOAD XML] Ошибка ввода/вывода");
		}
		
		//Загрузка завершена
		private function xmlLoaded(event:Event):void { 
			var configLoader:URLLoader = event.currentTarget as URLLoader;
			configLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
			configLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
			configLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			_data = new XML(configLoader.data);
			
			initButtons();
			initLevelBar(_data);
		}
		
		//Инициализация интерфейса
		private function initButtons():void 
		{
			_addExpBtn = new TextButton("+" + _data.up);
			_addExpBtn.x = (_mainView.stage.stageWidth - _addExpBtn.width) / 2;
			_addExpBtn.y = _mainView.stage.stageHeight / 2;
			
			_addExpBtn.addEventListener(MouseEvent.CLICK, onAddExp);
			
			_mainView.addChild(_addExpBtn);
		}
		
		private function initLevelBar(data:XML):void {
			_levelBar = new LevelBar(data);
			_levelBar.x = (_mainView.stage.stageWidth - _levelBar.width) / 2;
			_levelBar.y = _mainView.stage.stageHeight / 4;
			_mainView.addChild(_levelBar);
		}
		
		private function onAddExp(e:MouseEvent):void 
		{
			_levelBar.updateExp(_data.up);
		}
		
	}

}