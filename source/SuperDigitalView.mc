using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;

class SuperDigitalView extends WatchUi.WatchFace {
	var customFont = null;
	var fontBerlin = null;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	customFont = WatchUi.loadResource(Rez.Fonts.customFont);
    	fontBerlin = WatchUi.loadResource(Rez.Fonts.berlin);
        //setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
    	dc.clear();
        // Get and show the current time
        var clockTime = System.getClockTime();
        var hour = clockTime.hour;
        if(!Sys.getDeviceSettings().is24Hour) {
        	hour = hour % 12;
        	if (hour == 0) {
        	hour = 12;
        	}
        }
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth()/2+50, dc.getHeight()/2-80, customFont, hour.toString(), Gfx.TEXT_JUSTIFY_RIGHT);
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth()/2+50, dc.getHeight()/2, customFont, Lang.format("$1$", [clockTime.min.format("%02d")]), Gfx.TEXT_JUSTIFY_RIGHT);
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, fontBerlin, "ian.grainger@gmail.com", Gfx.TEXT_JUSTIFY_CENTER);
//        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
//        var view = View.findDrawableById("TimeLabel");
//        view.setText(timeString);

        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
