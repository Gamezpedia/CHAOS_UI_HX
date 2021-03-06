package com.chaos.ui.layout;



import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.classInterface.IFitContainer;
import com.chaos.utils.Debug;

import com.chaos.ui.layout.FitContainerDirection;
import com.chaos.ui.layout.AlignmentBaseContainer;


/**
	 * This takes class makes sure everything fits.
	 * @author Erick Feiling
	 */

class FitContainer extends AlignmentBaseContainer implements IFitContainer implements IBaseContainer implements IBaseUI
{
    public var direction(get, set) : String;

    
    private var _mode : String;
    
    /**
		 * Create a container that fits all UI elements inside
		 */
    
    public function new(direction : String = "horizontal")
    {
        _mode = direction;
        super();
    }
    
    /**
		 * @inheritDoc
		 */
    
    override public function addElement(object : IBaseUI) : Void
    {
        
        super.addElement(object);
        resizeElements();
    }
    
    /**
		 * @inheritDoc
		 */
    
    override public function addElementList(list : Array<Dynamic>) : Void
    {
        
        super.addElementList(list);
        
        resizeElements();
    }
    
    /**
		 * @inheritDoc
		 */
    
    override public function removeElement(object : IBaseUI) : Void
    {
        
        super.removeElement(object);
        
        resizeElements();
    }
    
    /**
		 * @inheritDoc
		 */
    
    override public function draw() : Void
    {
        
        super.draw();
        
        resizeElements();
    }
    
    /**
	 * Set the mode using the FitContainerDirection
	 * @see com.chaos.ui.layout.FitContainerDirection
	 */
    
    private function set_direction(value : String) : String
    {
        _mode = value.toLowerCase();
        draw();
		
        return value;
    }
    
    /**
	 * Return the direction
	 */
	
    private function get_direction() : String
    {
        return _mode;
    }
    
    /**
	 * Resize based on the width and set height to size of container
	 * @private
	 */
    
    private function resizeElements() : Void
    {
        
        if (_mode == FitContainerDirection.HORIZONTAL || _mode == FitContainerDirection.VERTICAL) 
        {
            for (i in 0...contentObject.numChildren)
			{
                var element : IBaseUI = try cast(contentObject.getChildAt(i), IBaseUI) catch(e:Dynamic) null;
                
                if (_mode == FitContainerDirection.HORIZONTAL) 
                {
                    element.width = Std.int(width / contentObject.numChildren);
                    element.height = height;
                    element.x = contentObject.getChildAt(i).width * i;
                    element.y = 0;
                }
                else if (_mode == FitContainerDirection.VERTICAL) 
                {
                    element.width = width;
                    element.height = Std.int(height / contentObject.numChildren);
                    element.y = contentObject.getChildAt(i).height * i;
                    element.x = 0;
                }
            }
        }
        else 
        {
            Debug.print("[FitContainer::resizeElements] Was unable to resize items. Make sure HORIZONTAL or VERTICAL is being passed.");
        }
    }
}

