package view
{
	import flash.events.TimerEvent;
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import flashx.textLayout.conversion.ITextImporter;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.Configuration;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.LineBreak;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.operations.ApplyFormatOperation;
	import flashx.textLayout.operations.CompositeOperation;
	
	import spark.components.TextArea;
	import spark.components.TextSelectionHighlighting;
	import spark.events.TextOperationEvent;
	
	[Bindable]
	public class HightLightTextArea extends TextArea
	{
		private static const TEXT_LAYOUT_NAMESPACE:String = "http://ns.adobe.com/textLayout/2008";
		
		public var accessModifiers:Array = ["public", "private", "protected", "internal", ":", "Application", "s", "mx", "fx", "Script", "ic"];
		
		public var classMethodVariableModifiers:Array = ["class", "const", "extends", "final", "function", "get", "dynamic", "implements", "interface", "native", "new", "set", "static"]; 
		
		public var flowControl:Array = ["break", "case", "continue", "default", "do", "else", "for", "for\\seach", "if", "is", "label", "typeof", "return", "switch", "while", "in"];
		
		public var errorHandling:Array = ["catch", "finally", "throw", "try"];
		
		public var packageControl:Array = ["import", "package"];
		
		public var variableKeywords:Array = ["super", "this", "var"];
		
		public var returnTypeKeyword:Array = ["void"];
		
		public var namespaces:Array = ["default xml namespace", "namespace", "use namespace"];
		
		public var literals:Array = ["null", "true", "false"];
		
		public var primitives:Array = ["Boolean", "int", "Number", "String", "uint"];
		
		public var strings:Array = ['".*?"', "'.*?'"];
		
		public var comments:Array = ["//.*$", "/\\\*[.\\w\\s]*\\\*/", "/\\\*([^*]|[\\r\\n]|(\\\*+([^*/]|[\\r\\n])))*\\\*/"];
		
		public var defaultStyleSheet:String = ".text{color:#000000;font-family: 黑体; font-size: 16} .default{color:#0839ff;} .var{color:#0000ff;} .function{color:#55a97f;font-style:italic;} .strings{color:#f82929;} .comment{color:#0e9e0f;font-style:italic;} .asDocComment{color:#5d78c9;}";
		
		protected var _syntaxStyleSheet:String;
		
		protected var syntax:RegExp;
		
		protected var styleSheet:StyleSheet = new StyleSheet();
		
		protected var importer:ITextImporter;
		 
		
		protected var formats:Dictionary;
		
		public function HightLightTextArea()
		{
			super();
			
			styleSheet.parseCSS(defaultStyleSheet);
			initTokenTypeFormats();
			initTextFlow();
			
			initSyntaxRegExp();
			
			selectable = true;
			selectionHighlighting = TextSelectionHighlighting.ALWAYS;
			setStyle("lineBreak", LineBreak.EXPLICIT);
			
			addEventListener("textChanged", 
				function(event:Event):void 
				{ 
					colorize();
				}); 
		}
		
		protected function initTextFlow():void 
		{
			var config:Configuration = new Configuration();
			config.manageTabKey = true;
			
			config.textFlowInitialFormat = formats.text;
			textFlow = new TextFlow(config);
		}

		protected function initTokenTypeFormats():void
		{
			formats  = new Dictionary();
			
			function getTokenTypeFormat(tokenType:String):TextLayoutFormat
			{
				var tokenStyleName:String = "." + tokenType;
				var tokenStyle:Object = 
					styleSheet.styleNames.indexOf(tokenStyleName) > -1
					?
					styleSheet.getStyle(tokenStyleName)
					:
					styleSheet.getStyle(".default");
				
				var result:TextLayoutFormat = new TextLayoutFormat();
				result.color = tokenStyle.color;
				result.fontFamily = tokenStyle.fontFamily;
				result.fontStyle = tokenStyle.fontStyle;
				result.fontWeight = tokenStyle.fontWeight;
				result.fontSize = tokenStyle.fontSize;
				
				return result;
			}
			
			formats["text"] = getTokenTypeFormat("text");
			formats["var"] = getTokenTypeFormat("var");
			formats["function"] = getTokenTypeFormat("function");
			formats["strings"] = getTokenTypeFormat("strings");
			formats["asDocComment"] = getTokenTypeFormat("asDocComment");
			formats["comment"] = getTokenTypeFormat("comment");
			formats["accessModifiers"] = getTokenTypeFormat("accessModifiers");
			formats["classMethodVariableModifiers"] = 
				getTokenTypeFormat("classMethodVariableModifiers");
			formats["flowControl"] = getTokenTypeFormat("flowControl");
			formats["errorHandling"] = getTokenTypeFormat("errorHandling");
			formats["packageControl"] = getTokenTypeFormat("packageControl");
			formats["variableKeywords"] = getTokenTypeFormat("variableKeywords");
			formats["returnTypeKeyword"] = getTokenTypeFormat("returnTypeKeyword");
			formats["namespaces"] = getTokenTypeFormat("namespaces");
			formats["literals"] = getTokenTypeFormat("literals");
			formats["primitives"] = getTokenTypeFormat("primitives");
		}
		
		protected function initSyntaxRegExp():void 
		{
			var pattern:String = "";
			
			for each(var str:String in strings.concat(comments))
			{
				pattern += str + "|";
			}
			
			var createRegExp:Function = function(keywords:Array):String
			{
				var result:String = "";
				for each(var keyword:String in keywords)
				{
					result += (result != "" ? "|" : "") + "\\b" + keyword + "\\b";
				}
				return result;
			};
			
			pattern += createRegExp(accessModifiers)
				+ "|" 
				+ createRegExp(classMethodVariableModifiers)
				+ "|"
				+ createRegExp(flowControl)
				+ "|"
				+ createRegExp(errorHandling)
				+ "|"
				+ createRegExp(packageControl)
				+ "|"
				+ createRegExp(variableKeywords)
				+ "|"
				+ createRegExp(returnTypeKeyword)
				+ "|"
				+ createRegExp(namespaces)
				+ "|"
				+ createRegExp(literals)
				+ "|"
				+ createRegExp(primitives);
			
			this.syntax = new RegExp(pattern, "gm");
		}
		
		protected function colorize():void
		{
			var stime:Number = new Date().time;
			// Creating new CompositeOperation
			var compositeOperation:CompositeOperation = new CompositeOperation();
			
			// Reseting whole text to the default TextLayoutFormat
			var operationState:SelectionState = new SelectionState(textFlow, 0, text.length);
			var formatOperation:ApplyFormatOperation = 
				new ApplyFormatOperation(operationState, formats.text, null);
			compositeOperation.addOperation(formatOperation);
			
			// Executing RegExp for the first token			
			var token:* = syntax.exec(this.text);
			while(token)
			{
				// Getting token value
				var tokenValue:String = token[0];
				// Detecting token type
				var tokenType:String = getTokenType(tokenValue);
				// Getting TextLayoutFormat for current token type
				var format:TextLayoutFormat = formats[tokenType]; 
				
				// Creating new SelectionState for at the location of current token
				operationState = new SelectionState(textFlow,
					token.index, token.index + tokenValue.length);
				
				// Creating new ApplyFormatOperation for current token
				formatOperation = new ApplyFormatOperation(operationState, 
					format, null);
				
				// Adding ApplyFormatOperation to CompositeOperation
				compositeOperation.addOperation(formatOperation);
				
				// Incrementing RegExp syntax lastIndex after the current token
				syntax.lastIndex = token.index + tokenValue.length;
				
				// Executing RegExp for the next token
				token = syntax.exec(this.text);
			}
			
			// Executing batch of ApplyFormatOperation's			
			var success:Boolean = compositeOperation.doOperation();
//			if (success)
//				textFlow.flowComposer.updateAllControllers();
			 
		}
		
		protected function getTokenType(tokenValue:String):String
		{
			var result:String;
			if (tokenValue == "var")
			{
				return "var";
			}
			else if (tokenValue == "function")
			{
				return "function";
			}
			else if (tokenValue.indexOf("\"") == 0 || tokenValue.indexOf("'") == 0)
			{
				return "strings";
			}
			else if (tokenValue.indexOf("/**") == 0)
			{
				return "asDocComment";
			}
			else if (tokenValue.indexOf("//") == 0 || tokenValue.indexOf("/*") == 0)
			{
				return "comment";
			}
			else if (accessModifiers.indexOf(tokenValue) > -1)
			{
				return "accessModifiers";
			}
			else if (classMethodVariableModifiers.indexOf(tokenValue) > -1)
			{
				return "classMethodVariableModifiers";
			}
			else if (flowControl.indexOf(tokenValue) > -1)
			{
				return "flowControl";
			}
			else if (errorHandling.indexOf(tokenValue) > -1)
			{
				return "errorHandling";
			}
			else if (packageControl.indexOf(tokenValue) > -1)
			{
				return "packageControl";
			}
			else if (variableKeywords.indexOf(tokenValue) > -1)
			{
				return "variableKeywords";
			}
			else if (returnTypeKeyword.indexOf(tokenValue) > -1)
			{
				return "returnTypeKeyword";
			}
			else if (namespaces.indexOf(tokenValue) > -1)
			{
				return "namespaces";
			}
			else if (literals.indexOf(tokenValue) > -1)
			{
				return "literals";
			}
			else if (primitives.indexOf(tokenValue) > -1)
			{
				return "primitives";
			}
			return result;
		}
		
		public function get syntaxStyleSheet():String
		{
			return _syntaxStyleSheet;
		}
		
		public function set syntaxStyleSheet(value:String):void
		{
			_syntaxStyleSheet = value;
			
			styleSheet.clear();
			if (_syntaxStyleSheet)
				styleSheet.parseCSS(_syntaxStyleSheet);
			else
				styleSheet.parseCSS(defaultStyleSheet);
			
			var currentText:String = text;
			
			initTokenTypeFormats();
			initTextFlow();
			
			text = currentText;
		}
	}
}