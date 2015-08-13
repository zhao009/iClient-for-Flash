package flexiframe
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.geom.*;
    import flash.utils.*;
    
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.logging.*;
    import mx.logging.targets.*;
    import mx.managers.*;
    import mx.utils.*;
    
    public class IFrame extends Container
    {
        protected var randomIdentificationString:Number;
        protected var overlapCount:int = 0;
        protected var overlappingDict:Dictionary;
        protected var _frameLoaded:Boolean = false;
        public    var overlayDetection:Boolean = false;
        protected var _validForDisplay:Boolean = true;
        protected var logger:ILogger;
        protected var _functionQueue:Array;
        protected var _frameId:String;
        protected var settingDict:Object = null;
        public    var loadIndicatorClass:Class;
        protected var _content:String;
        protected var _iframeId:String;
        protected var _source:String;
        protected var _loadIndicator:UIComponent;
        protected var containerDict:Object = null;
        protected var _debug:Boolean = false;
        protected var _browserScaling:Number = 1;
        protected var explicitVisibleValue:Boolean = true;
        protected var logTarget:TraceTarget;
        protected var _iframeContentHost:String;
        public static var idList:Object = new Object();
        public static var _appHost:String;
        public static var applicationId:String = null;

        public function IFrame(param1:String = null)
        {
            _functionQueue = [];
            overlappingDict = new Dictionary(true);
            logger = Log.getLogger("Flex-IFrame");
            if (param1 != null)
            {
                this.id = param1;
            }
            this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemove);
            this.addEventListener(Event.ADDED_TO_STAGE, handleAdd);
            return;
        }// end function

        protected function loadIFrame() : void
        {
            logger.info("Loading IFrame with id \'{0}\', on SWF embed object with id \'{1}\'.", _frameId, applicationId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_LOADIFRAME, _frameId, _iframeId, source, applicationId);
            return;
        }// end function

        protected function overlay_hideShowHandler(event:FlexEvent) : void
        {
            var _loc_2:* = event.target as DisplayObject;
            if (event.type == FlexEvent.SHOW && !overlappingDict[_loc_2])
            {
                logger.debug("iframe {0} heard SHOW for {1}", _frameId, _loc_2.toString());
                overlappingDict[_loc_2] = _loc_2;
                var _loc_4:* = overlapCount + 1;
                overlapCount = _loc_4;
                updateFrameVisibility(false);
            }
            else if (event.type == FlexEvent.HIDE && overlappingDict[_loc_2])
            {
                logger.debug("iframe {0} heard HIDE for {1}", _frameId, _loc_2.toString());
                delete overlappingDict[_loc_2];
                if (--overlapCount == 0)
                {
                    updateFrameVisibility(true);
                }
            }
            return;
        }// end function

        public function printIFrame() : void
        {
            logger.info("Print the iFrame with id \'{0}\'.", _iframeId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_PRINT_IFRAME, _iframeId);
            return;
        }// end function

        public function historyForward() : void
        {
            logger.info("History forward for the iFrame with id \'{0}\'.", _iframeId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_HISTORY_FORWARD, _iframeId);
            return;
        }// end function

        protected function handleMove(event:Event) : void
        {
            invalidateDisplayList();
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_2:String = null;
            super.createChildren();
            if (!ExternalInterface.available)
            {
                throw new Error("ExternalInterface is not available in this container. Internet " + "Explorer ActiveX, Firefox, Mozilla 1.7.5 and greater, or other " + "browsers that support NPRuntime are required.");
            }
            if (!_appHost)
            {
                //_loc_2 = Application.application.url;
				_loc_2 = FlexGlobals.topLevelApplication.url;
                if (_loc_2)
                {
                    _appHost = URLUtil.getProtocol(_loc_2) + "://" + URLUtil.getServerNameWithPort(_loc_2);
                }
                else
                {
                    _appHost = "unknown";
                }
            }
            var _loc_1:int = 0;
            while (idList[id + _loc_1])
            {
                
                _loc_1++;
            }
            _frameId = id + _loc_1;
            _iframeId = "iframe_" + _frameId;
            idList[_frameId] = true;
            setupExternalInterface();
            createIFrame();
            buildContainerList();
            adjustPosition(true);
            if (loadIndicatorClass)
            {
                logger.info("A load indicator class was specified: {0}", getQualifiedClassName(loadIndicatorClass));
                _loadIndicator = UIComponent(new loadIndicatorClass());
                addChild(_loadIndicator);
            }
            else
            {
                logger.info("No load indicator class specified.");
            }
            return;
        }// end function

        protected function isAncestor(param1:DisplayObject) : Boolean
        {
            var _loc_2:Object = null;
            for (_loc_2 in containerDict)
            {
                
                if (param1 == _loc_2)
                {
                    return true;
                }
            }
            return false;
        }// end function

        protected function createIFrame() : void
        {
            logger.info("Creating IFrame with id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_CREATEIFRAME, _frameId);
            return;
        }// end function

        protected function checkDisplay(param1:Object, param2:Number) : Boolean
        {
            var _loc_4:DisplayObjectContainer = null;
            var _loc_5:Object = null;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_3:Boolean = false;
            if (param1 is Container)
            {
                _loc_4 = DisplayObjectContainer(param1);
                settingDict[_loc_4] = param2;
                _loc_3 = true;
                for (_loc_5 in containerDict)
                {
                    
                    _loc_6 = lookupIndex(_loc_5 as Container);
                    _loc_7 = lookupSetting(_loc_5 as Container);
                    _loc_3 = _loc_3 && _loc_6 == _loc_7;
                }
            }
            _validForDisplay = _loc_3;
            return _loc_3;
        }// end function

        public function get source() : String
        {
            return _source;
        }// end function

        protected function resolveEmbedObjectId() : void
        {
            var result:Object;
            if (applicationId == null)
            {
                try
                {
                    randomIdentificationString = Math.ceil(Math.random() * 9999 * 1000);
                    ExternalInterface.addCallback("checkObjectId", checkObjectId);
                    result = ExternalInterface.call(IFrameExternalCalls.FUNCTION_ASK_FOR_EMBED_OBJECT_ID, randomIdentificationString.toString());
                    if (result != null)
                    {
                        applicationId = String(result);
                        logger.info("Resolved the SWF embed object id to \'{0}\'.", applicationId);
                    }
                    else
                    {
                        logger.error("Could not resolve the SWF embed object Id.");
                    }
                }
                catch (error:Error)
                {
                    logger.error(error.errorID + ": " + error.name + " - " + error.message);
                }
            }
            return;
        }// end function

        protected function checkOverlay(param1:DisplayObject) : void
        {
            if (this.hitTestStageObject(param1) && !isAncestor(param1))
            {
                if (param1.visible)
                {
                    if (!overlappingDict[param1])
                    {
                        logger.debug("iframe {0} detected overlap of {1}", _frameId, param1.toString());
                        overlappingDict[param1] = param1;
                        var _loc_3:* = overlapCount + 1;
                        overlapCount = _loc_3;
                    }
                    updateFrameVisibility(false);
                }
                if (param1 is UIComponent)
                {
                    UIComponent(param1).addEventListener(FlexEvent.HIDE, overlay_hideShowHandler, false, 0, true);
                    UIComponent(param1).addEventListener(FlexEvent.SHOW, overlay_hideShowHandler, false, 0, true);
                }
            }
            return;
        }// end function

        protected function handleFrameLoad() : void
        {
            var _loc_1:Object = null;
            logger.info("Browser reports frame with id {0} loaded.", _frameId);
            _frameLoaded = true;
            while (_functionQueue.length > 0)
            {
                
                _loc_1 = _functionQueue.pop();
                logger.debug("frame id {0} calling queued function {1}", _frameId, _loc_1.functionName);
                this.callIFrameFunction(_loc_1.functionName, _loc_1.args, _loc_1.callback);
            }
            dispatchEvent(new Event("frameLoad"));
            invalidateDisplayList();
            return;
        }// end function

        override public function setActualSize(param1:Number, param2:Number) : void
        {
            super.setActualSize(param1, param2);
            if (overlayDetection)
            {
                checkExistingPopUps();
            }
            return;
        }// end function

        protected function systemManager_removedHandler(event:Event) : void
        {
            var _loc_2:* = event.target as DisplayObject;
            if (_loc_2.parent == systemManager && overlappingDict[_loc_2])
            {
                logger.debug("iframe {0} heard REMOVE for {1}", _frameId, _loc_2.toString());
                delete overlappingDict[_loc_2];
                if (--overlapCount == 0)
                {
                    updateFrameVisibility(true);
                }
                if (_loc_2 is UIComponent)
                {
                    UIComponent(_loc_2).removeEventListener(FlexEvent.HIDE, overlay_hideShowHandler);
                    UIComponent(_loc_2).removeEventListener(FlexEvent.SHOW, overlay_hideShowHandler);
                }
            }
            return;
        }// end function

        protected function moveIFrame(param1:int, param2:int, param3:int, param4:int) : void
        {
            logger.info("Moving IFrame with id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_MOVEIFRAME, _frameId, _iframeId, param1, param2, param3, param4, applicationId);
            return;
        }// end function

        public function set source(param1:String) : void
        {
            if (param1)
            {
				if(param1 == _source)
				{ 
					return;
				}
                _source = param1;
                _frameLoaded = false;
                invalidateProperties();
                _iframeContentHost = URLUtil.getProtocol(param1) + "://" + URLUtil.getServerNameWithPort(param1);
            }
            return;
        }// end function

        public function removeIFrame() : void
        {
            logger.info("Removing IFrame with id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_REMOVEIFRAME, _frameId);
            return;
        }// end function

        protected function loadDivContent() : void
        {
            logger.info("Loading content on IFrame with id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_LOADDIV_CONTENT, _frameId, _iframeId, content);
            return;
        }// end function

        protected function setupExternalInterface() : void
        {
            logger.info("Inserting Javascript functions in the DOM.");
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_CREATEIFRAME);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_MOVEIFRAME);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_HIDEIFRAME);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_SHOWIFRAME);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_HIDEDIV);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_SHOWDIV);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_LOADIFRAME);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_LOADDIV_CONTENT);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_CALLIFRAMEFUNCTION);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_REMOVEIFRAME);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_GET_BROWSER_MEASURED_WIDTH);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_PRINT_IFRAME);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_HISTORY_BACK);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_HISTORY_FORWARD);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_ASK_FOR_EMBED_OBJECT_ID);
            resolveEmbedObjectId();
            ExternalInterface.addCallback(_frameId + "_load", handleFrameLoad);
            ExternalInterface.call(IFrameExternalCalls.INSERT_FUNCTION_SETUP_RESIZE_EVENT_LISTENER(_frameId));
            setupBrowserResizeEventListener();
            ExternalInterface.addCallback(_frameId + "_resize", function () : void
            {
                adjustPosition(true);
                return;
            }// end function
            );
            return;
        }// end function

        protected function setupBrowserResizeEventListener() : void
        {
            logger.info("Setup the Browser resize event listener.");
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_SETUP_RESIZE_EVENT_LISTENER);
            return;
        }// end function

        public function historyBack() : void
        {
            logger.info("History back for the iFrame with id \'{0}\'.", _iframeId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_HISTORY_BACK, _iframeId);
            return;
        }// end function

        protected function checkExistingPopUps() : void
        {
            var _loc_4:UIComponent = null;
            var _loc_1:* = systemManager;
            var _loc_2:* = _loc_1.rawChildren.numChildren;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1.rawChildren.getChildAt(_loc_3) as UIComponent;
                if (_loc_4 && _loc_4.isPopUp)
                {
                    checkOverlay(_loc_4);
                }
                _loc_3++;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (source)
            {
                if (!_frameLoaded)
                {
                    _frameLoaded = false;
                    loadIFrame();
                }
                else
                {
                    logger.debug("The IFrame with id \'{0}\' is already loaded.", _frameId);
                }
                invalidateDisplayList();
            }
            else if (content)
            {
                loadDivContent();
                invalidateDisplayList();
            }
            return;
        }// end function

        protected function systemManager_addedHandler(event:Event) : void
        {
            var _loc_2:* = event.target as DisplayObject;
            if (_loc_2.parent == systemManager && _loc_2.name != "cursorHolder" && !(_loc_2 is ToolTip))
            {
                this.callLater(checkOverlay, [_loc_2]);
            }
            return;
        }// end function

        protected function handleRemove(event:Event = null) : void
        {
            logger.debug("The component for the IFrame with id \'{0}\' has been removed from the stage.", _frameId);
            if (overlayDetection)
            {
                systemManager.removeEventListener(Event.ADDED, systemManager_addedHandler);
                systemManager.removeEventListener(Event.REMOVED, systemManager_removedHandler);
            }
            updateFrameVisibility(false);
            return;
        }// end function

        protected function getBrowserMeasuredWidth() : Number
        {
            logger.info("Get browser measured width.");
            var _loc_1:* = ExternalInterface.call(IFrameExternalCalls.FUNCTION_GET_BROWSER_MEASURED_WIDTH, applicationId);
            if (_loc_1 != null)
            {
                return new Number(_loc_1);
            }
            return new Number(0);
        }// end function

        protected function showDiv() : void
        {
            logger.info("Showing div id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_SHOWDIV, _frameId);
            return;
        }// end function

        protected function updateFrameVisibility(param1:Boolean) : Boolean
        {
            logger.debug("IFrame with id \'{0}\' visibility set to \'{1}\'", _frameId, param1);
            if (param1 && _validForDisplay && (!overlayDetection || overlapCount == 0) && explicitVisibleValue == true && (_frameLoaded || !_frameLoaded && loadIndicatorClass == null))
            {
                if (source && _iframeContentHost == _appHost)
                {
                    showIFrame();
                }
                else
                {
                    showDiv();
                }
                invalidateDisplayList();
                return true;
            }
            else
            {
                if (source && _iframeContentHost == _appHost)
                {
                    hideIFrame();
                }
                else
                {
                    hideDiv();
                }
                return false;
            }
        }// end function

        protected function adjustPosition(param1:Boolean = false) : void
        {
            var _loc_4:Number = NaN;
            var _loc_2:* = new Point(0, 0);
            var _loc_3:* = this.localToGlobal(_loc_2);
            if (param1)
            {
                _loc_4 = getBrowserMeasuredWidth();
                if (_loc_4 > 0)
                {
                    //_browserScaling = _loc_4 / Application.application.width;
					_browserScaling = _loc_4 / FlexGlobals.topLevelApplication.width;
                }
            }
            moveIFrame(Math.round(_loc_3.x * _browserScaling), Math.round(_loc_3.y * _browserScaling), Math.round(this.width * _browserScaling), Math.round(this.height * _browserScaling));
            return;
        }// end function

        protected function handleAdd(event:Event = null) : void
        {
            logger.debug("The component for the IFrame with id \'{0}\' has been added from the stage.", _frameId);
            if (overlayDetection)
            {
                logger.info("Listening to the stage component additions to detect overlapping objects.");
                systemManager.addEventListener(Event.ADDED, systemManager_addedHandler);
                systemManager.addEventListener(Event.REMOVED, systemManager_removedHandler);
            }
            updateFrameVisibility(true);
            return;
        }// end function

        public function get debug() : Boolean
        {
            return _debug;
        }// end function

        protected function hitTestStageObject(param1:DisplayObject) : Boolean
        {
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            var _loc_4:* = new Point(this.x, this.y);
            var _loc_5:* = this.parent.localToGlobal(_loc_4);
            var _loc_6:* = this.parent.localToGlobal(_loc_4).x;
            var _loc_7:* = _loc_5.x + this.width;
            var _loc_8:* = param1.x;
            var _loc_9:* = param1.x + param1.width;
            _loc_2 = _loc_8 >= _loc_6 && _loc_8 <= _loc_7;
            _loc_2 = _loc_2 || _loc_8 <= _loc_6 && _loc_9 >= _loc_6;
            var _loc_10:* = _loc_5.y;
            var _loc_11:* = _loc_5.y + this.height;
            var _loc_12:* = param1.y;
            var _loc_13:* = param1.y + param1.height;
            _loc_3 = _loc_12 >= _loc_10 && _loc_12 <= _loc_11;
            _loc_3 = _loc_3 || _loc_12 <= _loc_10 && _loc_13 >= _loc_10;
            return _loc_2 && _loc_3;
        }// end function

        protected function showIFrame() : void
        {
            logger.info("Showing IFrame with id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_SHOWIFRAME, _frameId, _iframeId);
            return;
        }// end function

        protected function checkObjectId(param1:String, param2:Number) : Boolean
        {
            if (randomIdentificationString == param2)
            {
                return true;
            }
            return false;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            if (explicitVisibleValue != param1)
            {
                super.visible = param1;
                explicitVisibleValue = param1;
                updateFrameVisibility(param1);
            }
            return;
        }// end function

        public function bringIFrameToFront() : void
        {
            logger.info("Bring to front IFrame with id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_BRING_IFRAME_TO_FRONT, _frameId);
            return;
        }// end function

        public function set debug(param1:Boolean) : void
        {
            if (param1 == debug)
            {
                return;
            }
            if (param1)
            {
                if (!logTarget)
                {
                    logTarget = new TraceTarget();
                    logTarget.includeLevel = true;
                    logTarget.includeTime = true;
                    logTarget.level = LogEventLevel.ALL;
                    logTarget.filters = ["Flex-IFrame"];
                }
                logTarget.addLogger(logger);
            }
            else if (logTarget)
            {
                logTarget.removeLogger(logger);
            }
            _debug = param1;
            return;
        }// end function

        protected function hideIFrame() : void
        {
            logger.info("Hiding IFrame with id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_HIDEIFRAME, _frameId, _iframeId);
            return;
        }// end function

        protected function hideDiv() : void
        {
            logger.info("Hiding div with id \'{0}\'.", _frameId);
            ExternalInterface.call(IFrameExternalCalls.FUNCTION_HIDEDIV, _frameId);
            return;
        }// end function

        protected function buildContainerList() : void
        {
            var _loc_3:Number = NaN;
            containerDict = new Dictionary();
            settingDict = new Dictionary();
            var _loc_1:* = parent;
            var _loc_2:DisplayObjectContainer = this;
            while (_loc_1 != null)
            {
                
                if (_loc_1 is Container)
                {
                    if (_loc_1.contains(_loc_2))
                    {
                        _loc_3 = _loc_1.getChildIndex(_loc_2);
                        containerDict[_loc_1] = _loc_3;
                        settingDict[_loc_1] = _loc_1.hasOwnProperty("selectedIndex") ? (_loc_1["selectedIndex"]) : (_loc_3);
                        _loc_1.addEventListener(IndexChangedEvent.CHANGE, handleChange);
                        _loc_1.addEventListener(MoveEvent.MOVE, handleMove);
                    }
                }
                _loc_2 = _loc_1;
                _loc_1 = _loc_1.parent;
            }
            return;
        }// end function

        public function set content(param1:String) : void
        {
            if (param1)
            {
                _content = param1;
                invalidateProperties();
            }
            return;
        }// end function

        public function lookupSetting(param1:Container) : Number
        {
            var target:* = param1;
            var index:Number;
            try
            {
                index = settingDict[target];
            }
            catch (e:Error)
            {
                logger.debug(e.toString());
            }
            return index;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            super.updateDisplayList(param1, param2);
            if (_frameLoaded)
            {
                if (_loadIndicator)
                {
                    logger.debug("Frame with id \'{0}\' loaded, hiding the load indicator.", _frameId);
                    _loadIndicator.visible = false;
                }
                updateFrameVisibility(true);
            }
            else if (_loadIndicator)
            {
                logger.debug("Frame with id \'{0}\' not loaded, showing the load indicator.", _frameId);
                _loadIndicator.visible = true;
                _loc_3 = _loadIndicator.measuredWidth;
                _loc_4 = _loadIndicator.measuredHeight;
                _loadIndicator.setActualSize(_loc_3, _loc_4);
                _loadIndicator.move((this.width - _loc_3) / 2, (this.height - _loc_4) / 2);
            }
            if (_validForDisplay)
            {
                adjustPosition();
            }
            return;
        }// end function

        public function lookupIndex(param1:Container) : Number
        {
            var target:* = param1;
            var index:Number;
            try
            {
                index = containerDict[target];
            }
            catch (e:Error)
            {
                logger.debug(e.toString());
            }
            return index;
        }// end function

        public function get content() : String
        {
            return _content;
        }// end function

        public function callIFrameFunction(param1:String, param2:Array = null, param3:Function = null) : String
        {
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            if (!source)
            {
                throw new Error("No IFrame to call functions on");
            }
            if (_iframeContentHost != _appHost)
            {
                logger.warn("Warning: attempt to call function \'{0}\' on IFrame \'{1}\' may fail due to cross-domain security.", param1, _frameId);
            }
            if (_frameLoaded)
            {
                _loc_4 = ExternalInterface.call(IFrameExternalCalls.FUNCTION_CALLIFRAMEFUNCTION, _iframeId, param1, param2);
                if (param3 != null)
                {
                    //this.param3(_loc_4);
					param3(_loc_4);
                }
                return String(_loc_4);
            }
            else
            {
                _loc_5 = {functionName:param1, args:param2, callback:param3};
                _functionQueue.push(_loc_5);
                return null;
            }
        }// end function

        protected function handleChange(event:Event) : void
        {
            var _loc_3:IndexChangedEvent = null;
            var _loc_4:Number = NaN;
            var _loc_5:Boolean = false;
            var _loc_2:* = event.target;
            if (event is IndexChangedEvent)
            {
                _loc_3 = IndexChangedEvent(event);
                _loc_4 = _loc_3.newIndex;
                _loc_5 = updateFrameVisibility(checkDisplay(_loc_2, _loc_4));
                logger.debug("Frame {0} set visible to {1} on IndexChangedEvent", _frameId, _loc_5);
            }
            return;
        }// end function

    }
}
